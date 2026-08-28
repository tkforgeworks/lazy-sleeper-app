import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/app/shell/top_nav.dart';
import 'package:lazy_sleeper_app/app/theme/ls_theme.dart';
import 'package:lazy_sleeper_app/features/board/board_screen.dart';

import 'support.dart';

void main() {
  testWidgets('opens on the board in the dark theme', (tester) async {
    await pumpApp(tester, desktopSize);

    expect(find.byType(BoardScreen), findsOneWidget);
    final context = tester.element(find.byType(BoardScreen));
    expect(Theme.of(context).brightness, Brightness.dark);
    expect(context.ls, same(LsColors.dark));
  });

  testWidgets('desktop width uses the top text-pill nav', (tester) async {
    await pumpApp(tester, desktopSize);

    expect(find.byType(TopNav), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('mobile width uses the bottom NavigationBar', (tester) async {
    await pumpApp(tester, mobileSize);

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(TopNav), findsNothing);
  });

  testWidgets('top nav pills switch sections', (tester) async {
    await pumpApp(tester, desktopSize);

    await tester.tap(find.widgetWithText(NavPill, 'Garage'));
    await tester.pumpAndSettle();

    expect(find.text('Tuning Garage'), findsOneWidget);
    expect(find.byType(BoardScreen), findsNothing);
  });

  testWidgets('bottom nav destinations switch sections', (tester) async {
    await pumpApp(tester, mobileSize);

    await tester.tap(find.widgetWithText(NavigationDestination, 'Season'));
    await tester.pumpAndSettle();

    expect(find.text('Season Monitor'), findsOneWidget);
    expect(find.byType(BoardScreen), findsNothing);
  });
}
