import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/app/widgets/atoms.dart';
import 'package:lazy_sleeper_app/features/board/board_view.dart';
import 'package:lazy_sleeper_app/features/board/widgets/player_detail.dart';

import '../../support.dart';

void main() {
  group('desktop', () {
    testWidgets('renders the board in ensemble order, no tier breaks on ALL', (
      tester,
    ) async {
      await pumpApp(tester, desktopSize);

      expect(find.text('Jahmyr Gibbs'), findsOneWidget);
      expect(find.textContaining('TIER 1'), findsNothing);
      expect(find.textContaining('players'), findsOneWidget);
    });

    testWidgets('position chips filter the rows and reveal tier breaks', (
      tester,
    ) async {
      await pumpApp(tester, desktopSize);

      await tester.tap(find.widgetWithText(LsFilterChip, 'QB'));
      await tester.pumpAndSettle();

      expect(find.text('Jahmyr Gibbs'), findsNothing);
      expect(find.byType(PosChip), findsWidgets);
      for (final chip in tester.widgetList<PosChip>(find.byType(PosChip))) {
        expect(chip.position, 'QB');
      }
      expect(find.text('TIER 1'), findsOneWidget);
    });

    testWidgets('a non-ensemble sort hides tier breaks and re-ranks', (
      tester,
    ) async {
      await pumpApp(tester, desktopSize);
      await tester.tap(find.widgetWithText(LsFilterChip, 'RB'));
      await tester.pumpAndSettle();
      expect(find.text('TIER 1'), findsOneWidget);

      await tester.tap(
        find.descendant(
          of: find.byType(SegmentedTabs<BoardSort>),
          matching: find.text('ADP'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('TIER 1'), findsNothing);
      expect(find.text('Jahmyr Gibbs'), findsOneWidget);
    });

    testWidgets('tapping a row opens the drawer; close dismisses it', (
      tester,
    ) async {
      await pumpApp(tester, desktopSize);

      await tester.tap(find.text('Jahmyr Gibbs'));
      await tester.pumpAndSettle();
      expect(find.byType(PlayerDrawer), findsOneWidget);
      expect(find.byType(SourceProjectionBar), findsNWidgets(4));

      await tester.tap(find.byTooltip('Close'));
      await tester.pumpAndSettle();
      expect(find.byType(PlayerDrawer), findsNothing);
    });
  });

  group('mobile', () {
    testWidgets('tapping a row opens the detail sheet', (tester) async {
      await pumpApp(tester, mobileSize);

      expect(find.byType(PlayerDrawer), findsNothing);
      await tester.tap(find.text('Jahmyr Gibbs'));
      await tester.pumpAndSettle();

      expect(find.byType(PlayerDetail), findsOneWidget);
      expect(find.byType(BottomSheet), findsOneWidget);
    });
  });

  testWidgets('an unreachable API shows the error state with a retry', (
    tester,
  ) async {
    await pumpApp(tester, desktopSize, api: downApi());

    expect(find.text('No board.'), findsOneWidget);
    expect(find.widgetWithText(SecondaryButton, 'Try again'), findsOneWidget);
  });
}
