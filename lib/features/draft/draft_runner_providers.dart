import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../api/lazy_sleeper_api.dart';
import '../../api/models/draft.dart';
import '../../api/providers.dart';
import '../../app/prefs.dart';

final _log = Logger('draft');

/// Drafts the API process currently knows about (`GET /draft`).
final knownDraftsProvider = FutureProvider<List<DraftSummary>>(
  (ref) => ref.watch(lazySleeperApiProvider).drafts(),
  retry: (retryCount, error) => null,
);

/// The Sleeper draft id the user is working with, remembered across
/// launches (draft night: type it once).
class DraftId extends Notifier<String> {
  static const prefsKey = 'draft_id';

  @override
  String build() =>
      ref.watch(sharedPreferencesProvider).getString(prefsKey) ?? '';

  Future<void> set(String id) async {
    final trimmed = id.trim();
    await ref.read(sharedPreferencesProvider).setString(prefsKey, trimmed);
    _log.info('draft id set to "$trimmed"');
    state = trimmed;
  }
}

final draftIdProvider = NotifierProvider<DraftId, String>(DraftId.new);

/// Outcome of the last start/stop call, for the screen to render.
sealed class RunnerOutcome {
  const RunnerOutcome();
}

class RunnerStarted extends RunnerOutcome {
  const RunnerStarted(this.result);

  final DraftStartOut result;
}

class RunnerStopped extends RunnerOutcome {
  const RunnerStopped(this.result);

  final DraftStopOut result;
}

class RunnerFailed extends RunnerOutcome {
  const RunnerFailed(this.message);

  final String message;
}

/// Drives `POST /draft/{id}/start|stop`. State is null until the first call;
/// `isLoading` while a call is in flight.
class DraftRunner extends Notifier<AsyncValue<RunnerOutcome?>> {
  @override
  AsyncValue<RunnerOutcome?> build() => const AsyncData(null);

  Future<void> start(String draftId, {int season = 2026}) =>
      _call('start draft $draftId season=$season', () async {
        final out = await ref
            .read(lazySleeperApiProvider)
            .startDraft(draftId, season: season);
        _log.info(
          'runner started: running=${out.running} '
          'alreadyRunning=${out.alreadyRunning} picksMade=${out.picksMade} '
          'boardRows=${out.boardRows}',
        );
        return RunnerStarted(out);
      });

  Future<void> stop(String draftId) => _call('stop draft $draftId', () async {
    final out = await ref.read(lazySleeperApiProvider).stopDraft(draftId);
    _log.info('runner stopped: running=${out.running}');
    return RunnerStopped(out);
  });

  Future<void> _call(
    String what,
    Future<RunnerOutcome> Function() action,
  ) async {
    _log.info(what);
    state = const AsyncLoading();
    try {
      state = AsyncData(await action());
    } on ApiException catch (e) {
      _log.warning('$what failed: ${e.message}');
      state = AsyncData(RunnerFailed(e.message));
    }
    ref.invalidate(knownDraftsProvider);
  }
}

final draftRunnerProvider =
    NotifierProvider<DraftRunner, AsyncValue<RunnerOutcome?>>(DraftRunner.new);
