import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/app/app.dart';
import 'package:lazy_sleeper_app/app/log/app_log.dart';
import 'package:lazy_sleeper_app/app/settings/logs_dialog.dart';
import 'package:logging/logging.dart';

import '../support.dart';

AppLog _log(WidgetTester tester) =>
    ProviderScope.containerOf(tester.element(find.byType(LazySleeperApp)))
        .read(appLogProvider);

Future<void> _open(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Logs'));
  await tester.pumpAndSettle();
  expect(find.byType(LogsDialog), findsOneWidget);
}

void main() {
  testWidgets('shows the tail of the log and follows new records', (
    tester,
  ) async {
    await pumpApp(tester, desktopSize);
    Logger('api').info('GET /board -> 200 (3 ms)');
    await _open(tester);

    expect(find.textContaining('GET /board -> 200 (3 ms)'), findsOneWidget);

    Logger('draft').info('start draft 42');
    await tester.pump();

    expect(find.textContaining('start draft 42'), findsOneWidget);
  });

  testWidgets('Copy puts the whole export on the clipboard', (tester) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String;
        }
        return null;
      },
    );
    await pumpApp(tester, desktopSize);
    Logger('app').info('first');
    Logger('app').info('second');
    await _open(tester);

    await tester.tap(find.text('Copy'));
    await tester.pumpAndSettle();

    expect(copied, startsWith('Lazy Sleeper app log\n'));
    expect(copied, contains('app: first\n'));
    expect(copied, contains('app: second\n'));
    expect(find.textContaining('Copied 2 lines'), findsOneWidget);
  });

  testWidgets('the verbose switch changes the level; Clear empties it', (
    tester,
  ) async {
    await pumpApp(tester, desktopSize);
    await _open(tester);
    expect(_log(tester).level, Level.INFO);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(_log(tester).level, Level.FINE);
    expect(find.textContaining('log level set to FINE'), findsOneWidget);

    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();

    expect(find.text('Nothing logged yet.'), findsOneWidget);
    expect(_log(tester).length, 0);
  });

  testWidgets('the Logs button is also on the mobile board toolbar', (
    tester,
  ) async {
    await pumpApp(tester, mobileSize);

    expect(find.byTooltip('Logs'), findsOneWidget);
  });
}
