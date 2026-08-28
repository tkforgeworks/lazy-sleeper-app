import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/app/app.dart';
import 'package:lazy_sleeper_app/app/shell/top_nav.dart';
import 'package:lazy_sleeper_app/app/theme/ls_theme.dart';

const _desktop = Size(1280, 800);
const _mobile = Size(390, 844);

Future<void> pumpApp(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const ProviderScope(child: LazySleeperApp()));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('opens on the Big Board in the dark theme', (tester) async {
    await pumpApp(tester, _desktop);

    expect(find.text('Big Board'), findsOneWidget);
    final context = tester.element(find.text('Big Board'));
    expect(Theme.of(context).brightness, Brightness.dark);
    expect(context.ls, same(LsColors.dark));
  });

  testWidgets('desktop width uses the top text-pill nav', (tester) async {
    await pumpApp(tester, _desktop);

    expect(find.byType(TopNav), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('mobile width uses the bottom NavigationBar', (tester) async {
    await pumpApp(tester, _mobile);

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(TopNav), findsNothing);
  });

  testWidgets('top nav pills switch sections', (tester) async {
    await pumpApp(tester, _desktop);

    await tester.tap(find.widgetWithText(NavPill, 'Garage'));
    await tester.pumpAndSettle();

    expect(find.text('Tuning Garage'), findsOneWidget);
    expect(find.text('Big Board'), findsNothing);
  });

  testWidgets('bottom nav destinations switch sections', (tester) async {
    await pumpApp(tester, _mobile);

    await tester.tap(find.widgetWithText(NavigationDestination, 'Season'));
    await tester.pumpAndSettle();

    expect(find.text('Season Monitor'), findsOneWidget);
    expect(find.text('Big Board'), findsNothing);
  });
}
