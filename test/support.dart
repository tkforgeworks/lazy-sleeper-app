// Shared widget-test plumbing.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/fixture_api.dart';
import 'package:lazy_sleeper_app/api/lazy_sleeper_api.dart';
import 'package:lazy_sleeper_app/api/providers.dart';
import 'package:lazy_sleeper_app/app/app.dart';
import 'package:lazy_sleeper_app/app/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

const desktopSize = Size(1280, 800);
const mobileSize = Size(390, 844);

/// Reads assets straight from the repo, synchronously: widget tests run under
/// fake async, where real file I/O would never complete.
class RepoBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) =>
      SynchronousFuture(ByteData.sublistView(File(key).readAsBytesSync()));
}

/// The app on bundled fixture data (or [api]) at a given viewport, with an
/// in-memory preferences store seeded from [prefs].
Future<SharedPreferences> pumpApp(
  WidgetTester tester,
  Size size, {
  LazySleeperApi? api,
  Map<String, Object> prefs = const {},
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues(prefs);
  final store = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(store),
        if (api != null || !lsFakeData)
          lazySleeperApiProvider.overrideWithValue(
            api ?? FixtureLazySleeperApi(bundle: RepoBundle()),
          ),
      ],
      child: const LazySleeperApp(),
    ),
  );
  await tester.pumpAndSettle();
  return store;
}
