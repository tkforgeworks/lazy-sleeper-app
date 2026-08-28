import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../api/lazy_sleeper_api.dart';
import '../../api/models/draft_state.dart';
import '../../api/providers.dart';
import 'draft_runner_providers.dart';

final _log = Logger('draft');

/// How often `/state` is polled. The GUIDE says ~2 s and not faster; the
/// timer ticks locally in between.
final draftPollIntervalProvider = Provider<Duration>(
  (_) => const Duration(seconds: 2),
);

/// Rows requested per poll: enough for the best-available table.
const draftStateRowLimit = 40;

enum DraftLivePhase {
  /// No draft id yet.
  idle,

  /// Polling, nothing received so far.
  connecting,

  /// Last poll succeeded.
  live,

  /// `/state` answered 404: the runner is not up for this id.
  notRunning,

  /// Last poll failed for another reason; [DraftLive.state] is kept.
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
/// watches it. Rebuilds (and restarts) when the id or the API client change.
class DraftLiveNotifier extends Notifier<DraftLive> {
  Timer? _timer;
  bool _inFlight = false;

  @override
  DraftLive build() {
    final id = ref.watch(draftIdProvider);
    final api = ref.watch(lazySleeperApiProvider);
    final interval = ref.watch(draftPollIntervalProvider);
    _timer?.cancel();
    _timer = null;
    if (id.isEmpty) return const DraftLive();

    _log.info('live: polling draft $id every ${interval.inSeconds} s');
    _timer = Timer.periodic(interval, (_) => _poll(api, id));
    ref.onDispose(() {
      _timer?.cancel();
      _timer = null;
    });
    // First poll right away; the timer takes over from there.
    Future<void>.microtask(() => _poll(api, id));
    return const DraftLive(phase: DraftLivePhase.connecting);
  }

  /// Poll now instead of waiting for the next tick (after `start`).
  Future<void> refresh() =>
      _poll(ref.read(lazySleeperApiProvider), ref.read(draftIdProvider));

  Future<void> _poll(LazySleeperApi api, String id) async {
    if (_inFlight || id.isEmpty) return;
    _inFlight = true;
    try {
      final next = await api.draftState(id, limit: draftStateRowLimit);
      if (!ref.mounted) return;
      final now = DateTime.now();
      final previous = state.state;
      final changed =
          previous == null || previous.recompute.seq != next.recompute.seq;
      if (changed) {
        _log.fine(
          'live: seq ${next.recompute.seq} pick ${next.clock.currentPick} '
          'on_the_clock ${next.clock.onTheClock} my_turn ${next.clock.myTurn} '
          'poller ${next.poller.status}',
        );
      }
      state = state.copyWith(
        state: changed ? next : previous,
        phase: DraftLivePhase.live,
        polledAt: now,
        clearError: true,
      );
    } on ApiException catch (e) {
      if (!ref.mounted) return;
      final notRunning = e.statusCode == 404;
      if (state.phase !=
          (notRunning ? DraftLivePhase.notRunning : DraftLivePhase.error)) {
        _log.warning('live: poll failed: ${e.message}');
      }
      state = state.copyWith(
        phase: notRunning ? DraftLivePhase.notRunning : DraftLivePhase.error,
        error: e.message,
        polledAt: DateTime.now(),
      );
    } finally {
      _inFlight = false;
    }
  }
}

final draftLiveProvider = NotifierProvider<DraftLiveNotifier, DraftLive>(
  DraftLiveNotifier.new,
);
