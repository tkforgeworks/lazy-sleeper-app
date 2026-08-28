import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/lazy_sleeper_api.dart';
import '../../api/models/draft.dart';
import '../../api/providers.dart';
import '../../app/prefs.dart';

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

  Future<void> start(String draftId, {int season = 2026}) => _call(
    () async => RunnerStarted(
      await ref
          .read(lazySleeperApiProvider)
          .startDraft(draftId, season: season),
    ),
  );

  Future<void> stop(String draftId) => _call(
    () async => RunnerStopped(
      await ref.read(lazySleeperApiProvider).stopDraft(draftId),
    ),
  );

  Future<void> _call(Future<RunnerOutcome> Function() action) async {
    state = const AsyncLoading();
    try {
      state = AsyncData(await action());
    } on ApiException catch (e) {
      state = AsyncData(RunnerFailed(e.message));
    }
    ref.invalidate(knownDraftsProvider);
  }
}

final draftRunnerProvider =
    NotifierProvider<DraftRunner, AsyncValue<RunnerOutcome?>>(DraftRunner.new);
