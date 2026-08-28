import 'dart:convert';

import 'package:flutter/services.dart';

import 'lazy_sleeper_api.dart';
import 'models/board.dart';

/// Serves the bundled `assets/fixtures/*.json` captures instead of a server.
///
/// Selected by `--dart-define=LS_FAKE_DATA=true`; lets the UI run with no
/// backend reachable. Filtering mirrors the server: `position` filters,
/// `rank` stays overall, `limit` truncates.
class FixtureLazySleeperApi implements LazySleeperApi {
  const FixtureLazySleeperApi({this.bundle});

  /// Defaults to [rootBundle]; injectable for tests.
  final AssetBundle? bundle;

  static const boardAsset = 'assets/fixtures/board.json';

  @override
  Future<BoardResponse> board({
    int? season,
    String? provider,
    String? position,
    int? limit,
  }) async {
    final raw = await (bundle ?? rootBundle).loadString(boardAsset);
    final full = BoardResponse.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
    var rows = full.rows;
    if (position != null) {
      rows = rows.where((r) => r.position == position).toList();
    }
    if (limit != null && rows.length > limit) {
      rows = rows.sublist(0, limit);
    }
    return full.copyWith(rows: rows);
  }
}
