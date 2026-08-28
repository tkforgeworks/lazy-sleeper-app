import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/fixture_api.dart';
import 'package:lazy_sleeper_app/api/lazy_sleeper_api.dart';
import 'package:lazy_sleeper_app/api/models/draft.dart';
import 'package:lazy_sleeper_app/app/app.dart';
import 'package:lazy_sleeper_app/app/settings/app_settings.dart';
import 'package:lazy_sleeper_app/features/draft/draft_live_providers.dart';
import 'package:lazy_sleeper_app/features/draft/draft_runner_providers.dart';

import '../../support.dart';
import 'draft_screen_test.dart' show openDraft;

ProviderContainer _container(WidgetTester tester) =>
    ProviderScope.containerOf(tester.element(find.byType(LazySleeperApp)));

const _tick = Duration(seconds: 2);

void main() {
  testWidgets('polls every 2 s and only swaps the state when seq moves', (
    tester,
  ) async {
    final base = loadDraftState();
    var calls = 0;
    var seq = base.recompute.seq;
    var pick = base.clock.currentPick;
    final api = FakeLazySleeperApi(
      onState: (id, position, limit) async {
        calls++;
        return base.copyWith(
          recompute: base.recompute.copyWith(seq: seq),
          clock: base.clock.copyWith(currentPick: pick),
        );
      },
    );
    await pumpApp(
      tester,
      desktopSize,
      api: api,
      prefs: {DraftId.prefsKey: '42'},
    );
    await openDraft(tester);

    final live = _container(tester).read(draftLiveProvider);
    expect(live.phase, DraftLivePhase.live);
    expect(calls, 1, reason: 'first poll is immediate');
    expect(find.text('Pick 2.11'), findsOneWidget);
    expect(find.text('YOU'), findsOneWidget);

    await tester.pump(_tick);
    await tester.pump();
    expect(calls, 2);
    expect(
      identical(_container(tester).read(draftLiveProvider).state, live.state),
      isTrue,
      reason: 'unchanged seq keeps the same object',
    );

    seq++;
    pick++;
    await tester.pump(_tick);
    await tester.pump();
    expect(calls, 3);
    expect(
      identical(_container(tester).read(draftLiveProvider).state, live.state),
      isFalse,
    );
    expect(find.text('Pick 2.12'), findsOneWidget);
  });

  testWidgets('404 stops polling until the runner is started', (tester) async {
    var calls = 0;
    var up = false;
    final api = FakeLazySleeperApi(
      onState: (id, position, limit) async {
        calls++;
        if (!up) throw const ApiException('not running', statusCode: 404);
        return loadDraftState();
      },
      onStart: (id, season) async {
        up = true;
        return DraftStartOutStub.from(id, season);
      },
    );
    await pumpApp(
      tester,
      desktopSize,
      api: api,
      prefs: {DraftId.prefsKey: '42'},
    );
    await openDraft(tester);

    expect(
      _container(tester).read(draftLiveProvider).phase,
      DraftLivePhase.notRunning,
    );
    expect(find.textContaining('Runner not up'), findsOneWidget);

    await tester.pump(_tick * 5);
    expect(calls, 1, reason: 'no retry loop against a dead runner');

    await tester.tap(find.text('Start runner'));
    await tester.pump();
    await tester.pump();

    expect(
      _container(tester).read(draftLiveProvider).phase,
      DraftLivePhase.live,
    );
    expect(find.text('Pick 2.11'), findsOneWidget);
    await tester.pump(_tick);
    await tester.pump();
    expect(calls, 3, reason: 'live again: polling resumed');
  });

  testWidgets('a stopped or complete draft is fetched once, then left', (
    tester,
  ) async {
    var calls = 0;
    final stopped = loadDraftState(FixtureLazySleeperApi.draftStateMyTurn)
        .copyWith(running: false);
    final api = FakeLazySleeperApi(
      onState: (id, position, limit) async {
        calls++;
        return stopped;
      },
    );
    await pumpApp(
      tester,
      desktopSize,
      api: api,
      prefs: {DraftId.prefsKey: '42'},
    );
    await openDraft(tester);

    final live = _container(tester).read(draftLiveProvider);
    expect(live.phase, DraftLivePhase.stopped);
    expect(live.state, isNotNull, reason: 'still viewable');
    expect(find.text('Pick 2.11'), findsOneWidget);
    expect(find.text('runner stopped'), findsOneWidget);
    expect(find.textContaining('polling is paused'), findsOneWidget);

    await tester.pump(_tick * 10);
    expect(calls, 1);

    // A complete draft reads as complete, not as a stopped runner.
    final complete = loadDraftState(FixtureLazySleeperApi.draftStateComplete);
    expect(complete.running, isFalse);
  });

  testWidgets('failed polls back off: 2, 4, 8 s', (tester) async {
    var fail = false;
    final times = <Duration>[];
    var elapsed = Duration.zero;
    final api = FakeLazySleeperApi(
      onState: (id, position, limit) async {
        times.add(elapsed);
        if (fail) throw const ApiException('Could not reach the API: refused');
        return loadDraftState();
      },
    );
    await pumpApp(
      tester,
      desktopSize,
      api: api,
      prefs: {DraftId.prefsKey: '42'},
    );
    await openDraft(tester);
    fail = true;

    Future<void> advance(Duration d) async {
      elapsed += d;
      await tester.pump(d);
      await tester.pump();
    }

    await advance(_tick); // 2 s: fails → retry in 2
    await advance(_tick); // 4 s: fails → retry in 4
    await advance(_tick); // 6 s: nothing due
    await advance(_tick); // 8 s: fails → retry in 8
    await advance(_tick * 3); // 14 s: nothing due
    await advance(_tick); // 16 s: fails

    expect(times.map((t) => t.inSeconds), [0, 2, 4, 8, 16]);
    expect(
      _container(tester).read(draftLiveProvider).phase,
      DraftLivePhase.error,
    );
    expect(find.text('poll failed'), findsOneWidget);
    expect(find.textContaining('Retrying with back-off'), findsOneWidget);
  });

  testWidgets('a new poll interval reschedules without blanking the state', (
    tester,
  ) async {
    var calls = 0;
    final api = FakeLazySleeperApi(
      onState: (id, position, limit) async {
        calls++;
        return loadDraftState();
      },
    );
    await pumpApp(
      tester,
      desktopSize,
      api: api,
      prefs: {DraftId.prefsKey: '42'},
    );
    await openDraft(tester);
    final before = _container(tester).read(draftLiveProvider);
    expect(calls, 1);

    await _container(tester)
        .read(appSettingsProvider.notifier)
        .setPollInterval(1);
    await tester.pump();

    final after = _container(tester).read(draftLiveProvider);
    expect(identical(after.state, before.state), isTrue, reason: 'kept');
    expect(after.phase, DraftLivePhase.live);
    expect(find.text('Pick 2.11'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    expect(calls, 2, reason: 'next poll came 1 s after the change');
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    expect(calls, 3);
  });

  testWidgets('the row limit setting is what /state is asked for', (
    tester,
  ) async {
    final limits = <int?>[];
    final api = FakeLazySleeperApi(
      onState: (id, position, limit) async {
        limits.add(limit);
        return loadDraftState();
      },
    );
    await pumpApp(
      tester,
      desktopSize,
      api: api,
      prefs: {DraftId.prefsKey: '42', AppSettings.rowLimitKey: 20},
    );
    await openDraft(tester);
    expect(limits, [20]);

    await _container(tester).read(appSettingsProvider.notifier).setRowLimit(60);
    await tester.pump(_tick);
    await tester.pump();
    expect(limits, [20, 60]);
    expect(find.text('Pick 2.11'), findsOneWidget);
  });

  testWidgets('no id, no polling', (tester) async {
    var calls = 0;
    final api = FakeLazySleeperApi(
      onState: (id, position, limit) async {
        calls++;
        return loadDraftState();
      },
    );
    await pumpApp(tester, desktopSize, api: api);
    await openDraft(tester);
    await tester.pump(_tick);

    expect(
      _container(tester).read(draftLiveProvider).phase,
      DraftLivePhase.idle,
    );
    expect(calls, 0);
    expect(find.textContaining('Give it a draft id'), findsOneWidget);
  });

  testWidgets('starting the runner polls right away', (tester) async {
    var running = false;
    final api = FakeLazySleeperApi(
      onStart: (id, season) async {
        running = true;
        return DraftStartOutStub.from(id, season);
      },
      onState: (id, position, limit) async {
        if (!running) throw const ApiException('nope', statusCode: 404);
        return loadDraftState();
      },
    );
    await pumpApp(
      tester,
      desktopSize,
      api: api,
      prefs: {DraftId.prefsKey: '42'},
    );
    await openDraft(tester);
    expect(find.textContaining('Runner not up'), findsOneWidget);

    await tester.tap(find.text('Start runner'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Pick 2.11'), findsOneWidget);
  });
}

/// The runner's start answer, shaped like the server's.
abstract final class DraftStartOutStub {
  static DraftStartOut from(String id, int season) => DraftStartOut(
    draftId: id,
    season: season,
    running: true,
    alreadyRunning: false,
    mySlot: 2,
    picksMade: 22,
    boardRows: 672,
  );
}
