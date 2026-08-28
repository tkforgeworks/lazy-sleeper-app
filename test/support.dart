// Shared widget-test plumbing.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/fixture_api.dart';
import 'package:lazy_sleeper_app/api/lazy_sleeper_api.dart';
import 'package:lazy_sleeper_app/api/models/board.dart';
import 'package:lazy_sleeper_app/api/models/draft.dart';
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

/// A [LazySleeperApi] whose every call is a swappable callback; defaults to
/// the bundled fixture for the board and an idle draft runner. Assign a
/// callback that throws [ApiException] to simulate failures.
class FakeLazySleeperApi implements LazySleeperApi {
  FakeLazySleeperApi({this.onBoard, this.onDrafts, this.onStart, this.onStop});

  final _fixture = FixtureLazySleeperApi(bundle: RepoBundle());
  Future<BoardResponse> Function()? onBoard;
  Future<List<DraftSummary>> Function()? onDrafts;
  Future<DraftStartOut> Function(String id, int season)? onStart;
  Future<DraftStopOut> Function(String id)? onStop;

  @override
  Future<BoardResponse> board({
    int? season,
    String? provider,
    String? position,
    int? limit,
  }) =>
      onBoard?.call() ??
      _fixture.board(
        season: season,
        provider: provider,
        position: position,
        limit: limit,
      );

  @override
  Future<List<DraftSummary>> drafts() => onDrafts?.call() ?? _fixture.drafts();

  @override
  Future<DraftStartOut> startDraft(String draftId, {int season = 2026}) =>
      onStart?.call(draftId, season) ??
      _fixture.startDraft(draftId, season: season);

  @override
  Future<DraftStopOut> stopDraft(String draftId) =>
      onStop?.call(draftId) ?? _fixture.stopDraft(draftId);
}

/// An API whose board fetch fails as if the server were unreachable.
FakeLazySleeperApi downApi() => FakeLazySleeperApi(
  onBoard: () async =>
      throw const ApiException('Could not reach the API: refused'),
);

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
        lazySleeperApiProvider.overrideWithValue(api ?? FakeLazySleeperApi()),
      ],
      child: const LazySleeperApp(),
    ),
  );
  await tester.pumpAndSettle();
  return store;
}
