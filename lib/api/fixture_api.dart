import 'dart:convert';

import 'package:flutter/services.dart';

import 'lazy_sleeper_api.dart';
import 'models/board.dart';
import 'models/draft.dart';
import 'models/draft_state.dart';

/// Serves the bundled `assets/fixtures/*.json` captures instead of a server.
///
/// Selected by `--dart-define=LS_FAKE_DATA=true`; lets the UI run with no
/// backend reachable. Filtering mirrors the server: `position` filters,
/// `rank` stays overall, `limit` truncates. The draft runner is simulated in
/// memory: start/stop flip a flag and answer like the server would, and
/// `/state` is a 404 until the runner is started.
class FixtureLazySleeperApi implements LazySleeperApi {
  FixtureLazySleeperApi({this.bundle, this.stateAsset = draftStateMyTurn});

  /// Defaults to [rootBundle]; injectable for tests.
  final AssetBundle? bundle;

  /// Which `/state` capture to serve; see the `draftState*` constants.
  final String stateAsset;

  static const boardAsset = 'assets/fixtures/board.json';

  /// `/state` captures from Sleeper mock drafts on 2026-08-28 (12 teams,
  /// 15 rounds, snake; my slot 2 except the completed one, slot 7).
  static const draftStatePre = 'assets/fixtures/draft_state_pre.json';
  static const draftStateMid = 'assets/fixtures/draft_state_mid.json';
  static const draftStateMyTurn = 'assets/fixtures/draft_state_my_turn.json';
  static const draftStateComplete = 'assets/fixtures/draft_state_complete.json';

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
  Future<DraftState> draftState(
    String draftId, {
    String? position,
    int? limit,
  }) async {
    if (!_running.containsKey(draftId)) {
      throw ApiException(
        'GET /draft/$draftId/state returned 404: draft $draftId is not '
        'running; POST /draft/$draftId/start first',
        statusCode: 404,
      );
    }
    final raw = await (bundle ?? rootBundle).loadString(stateAsset);
    final full = DraftState.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    var rows = full.rows;
    if (position != null) {
      rows = rows.where((r) => r.position == position).toList();
    }
    if (limit != null && rows.length > limit) rows = rows.sublist(0, limit);
    return full.copyWith(draftId: draftId, rows: rows);
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
