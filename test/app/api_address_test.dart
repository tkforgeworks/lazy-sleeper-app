import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/lazy_sleeper_api.dart';
import 'package:lazy_sleeper_app/api/models/board.dart';
import 'package:lazy_sleeper_app/api/providers.dart';
import 'package:lazy_sleeper_app/app/app.dart';
import 'package:lazy_sleeper_app/app/settings/api_address_dialog.dart';

import '../support.dart';

class _DownApi implements LazySleeperApi {
  @override
  Future<BoardResponse> board({
    int? season,
    String? provider,
    String? position,
    int? limit,
  }) async => throw const ApiException('Could not reach the API: refused');
}

ProviderContainer _container(WidgetTester tester) =>
    ProviderScope.containerOf(tester.element(find.byType(LazySleeperApp)));

Future<void> _openDialog(WidgetTester tester) async {
  await tester.tap(find.byTooltip('API address'));
  await tester.pumpAndSettle();
  expect(find.byType(ApiAddressDialog), findsOneWidget);
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

  testWidgets('starts from the build default when nothing is saved', (
    tester,
  ) async {
    await pumpApp(tester, desktopSize);

    expect(_container(tester).read(apiBaseUrlProvider), lsApiUrlDefault);
  });

  testWidgets('a saved address wins over the build default', (tester) async {
    await pumpApp(
      tester,
      desktopSize,
      prefs: {ApiBaseUrl.prefsKey: 'http://10.0.0.9:8000'},
    );

    expect(_container(tester).read(apiBaseUrlProvider), 'http://10.0.0.9:8000');
  });

  testWidgets('saving a new address applies and persists it', (tester) async {
    final store = await pumpApp(tester, desktopSize);
    await _openDialog(tester);

    await tester.enterText(find.byType(TextField), 'http://100.64.0.5:8000/');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.byType(ApiAddressDialog), findsNothing);
    expect(
      _container(tester).read(apiBaseUrlProvider),
      'http://100.64.0.5:8000',
    );
    expect(store.getString(ApiBaseUrl.prefsKey), 'http://100.64.0.5:8000');
  });

  testWidgets('an invalid address is refused and the dialog stays open', (
    tester,
  ) async {
    final store = await pumpApp(tester, desktopSize);
    await _openDialog(tester);

    await tester.enterText(find.byType(TextField), 'not a url');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.byType(ApiAddressDialog), findsOneWidget);
    expect(find.textContaining('absolute http(s)'), findsOneWidget);
    expect(store.getString(ApiBaseUrl.prefsKey), isNull);
  });

  testWidgets('reset returns to the build default and forgets the saved one', (
    tester,
  ) async {
    final store = await pumpApp(
      tester,
      desktopSize,
      prefs: {ApiBaseUrl.prefsKey: 'http://10.0.0.9:8000'},
    );
    await _openDialog(tester);

    await tester.tap(find.text('Reset to default'));
    await tester.pumpAndSettle();

    expect(_container(tester).read(apiBaseUrlProvider), lsApiUrlDefault);
    expect(store.getString(ApiBaseUrl.prefsKey), isNull);
  });

  testWidgets('the mobile toolbar and the error state also reach the dialog', (
    tester,
  ) async {
    await pumpApp(tester, mobileSize);
    await _openDialog(tester);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    await pumpApp(tester, desktopSize, api: _DownApi());
    await tester.tap(find.text('Change address'));
    await tester.pumpAndSettle();
    expect(find.byType(ApiAddressDialog), findsOneWidget);
  });
}
