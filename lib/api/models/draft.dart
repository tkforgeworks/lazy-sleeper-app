// Draft runner models: `GET /draft`, `POST /draft/{id}/start`,
// `POST /draft/{id}/stop`. From lazy-sleeper docs/api/README.md.
//
// freezed puts @JsonSerializable on the factory constructor by design; the
// analyzer flags that as an invalid target. Known false positive.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'draft.freezed.dart';
part 'draft.g.dart';

/// One entry of `GET /draft`: a draft this API process knows about.
@freezed
abstract class DraftSummary with _$DraftSummary {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DraftSummary({
    required String draftId,
    required bool running,
    int? season,
  }) = _DraftSummary;

  factory DraftSummary.fromJson(Map<String, dynamic> json) =>
      _$DraftSummaryFromJson(json);
}

/// `POST /draft/{id}/start` response.
@freezed
abstract class DraftStartOut with _$DraftStartOut {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DraftStartOut({
    required String draftId,
    required int season,
    required bool running,
    DateTime? startedAt,

    /// True when the runner was already alive: the call was a no-op.
    required bool alreadyRunning,

    /// Null until Sleeper assigns `draft_order` (often late on mocks).
    int? mySlot,
    required int picksMade,
    required int boardRows,
  }) = _DraftStartOut;

  factory DraftStartOut.fromJson(Map<String, dynamic> json) =>
      _$DraftStartOutFromJson(json);
}

/// `POST /draft/{id}/stop` response.
@freezed
abstract class DraftStopOut with _$DraftStopOut {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DraftStopOut({required String draftId, required bool running}) =
      _DraftStopOut;

  factory DraftStopOut.fromJson(Map<String, dynamic> json) =>
      _$DraftStopOutFromJson(json);
}
