import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/lazy_sleeper_api.dart';
import 'package:lazy_sleeper_app/api/models/draft.dart';
import 'package:lazy_sleeper_app/app/app.dart';
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
    final api = FakeLazySleeperApi(
      onState: (id, position, limit) async {
        calls++;
        return base.copyWith(recompute: base.recompute.copyWith(seq: seq));
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
    expect(find.textContaining('YOUR TURN'), findsOneWidget);
    expect(find.textContaining('seq 76'), findsOneWidget);

    await tester.pump(_tick);
    await tester.pump();
    expect(calls, 2);
    expect(
      identical(_container(tester).read(draftLiveProvider).state, live.state),
      isTrue,
      reason: 'unchanged seq keeps the same object',
    );

    seq++;
    await tester.pump(_tick);
    await tester.pump();
    expect(calls, 3);
    expect(
      identical(_container(tester).read(draftLiveProvider).state, live.state),
      isFalse,
    );
    expect(find.textContaining('seq 77'), findsOneWidget);
  });

  testWidgets('404 means the runner is not up; a later 200 recovers', (
    tester,
  ) async {
    var up = false;
    final api = FakeLazySleeperApi(
      onState: (id, position, limit) async {
        if (!up) {
          throw const ApiException('not running', statusCode: 404);
        }
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

    expect(
      _container(tester).read(draftLiveProvider).phase,
      DraftLivePhase.notRunning,
    );
    expect(find.textContaining('Runner not up'), findsOneWidget);

    up = true;
    await tester.pump(_tick);
    await tester.pump();

    expect(
      _container(tester).read(draftLiveProvider).phase,
      DraftLivePhase.live,
    );
    expect(find.textContaining('Live · drafting'), findsOneWidget);
  });

  testWidgets('a failed poll keeps the last good state and says so', (
    tester,
  ) async {
    var fail = false;
    final api = FakeLazySleeperApi(
      onState: (id, position, limit) async {
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
    final good = _container(tester).read(draftLiveProvider).state;

    fail = true;
    await tester.pump(_tick);
    await tester.pump();

    final live = _container(tester).read(draftLiveProvider);
    expect(live.phase, DraftLivePhase.error);
    expect(identical(live.state, good), isTrue);
    expect(find.textContaining('showing the last good state'), findsOneWidget);
    expect(find.textContaining('Could not reach the API'), findsOneWidget);
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
    expect(find.text('No draft id yet.'), findsOneWidget);
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

    expect(find.textContaining('Live · drafting'), findsOneWidget);
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
