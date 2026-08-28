import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/providers.dart';
import 'package:lazy_sleeper_app/app/app.dart';
import 'package:lazy_sleeper_app/app/log/app_log.dart';
import 'package:lazy_sleeper_app/app/settings/app_settings.dart';
import 'package:lazy_sleeper_app/app/settings/settings_screen.dart';
import 'package:lazy_sleeper_app/app/shell/top_nav.dart';
import 'package:lazy_sleeper_app/app/theme/theme_mode.dart';
import 'package:lazy_sleeper_app/features/board/board_screen.dart';
import 'package:logging/logging.dart';

import '../support.dart';

ProviderContainer _container(WidgetTester tester) =>
    ProviderScope.containerOf(tester.element(find.byType(LazySleeperApp)));

Future<void> _openSettings(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Settings'));
  await tester.pumpAndSettle();
  expect(find.byType(SettingsScreen), findsOneWidget);
}

Future<void> _tapChoice(WidgetTester tester, String label) async {
  await tester.ensureVisible(find.text(label));
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}

Future<void> _flip(WidgetTester tester, Key key) async {
  await tester.ensureVisible(find.byKey(key));
  await tester.tap(find.byKey(key));
  await tester.pumpAndSettle();
}

void main() {
  group('normalizeApiUrl', () {
    test('accepts absolute http(s) addresses and drops the trailing slash', () {
      expect(
        normalizeApiUrl(' http://100.64.0.5:8000/ '),
        'http://100.64.0.5:8000',
      );
      expect(
        normalizeApiUrl('https://ls.example.com/api/'),
        'https://ls.example.com/api',
      );
      expect(normalizeApiUrl('http://127.0.0.1:8000'), 'http://127.0.0.1:8000');
    });

    test(
      'rejects anything that is not an absolute http(s) URL with a host',
      () {
        expect(normalizeApiUrl(''), isNull);
        expect(normalizeApiUrl('127.0.0.1:8000'), isNull);
        expect(normalizeApiUrl('/board'), isNull);
        expect(normalizeApiUrl('ftp://host'), isNull);
        expect(normalizeApiUrl('http://'), isNull);
      },
    );
  });

  testWidgets('the gear opens Settings inside the shell; Back returns', (
    tester,
  ) async {
    await pumpApp(tester, desktopSize);
    await _openSettings(tester);

    expect(find.byType(TopNav), findsOneWidget, reason: 'shell stays');
    expect(find.byType(BoardScreen), findsNothing);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsScreen), findsNothing);
    expect(find.byType(BoardScreen), findsOneWidget);
  });

  testWidgets('on a phone the gear is on the board toolbar; no bottom nav', (
    tester,
  ) async {
    await pumpApp(tester, mobileSize);
    await _openSettings(tester);

    expect(find.byType(NavigationBar), findsNothing);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  group('API address', () {
    testWidgets('starts from the build default when nothing is saved', (
      tester,
    ) async {
      await pumpApp(tester, desktopSize);
      expect(_container(tester).read(apiBaseUrlProvider), lsApiUrlDefault);
    });

    testWidgets('saving a new address applies and persists it', (tester) async {
      final store = await pumpApp(tester, desktopSize);
      await _openSettings(tester);

      await tester.enterText(
        find.byKey(const Key('setting.api_url')),
        'http://100.64.0.5:8000/',
      );
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(
        _container(tester).read(apiBaseUrlProvider),
        'http://100.64.0.5:8000',
      );
      expect(store.getString(ApiBaseUrl.prefsKey), 'http://100.64.0.5:8000');
    });

    testWidgets('an invalid address is refused', (tester) async {
      final store = await pumpApp(tester, desktopSize);
      await _openSettings(tester);

      await tester.enterText(
        find.byKey(const Key('setting.api_url')),
        'not a url',
      );
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.textContaining('absolute http(s)'), findsOneWidget);
      expect(store.getString(ApiBaseUrl.prefsKey), isNull);
    });

    testWidgets('Use default forgets the saved address', (tester) async {
      final store = await pumpApp(
        tester,
        desktopSize,
        prefs: {ApiBaseUrl.prefsKey: 'http://10.0.0.9:8000'},
      );
      await _openSettings(tester);
      expect(find.text('http://10.0.0.9:8000'), findsOneWidget);

      await tester.tap(find.text('Use default'));
      await tester.pumpAndSettle();

      expect(_container(tester).read(apiBaseUrlProvider), lsApiUrlDefault);
      expect(store.getString(ApiBaseUrl.prefsKey), isNull);
      expect(find.text(lsApiUrlDefault), findsWidgets);
    });

    testWidgets('the error state reaches Settings too', (tester) async {
      await pumpApp(tester, desktopSize, api: downApi());
      await tester.tap(find.text('Change address'));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);
    });
  });

  group('draft settings', () {
    testWidgets('poll interval: 2 s by default, a tap persists and applies', (
      tester,
    ) async {
      final store = await pumpApp(tester, desktopSize);
      final c = _container(tester);
      expect(c.read(draftPollIntervalProvider), const Duration(seconds: 2));

      await _openSettings(tester);
      await _tapChoice(tester, '1 s');

      expect(c.read(draftPollIntervalProvider), const Duration(seconds: 1));
      expect(store.getInt(AppSettings.pollIntervalKey), 1);
    });

    testWidgets('a saved poll interval is read back on launch', (tester) async {
      await pumpApp(
        tester,
        desktopSize,
        prefs: {AppSettings.pollIntervalKey: 4},
      );
      expect(
        _container(tester).read(draftPollIntervalProvider),
        const Duration(seconds: 4),
      );
    });

    testWidgets('a saved value off the menu falls back to the default', (
      tester,
    ) async {
      await pumpApp(
        tester,
        desktopSize,
        prefs: {AppSettings.pollIntervalKey: 9, AppSettings.rowLimitKey: 45},
      );
      final s = _container(tester).read(appSettingsProvider);
      expect(s.pollIntervalS, AppSettings.defaultPollIntervalS);
      expect(s.rowLimit, AppSettings.defaultRowLimit);
    });

    testWidgets('panic threshold and row count persist', (tester) async {
      final store = await pumpApp(tester, desktopSize);
      await _openSettings(tester);

      await _tapChoice(tester, '45 s');
      await _tapChoice(tester, '60');

      final c = _container(tester);
      expect(c.read(panicThresholdProvider), 45);
      expect(c.read(draftStateRowLimitProvider), 60);
      expect(store.getInt(AppSettings.panicThresholdKey), 45);
      expect(store.getInt(AppSettings.rowLimitKey), 60);
    });

    testWidgets('alerts are all on by default; a switch turns one off', (
      tester,
    ) async {
      final store = await pumpApp(tester, desktopSize);
      final c = _container(tester);
      expect(c.read(enabledAlertsProvider), allAlerts);

      await _openSettings(tester);
      await _flip(tester, const Key('setting.alert.cliff'));

      expect(
        c.read(enabledAlertsProvider),
        allAlerts.difference({AlertKind.cliff}),
      );
      expect(store.getStringList(AppSettings.alertsOffKey), ['cliff']);

      await _flip(tester, const Key('setting.alert.cliff'));
      expect(c.read(enabledAlertsProvider), allAlerts);
      expect(store.getStringList(AppSettings.alertsOffKey), isEmpty);
    });

    testWidgets('saved alert switches are read back', (tester) async {
      await pumpApp(
        tester,
        desktopSize,
        prefs: {
          AppSettings.alertsOffKey: ['run', 'injury', 'bogus'],
        },
      );
      expect(_container(tester).read(enabledAlertsProvider), {
        AlertKind.cliff,
        AlertKind.value,
      });
    });
  });

  group('appearance', () {
    testWidgets('theme is dark by default; a choice persists', (tester) async {
      final store = await pumpApp(tester, desktopSize);
      final c = _container(tester);
      expect(c.read(themeModeProvider), ThemeMode.dark);

      await _openSettings(tester);
      await _tapChoice(tester, 'Light');

      expect(c.read(themeModeProvider), ThemeMode.light);
      expect(store.getString(ThemeModeNotifier.prefsKey), 'light');
      final context = tester.element(find.byType(SettingsScreen));
      expect(Theme.of(context).brightness, Brightness.light);
    });

    testWidgets('a saved theme is restored on launch', (tester) async {
      await pumpApp(
        tester,
        desktopSize,
        prefs: {ThemeModeNotifier.prefsKey: 'light'},
      );
      expect(_container(tester).read(themeModeProvider), ThemeMode.light);
    });
  });

  group('logging', () {
    testWidgets('the verbose switch sets the live level and persists', (
      tester,
    ) async {
      final store = await pumpApp(tester, desktopSize);
      final log = _container(tester).read(appLogProvider);
      expect(log.level, Level.INFO);

      await _openSettings(tester);
      await _flip(tester, const Key('setting.verbose'));

      expect(log.level, Level.FINE);
      expect(store.getBool(AppSettings.verboseLogKey), isTrue);
      expect(_container(tester).read(appSettingsProvider).verboseLog, isTrue);
    });

    testWidgets('the Logs dialog verbose switch writes the same setting', (
      tester,
    ) async {
      final store = await pumpApp(tester, desktopSize);
      await tester.tap(find.byTooltip('Logs'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(store.getBool(AppSettings.verboseLogKey), isTrue);
      expect(_container(tester).read(appSettingsProvider).verboseLog, isTrue);
    });
  });

  testWidgets('Reset to defaults clears every saved value', (tester) async {
    final store = await pumpApp(
      tester,
      desktopSize,
      prefs: {
        ApiBaseUrl.prefsKey: 'http://10.0.0.9:8000',
        AppSettings.pollIntervalKey: 1,
        AppSettings.panicThresholdKey: 60,
        AppSettings.rowLimitKey: 20,
        AppSettings.alertsOffKey: ['run'],
        AppSettings.verboseLogKey: true,
        ThemeModeNotifier.prefsKey: 'light',
      },
    );
    final c = _container(tester);
    c.read(appLogProvider).verbose = true;
    await _openSettings(tester);

    await tester.ensureVisible(find.text('Reset to defaults'));
    await tester.tap(find.text('Reset to defaults'));
    await tester.pumpAndSettle();

    expect(c.read(appSettingsProvider), AppSettings.defaults());
    expect(c.read(themeModeProvider), ThemeMode.dark);
    expect(c.read(apiBaseUrlProvider), lsApiUrlDefault);
    expect(c.read(appLogProvider).level, Level.INFO);
    for (final key in [
      ...AppSettings.keys,
      ThemeModeNotifier.prefsKey,
      ApiBaseUrl.prefsKey,
    ]) {
      expect(store.containsKey(key), isFalse, reason: key);
    }
    expect(find.text(lsApiUrlDefault), findsWidgets);
  });
}
