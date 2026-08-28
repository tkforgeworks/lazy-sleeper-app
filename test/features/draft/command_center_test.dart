import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/fixture_api.dart';
import 'package:lazy_sleeper_app/api/models/draft_state.dart';
import 'package:lazy_sleeper_app/features/draft/draft_clock.dart';
import 'package:lazy_sleeper_app/app/widgets/atoms.dart';
import 'package:lazy_sleeper_app/features/draft/draft_runner_providers.dart';
import 'package:lazy_sleeper_app/features/draft/widgets/best_available.dart';
import 'package:lazy_sleeper_app/features/draft/widgets/draft_runner_card.dart';
import 'package:lazy_sleeper_app/features/draft/widgets/pick_ticker.dart';

import '../../support.dart';
import 'draft_screen_test.dart' show openDraft;

/// The app on the Draft tab with `/state` answering [state].
///
/// The clock is frozen 95 s before the pick deadline unless [overrides]
/// pins [nowProvider] itself — the captures' deadlines are long past.
Future<void> pumpLive(
  WidgetTester tester,
  Size size,
  DraftState state, {
  List<Override>? overrides,
}) async {
  final deadline = state.clock.pickDeadline;
  final frozen = deadline?.subtract(const Duration(seconds: 95));
  await pumpApp(
    tester,
    size,
    api: FakeLazySleeperApi(onState: (id, position, limit) async => state),
    prefs: {DraftId.prefsKey: state.draftId},
    overrides:
        overrides ??
        [if (frozen != null) nowProvider.overrideWithValue(() => frozen)],
  );
  if (size == mobileSize) {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Draft'),
      ),
    );
    await tester.pumpAndSettle();
  } else {
    await openDraft(tester);
  }
}

void main() {
  final myTurn = loadDraftState(FixtureLazySleeperApi.draftStateMyTurn);
  final complete = loadDraftState(FixtureLazySleeperApi.draftStateComplete);

  testWidgets('desktop: header, roster, best available, ticker', (
    tester,
  ) async {
    await pumpLive(tester, desktopSize, myTurn);

    // Header from the clock.
    expect(find.text('Pick 2.11'), findsOneWidget);
    expect(find.text('overall 23 · round 2 of 15'), findsOneWidget);
    expect(find.text('ON THE CLOCK · TINY T TERRORS'), findsOneWidget);
    expect(find.text('YOU'), findsOneWidget);
    expect(find.text('ON THE CLOCK'), findsOneWidget);
    expect(find.text('drafting'), findsOneWidget, reason: 'health dot');

    // Roster strip: 10 lineup seats, my one pick filled.
    expect(find.byType(RosterSlotChip), findsNWidgets(10));
    expect(find.text('Bijan Robinson'), findsOneWidget);
    expect(find.text('bench 0 of 5'), findsOneWidget);

    // Best available in served (pick_score) order, with signals.
    expect(find.byType(BestAvailableTable), findsOneWidget);
    expect(find.text('SURVIVAL → pick 23'), findsOneWidget);
    // The top pick shows in the recommendation card and as row 1.
    expect(find.text('Nico Collins'), findsNWidgets(2));
    final first = find.text('Nico Collins').last;
    // The card's sub-line carries the bye; the table has a BYE column and
    // its sub-line drops it.
    expect(find.text('HOU · WR8 · bye 8'), findsOneWidget);
    expect(find.text('HOU · WR8'), findsOneWidget);
    expect(find.text('BYE'), findsOneWidget);
    expect(find.byType(SurvivalBar), findsWidgets);
    expect(find.text('RUN'), findsWidgets);
    expect(
      tester.getTopLeft(first).dy,
      lessThan(tester.getTopLeft(find.text(myTurn.rows[1].name).last).dy),
    );

    // Ticker, most recent first.
    expect(find.byType(PickTicker), findsOneWidget);
    expect(find.text('22'), findsOneWidget);
    expect(find.textContaining('Brock Bowers'), findsOneWidget);
  });

  testWidgets('desktop: the runner lives in a dialog now', (tester) async {
    await pumpLive(tester, desktopSize, myTurn);
    expect(find.byType(DraftRunnerPanel), findsNothing);

    await tester.tap(find.text('runner'));
    await tester.pumpAndSettle();

    expect(find.byType(DraftRunnerPanel), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller?.text,
      myTurn.draftId,
    );
  });

  testWidgets('a complete draft reads as done', (tester) async {
    await pumpLive(tester, desktopSize, complete);

    expect(find.text('Pick —'), findsOneWidget);
    expect(find.text('180 picks · draft complete'), findsOneWidget);
    expect(find.text('ON THE CLOCK · DRAFT COMPLETE'), findsOneWidget);
    expect(find.text('ALL DONE'), findsOneWidget);
  });

  testWidgets('stale advice and a dead runner are called out', (tester) async {
    final stale = myTurn.copyWith(
      recompute: myTurn.recompute.copyWith(stale: true, error: 'boom'),
    );
    await pumpLive(tester, desktopSize, stale);

    expect(find.text('stale advice'), findsOneWidget);
    expect(
      find.text('Advice is from before the latest pick: boom.'),
      findsOneWidget,
    );
  });

  testWidgets('no roster yet explains itself', (tester) async {
    await pumpLive(tester, desktopSize, myTurn.copyWith(myRoster: null));

    expect(find.byType(RosterSlotChip), findsNothing);
    expect(
      find.textContaining('has not assigned your slot yet'),
      findsOneWidget,
    );
  });

  testWidgets('mobile: compact header, list rows, ticker', (tester) async {
    await pumpLive(tester, mobileSize, myTurn);

    expect(find.text('Pick 2.11'), findsOneWidget);
    expect(find.text('YOU'), findsOneWidget);
    expect(find.text('BEST AVAILABLE'), findsOneWidget);
    expect(find.byType(BestAvailableTable), findsNothing);
    expect(find.byType(BestAvailableList), findsOneWidget);
    expect(find.text('Nico Collins'), findsNWidgets(2), reason: 'card + row');
    expect(find.byType(RosterSlotChip), findsWidgets);
  });
}
