import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/fixture_api.dart';
import 'package:lazy_sleeper_app/features/draft/draft_clock.dart';
import 'package:lazy_sleeper_app/features/draft/widgets/alert_cards.dart';
import 'package:lazy_sleeper_app/features/draft/widgets/panic_overlay.dart';
import 'package:lazy_sleeper_app/features/draft/widgets/recommendation_card.dart';
import 'package:lazy_sleeper_app/features/draft/widgets/timer_block.dart';

import '../../support.dart';
import 'command_center_test.dart' show pumpLive;

void main() {
  final myTurn = loadDraftState(FixtureLazySleeperApi.draftStateMyTurn);
  final mid = loadDraftState(FixtureLazySleeperApi.draftStateMid);
  final deadline = myTurn.clock.pickDeadline!;

  /// A clock frozen at [secondsLeft] before the deadline, advancing only
  /// when the test moves [now].
  DateTime now = deadline;
  final frozen = nowProvider.overrideWithValue(() => now);

  testWidgets('the timer ticks down once a second from the deadline', (
    tester,
  ) async {
    now = deadline.subtract(const Duration(seconds: 95));
    await pumpLive(tester, desktopSize, myTurn, overrides: [frozen]);

    expect(find.byType(TimerBlock), findsOneWidget);
    expect(find.text('95s'), findsOneWidget);

    now = deadline.subtract(const Duration(seconds: 94));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('94s'), findsOneWidget);
    expect(find.byType(PanicOverlay), findsNothing);
  });

  testWidgets('panic fires at my turn with 30 s left and taps away', (
    tester,
  ) async {
    now = deadline.subtract(const Duration(seconds: 31));
    await pumpLive(tester, desktopSize, myTurn, overrides: [frozen]);
    expect(find.byType(PanicOverlay), findsNothing);

    now = deadline.subtract(const Duration(seconds: 30));
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(PanicOverlay), findsOneWidget);
    expect(find.text('30S · YOU ARE ON THE CLOCK'), findsOneWidget);
    expect(find.text('Nico Collins'), findsWidgets);
    expect(
      find.text('Make the pick in Sleeper. This screen only points.'),
      findsOneWidget,
    );
    expect(find.textContaining("if he's gone: Rashee Rice"), findsOneWidget);

    await tester.tap(find.byType(PanicOverlay));
    await tester.pump();

    expect(find.byType(PanicOverlay), findsNothing);

    now = deadline.subtract(const Duration(seconds: 10));
    await tester.pump(const Duration(seconds: 1));
    expect(
      find.byType(PanicOverlay),
      findsNothing,
      reason: 'dismissed for this pick',
    );
  });

  testWidgets('no panic when it is not my turn', (tester) async {
    now = mid.clock.pickDeadline!.subtract(const Duration(seconds: 5));
    await pumpLive(tester, desktopSize, mid, overrides: [frozen]);

    expect(find.text('5s'), findsOneWidget);
    expect(find.byType(PanicOverlay), findsNothing);
  });

  testWidgets('no countdown without a deadline', (tester) async {
    await pumpLive(
      tester,
      desktopSize,
      myTurn.copyWith(clock: myTurn.clock.copyWith(pickDeadline: null)),
      overrides: [frozen],
    );

    expect(find.byType(TimerBlock), findsOneWidget);
    expect(find.byType(PanicOverlay), findsNothing);
  });

  testWidgets('recommendation card: live at my turn, idle otherwise', (
    tester,
  ) async {
    now = deadline.subtract(const Duration(minutes: 2));
    await pumpLive(tester, desktopSize, myTurn, overrides: [frozen]);

    expect(find.byType(RecommendationCard), findsOneWidget);
    expect(find.text('YOUR PICK · MAKE IT IN SLEEPER'), findsOneWidget);
    expect(find.text('Nico Collins'), findsNWidgets(2), reason: 'card + row');
    expect(find.text('Rashee Rice'), findsNWidgets(2), reason: 'alt + row');
    expect(
      find.text('T6 WR, 84 VORP, 32% to survive to your next pick.'),
      findsOneWidget,
    );
  });

  testWidgets('idle card and alerts in the rail', (tester) async {
    await pumpLive(tester, desktopSize, mid, overrides: [frozen]);

    expect(find.text('IF YOU WERE UP NOW'), findsOneWidget);
    expect(find.byType(AlertCard), findsWidgets);
    expect(find.text('Tier cliff at RB'), findsOneWidget);
    expect(find.text('Injury watch'), findsOneWidget);
  });

  testWidgets('mobile shows alert chips and the compact card', (tester) async {
    await pumpLive(tester, mobileSize, mid, overrides: [frozen]);

    expect(find.byType(AlertChip), findsWidgets);
    expect(find.byType(RecommendationCard), findsOneWidget);
    expect(find.byType(TimerBlock), findsOneWidget);
  });
}
