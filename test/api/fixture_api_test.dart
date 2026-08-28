import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/fixture_api.dart';

/// Reads assets straight from the repo so the test does not depend on the
/// asset bundle the test harness builds.
class _RepoBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async =>
      ByteData.sublistView(await File(key).readAsBytes());
}

void main() {
  final api = FixtureLazySleeperApi(bundle: _RepoBundle());

  test('serves the bundled board capture', () async {
    final board = await api.board();

    expect(board.board.provider, 'ensemble');
    expect(board.rows.first.rank, 1);
    expect(board.rows.length, greaterThan(40));
  });

  test('filters by position without renumbering rank', () async {
    final rows = (await api.board(position: 'QB')).rows;

    expect(rows, isNotEmpty);
    expect(rows.every((r) => r.position == 'QB'), isTrue);
    expect(rows.first.rank, greaterThan(1), reason: 'rank stays overall');
  });

  test('truncates to limit', () async {
    final rows = (await api.board(limit: 5)).rows;

    expect(rows, hasLength(5));
    expect(rows.map((r) => r.rank), [1, 2, 3, 4, 5]);
  });
}
