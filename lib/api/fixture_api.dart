import 'dart:convert';

import 'package:flutter/services.dart';

import 'lazy_sleeper_api.dart';
import 'models/board.dart';
import 'models/draft.dart';

/// Serves the bundled `assets/fixtures/*.json` captures instead of a server.
///
/// Selected by `--dart-define=LS_FAKE_DATA=true`; lets the UI run with no
/// backend reachable. Filtering mirrors the server: `position` filters,
/// `rank` stays overall, `limit` truncates. The draft runner is simulated in
/// memory: start/stop flip a flag and answer like the server would.
class FixtureLazySleeperApi implements LazySleeperApi {
  FixtureLazySleeperApi({this.bundle});

  /// Defaults to [rootBundle]; injectable for tests.
  final AssetBundle? bundle;

  static const boardAsset = 'assets/fixtures/board.json';

  final _running = <String, int>{};

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

  @override
  Future<List<DraftSummary>> drafts() async => [
    for (final e in _running.entries)
      DraftSummary(draftId: e.key, running: true, season: e.value),
  ];

  @override
  Future<DraftStartOut> startDraft(String draftId, {int season = 2026}) async {
    final already = _running.containsKey(draftId);
    _running[draftId] = season;
    return DraftStartOut(
      draftId: draftId,
      season: season,
      running: true,
      startedAt: DateTime.now().toUtc(),
      alreadyRunning: already,
      mySlot: null,
      picksMade: 0,
      boardRows: 672,
    );
  }

  @override
  Future<DraftStopOut> stopDraft(String draftId) async {
    if (_running.remove(draftId) == null) {
      throw ApiException(
        'POST /draft/$draftId/stop returned 404: draft is not running',
        statusCode: 404,
      );
    }
    return DraftStopOut(draftId: draftId, running: false);
  }
}
