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

const desktopSize = Size(1280, 800);
const mobileSize = Size(390, 844);

/// Reads assets straight from the repo, synchronously: widget tests run under
/// fake async, where real file I/O would never complete.
class RepoBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) =>
      SynchronousFuture(ByteData.sublistView(File(key).readAsBytesSync()));
}

/// The app on bundled fixture data (or [api]) at a given viewport.
Future<void> pumpApp(
  WidgetTester tester,
  Size size, {
  LazySleeperApi? api,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        lazySleeperApiProvider.overrideWithValue(
          api ?? FixtureLazySleeperApi(bundle: RepoBundle()),
        ),
      ],
      child: const LazySleeperApp(),
    ),
  );
  await tester.pumpAndSettle();
}
