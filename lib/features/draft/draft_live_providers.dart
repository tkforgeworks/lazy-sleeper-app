import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../api/lazy_sleeper_api.dart';
import '../../api/models/draft_state.dart';
import '../../api/providers.dart';
import '../../app/settings/app_settings.dart';
import 'draft_runner_providers.dart';

export '../../app/settings/app_settings.dart'
    show draftPollIntervalProvider, draftStateRowLimitProvider;

final _log = Logger('draft');

/// Longest wait between retries after failed polls (the poll interval
/// doubling up to it).
const draftPollMaxBackoff = Duration(seconds: 30);

enum DraftLivePhase {
  /// No draft id yet.
  idle,

  /// Polling, nothing received so far.
  connecting,

  /// Last poll succeeded and the runner is up; polling continues.
  live,

  /// The backend knows the draft but its runner is not running (stopped,
  /// complete, or it gave up). [DraftLive.state] is kept for viewing;
  /// polling stops until the runner is started again.
  stopped,

  /// `/state` answered 404: the runner is not up for this id. Polling
  /// stops until the runner is started.
  notRunning,

  /// Last poll failed for another reason; [DraftLive.state] is kept and
  /// polling retries with back-off.
  error,
}

/// What the Draft screen renders from: the last good payload and what the
/// most recent poll said about it.
@immutable
class DraftLive {
  const DraftLive({
    this.state,
    this.phase = DraftLivePhase.idle,
    this.error,
    this.polledAt,
  });

  /// Last good state. Replaced only when `recompute.seq` moves, so
  /// widgets watching it rebuild once per recompute, not once per poll.
  final DraftState? state;
  final DraftLivePhase phase;
  final String? error;
  final DateTime? polledAt;

  /// True while a timer is scheduled: live, or retrying after an error.
  bool get polling =>
      phase == DraftLivePhase.live ||
      phase == DraftLivePhase.connecting ||
      phase == DraftLivePhase.error;

  DraftLive copyWith({
    DraftState? state,
    DraftLivePhase? phase,
    String? error,
    DateTime? polledAt,
    bool clearError = false,
  }) => DraftLive(
    state: state ?? this.state,
    phase: phase ?? this.phase,
    error: clearError ? null : error ?? this.error,
    polledAt: polledAt ?? this.polledAt,
  );
}

/// Polls `/draft/{id}/state` for the remembered draft id while anything
/// watches it and the runner is up. A stopped, complete or unknown draft is
/// fetched once and then left alone — no retry loop against a dead
/// runner — until [refresh] (the Start button) kicks it off again. Failed
/// polls retry with doubling back-off, capped at [draftPollMaxBackoff].
///
/// The poll interval and row limit are settings: a change reschedules the
/// next poll (or reaches it) without rebuilding this notifier, so the last
/// good state stays on screen.
class DraftLiveNotifier extends Notifier<DraftLive> {
  Timer? _timer;
  bool _inFlight = false;
  int _failures = 0;

  @override
  DraftLive build() {
    final id = ref.watch(draftIdProvider);
    final api = ref.watch(lazySleeperApiProvider);
    ref.listen(draftPollIntervalProvider, (_, next) {
      if (_timer != null && state.phase == DraftLivePhase.live) {
        _log.info('live: poll interval now ${next.inSeconds} s');
        _schedule(api, id, next);
      }
    });
    _cancel();
    _failures = 0;
    ref.onDispose(_cancel);
    if (id.isEmpty) return const DraftLive();

    _log.info('live: polling draft $id');
    // First poll right away; each poll schedules the next while warranted.
    Future<void>.microtask(() => _poll(api, id));
    return const DraftLive(phase: DraftLivePhase.connecting);
  }

  /// Poll now and resume polling (after `start`, or a manual retry).
  Future<void> refresh() {
    _cancel();
    _failures = 0;
    return _poll(ref.read(lazySleeperApiProvider), ref.read(draftIdProvider));
  }

  void _cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void _schedule(LazySleeperApi api, String id, Duration delay) {
    _cancel();
    _timer = Timer(delay, () => _poll(api, id));
  }

  Duration get _backoff {
    final base = ref.read(draftPollIntervalProvider);
    final scaled = base * math.pow(2, _failures - 1).toInt();
    return scaled > draftPollMaxBackoff ? draftPollMaxBackoff : scaled;
  }

  Future<void> _poll(LazySleeperApi api, String id) async {
    if (_inFlight || id.isEmpty) return;
    _inFlight = true;
    try {
      final next = await api.draftState(
        id,
        limit: ref.read(draftStateRowLimitProvider),
      );
      if (!ref.mounted) return;
      _failures = 0;
      final previous = state.state;
      // Swap on a new recompute — or on a changed row limit, which the
      // same recompute answers with a different depth.
      final changed =
          previous == null ||
          previous.recompute.seq != next.recompute.seq ||
          previous.rows.length != next.rows.length;
      if (changed) {
        _log.fine(
          'live: seq ${next.recompute.seq} pick ${next.clock.currentPick} '
          'on_the_clock ${next.clock.onTheClock} my_turn ${next.clock.myTurn} '
          'poller ${next.poller.status}',
        );
      }
      final up = _runnerUp(next);
      if (!up && state.phase != DraftLivePhase.stopped) {
        _log.info(
          'live: runner for draft $id is not running '
          '(poller ${next.poller.status}, complete ${next.clock.complete}'
          '${next.poller.runnerError == null ? '' : ', error: ${next.poller.runnerError}'}'
          '); polling stops until it is started',
        );
      }
      state = state.copyWith(
        state: changed ? next : previous,
        phase: up ? DraftLivePhase.live : DraftLivePhase.stopped,
        polledAt: DateTime.now(),
        clearError: true,
      );
      if (up) _schedule(api, id, ref.read(draftPollIntervalProvider));
    } on ApiException catch (e) {
      if (!ref.mounted) return;
      if (e.statusCode == 404) {
        if (state.phase != DraftLivePhase.notRunning) {
          _log.info('live: ${e.message}; polling stops until it is started');
        }
        state = state.copyWith(
          phase: DraftLivePhase.notRunning,
          error: e.message,
          polledAt: DateTime.now(),
        );
        return;
      }
      _failures++;
      final delay = _backoff;
      _log.warning(
        'live: poll failed (${e.message}); retry in ${delay.inSeconds} s',
      );
      state = state.copyWith(
        phase: DraftLivePhase.error,
        error: e.message,
        polledAt: DateTime.now(),
      );
      _schedule(api, id, delay);
    } finally {
      _inFlight = false;
    }
  }

  /// `running` is the server's word; a complete draft or a runner that gave
  /// up (`poller.runner_error`) is over even if the flag lags.
  static bool _runnerUp(DraftState s) =>
      (s.running ?? true) && !s.clock.complete && s.poller.runnerError == null;
}

final draftLiveProvider = NotifierProvider<DraftLiveNotifier, DraftLive>(
  DraftLiveNotifier.new,
);
