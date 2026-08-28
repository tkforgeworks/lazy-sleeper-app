// `GET /board` response models.
//
// Mirrors lazy-sleeper docs/api/GUIDE.md ("GET /board → {board, rows}"). The
// backend's OpenAPI types these rows as a bare object until LS-55, so the
// contract is transcribed here by hand; regenerate from the spec once it is.
//
// freezed puts @JsonSerializable on the factory constructor by design; the
// analyzer flags that as an invalid target. Known false positive.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'board.freezed.dart';
part 'board.g.dart';

@freezed
abstract class BoardResponse with _$BoardResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BoardResponse({
    required BoardMeta board,
    required List<BoardRow> rows,
  }) = _BoardResponse;

  factory BoardResponse.fromJson(Map<String, dynamic> json) =>
      _$BoardResponseFromJson(json);
}

/// The persisted board this set of rows came from.
@freezed
abstract class BoardMeta with _$BoardMeta {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BoardMeta({
    required int id,
    required int season,

    /// `sleeper` | `espn` | `ensemble`.
    required String provider,

    /// `live` | `historical`.
    required String baseline,
    required DateTime generatedAt,

    /// Rows on the full board; the response may carry fewer (`limit`).
    required int rowCount,

    /// Snapshot of the dial values the board was built under.
    required Map<String, dynamic> config,
  }) = _BoardMeta;

  factory BoardMeta.fromJson(Map<String, dynamic> json) =>
      _$BoardMetaFromJson(json);
}

/// One ranked player on the pre-draft board.
///
/// `rank` is the overall order and does not renumber under a position filter.
@freezed
abstract class BoardRow with _$BoardRow {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BoardRow({
    required int rank,
    required String sleeperId,
    required String name,
    required String position,
    String? team,

    /// Sleeper's status string, e.g. `Questionable`, `IR`, `PUP`; null = healthy.
    String? injuryStatus,

    /// Projected season points under the board's provider (ensemble by default).
    required double points,

    /// Replacement-level points used for this position.
    required double baseline,
    required double vorp,
    required int posRank,

    /// Null below the tiered depth for the position.
    int? tier,
    required bool cliff,
    double? gapToNext,
    double? adp,

    /// Positive = value (ADP later than rank), negative = reach.
    double? adpDelta,

    /// `value` | `reach` when |adpDelta| clears the configured threshold.
    String? adpFlag,

    /// Point spread between ensemble members; null when only one provider.
    double? spread,
    required bool disagree,

    /// Per-provider season points, e.g. `{"sleeper": 331.4, "espn": 364.8}`.
    required Map<String, double> components,
  }) = _BoardRow;

  factory BoardRow.fromJson(Map<String, dynamic> json) =>
      _$BoardRowFromJson(json);
}
