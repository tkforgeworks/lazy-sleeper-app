// `GET /draft/{id}/state` models (`DraftStateOut` and friends), transcribed
// from the backend OpenAPI (v0.1.2) and docs/api/GUIDE.md Workflow 1.
//
// freezed puts @JsonSerializable on the factory constructor by design; the
// analyzer flags that as an invalid target. Known false positive.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'draft_state.freezed.dart';
part 'draft_state.g.dart';

/// The whole draft-night payload. Redraw when [recompute]`.seq` changes;
/// the clock is the one exemption (tick it locally every second).
@freezed
abstract class DraftState with _$DraftState {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DraftState({
    required String draftId,
    required DraftSpec spec,
    required DraftClock clock,

    /// Null until the runner knows my slot.
    DraftRoster? myRoster,

    /// League-wide feed, most recent first (last 8).
    required List<RecentPick> recentPicks,
    required Recompute recompute,
    required DraftBoardMeta board,
    required DraftPoller poller,
    bool? running,

    /// Best pick first by `pick_score`. `rank` is overall and does not
    /// renumber under a position filter.
    required List<DraftRow> rows,
  }) = _DraftState;

  factory DraftState.fromJson(Map<String, dynamic> json) =>
      _$DraftStateFromJson(json);
}

@freezed
abstract class DraftSpec with _$DraftSpec {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DraftSpec({
    required int teams,
    required int rounds,
    required String type,
    required int totalPicks,
  }) = _DraftSpec;

  factory DraftSpec.fromJson(Map<String, dynamic> json) =>
      _$DraftSpecFromJson(json);
}

/// Drives the header. Sleeper can deliver picks out of order (seen on mocks:
/// picks 1, 4, 6 with `current_pick` 7), so position comes from
/// [currentPick] / [onTheClock], never from [picksMade].
@freezed
abstract class DraftClock with _$DraftClock {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DraftClock({
    required int currentPick,
    int? round,

    /// Slot number on the clock; null when the draft is complete.
    int? onTheClock,

    /// Null until Sleeper assigns `draft_order` — fall back to the slot.
    String? onTheClockTeamName,
    int? mySlot,
    required bool myTurn,
    int? myNextPick,

    /// 0 = on the clock. Null when there is no next pick.
    int? picksUntilMyTurn,
    required int picksMade,
    required bool complete,
    int? pickTimerS,

    /// UTC, fixed for the life of the current pick. Null when the draft has
    /// no timer or the start of the current pick is unknown.
    DateTime? pickDeadline,
  }) = _DraftClock;

  factory DraftClock.fromJson(Map<String, dynamic> json) =>
      _$DraftClockFromJson(json);
}

@freezed
abstract class DraftRoster with _$DraftRoster {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DraftRoster({
    required int slot,
    required List<RosterPick> picks,

    /// Position → players drafted.
    required Map<String, int> counts,

    /// Position → open starting seats.
    required Map<String, int> openStarters,
    required int openFlex,
    required int openBench,

    /// Position → need weight (higher = more urgent).
    required Map<String, double> needs,
  }) = _DraftRoster;

  factory DraftRoster.fromJson(Map<String, dynamic> json) =>
      _$DraftRosterFromJson(json);
}

/// One of my picks and the roster seat it fills (`RB`, `FLEX`, `BN`, …).
@freezed
abstract class RosterPick with _$RosterPick {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RosterPick({
    required int pickNo,
    String? sleeperId,
    String? name,
    String? position,
    String? seat,
  }) = _RosterPick;

  factory RosterPick.fromJson(Map<String, dynamic> json) =>
      _$RosterPickFromJson(json);
}

@freezed
abstract class RecentPick with _$RecentPick {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RecentPick({
    required int pickNo,
    int? slot,
    String? teamName,
    String? sleeperId,
    String? name,
    String? position,
  }) = _RecentPick;

  factory RecentPick.fromJson(Map<String, dynamic> json) =>
      _$RecentPickFromJson(json);
}

/// `stale` or a non-null `error` means [DraftState.rows] are the previous
/// good ones: warn, keep rendering.
@freezed
abstract class Recompute with _$Recompute {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Recompute({
    required int seq,
    required int pickNo,
    required DateTime computedAt,
    required double elapsedMs,
    required bool stale,
    String? error,
    required int count,
    required double avgMs,
    required double maxMs,
    required int failures,
  }) = _Recompute;

  factory Recompute.fromJson(Map<String, dynamic> json) =>
      _$RecomputeFromJson(json);
}

@freezed
abstract class DraftBoardMeta with _$DraftBoardMeta {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DraftBoardMeta({
    required DateTime builtAt,
    int? season,
    required int rows,
    required int available,
  }) = _DraftBoardMeta;

  factory DraftBoardMeta.fromJson(Map<String, dynamic> json) =>
      _$DraftBoardMetaFromJson(json);
}

/// The backend's Sleeper poller. [status] is Sleeper's draft status:
/// `pre_draft` → `drafting` → `complete`. [runnerError] set means the runner
/// gave up (wrong draft id) and is no longer running.
@freezed
abstract class DraftPoller with _$DraftPoller {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DraftPoller({
    required double intervalS,
    String? status,
    int? expectedPicks,
    DateTime? startedAt,
    DateTime? lastPollAt,
    DateTime? lastOkAt,
    required int failuresInARow,
    String? lastError,
    required bool degraded,
    String? runnerError,
    required bool rebuildPending,
    Map<String, dynamic>? persist,
    Map<String, dynamic>? summary,
  }) = _DraftPoller;

  factory DraftPoller.fromJson(Map<String, dynamic> json) =>
      _$DraftPollerFromJson(json);
}

/// One best-available row. Same player fields as the board plus the
/// draft-time signals: [survival] to my next pick, [run], [pickScore].
@freezed
abstract class DraftRow with _$DraftRow {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DraftRow({
    required int rank,
    required String sleeperId,
    required String name,
    required String position,
    String? team,
    String? injuryStatus,
    int? bye,
    required double points,
    required double vorp,
    required int posRank,
    int? tier,
    required bool cliff,
    double? gapToNext,
    double? adp,
    double? adpDelta,
    String? adpFlag,
    required bool disagree,

    /// 0–1 probability the player is still there at my next pick.
    double? survival,
    required bool run,
    required int runCount,
    double? pickScore,
  }) = _DraftRow;

  factory DraftRow.fromJson(Map<String, dynamic> json) =>
      _$DraftRowFromJson(json);
}
