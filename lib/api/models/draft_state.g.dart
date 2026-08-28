// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DraftState _$DraftStateFromJson(Map<String, dynamic> json) => _DraftState(
  draftId: json['draft_id'] as String,
  spec: DraftSpec.fromJson(json['spec'] as Map<String, dynamic>),
  clock: DraftClock.fromJson(json['clock'] as Map<String, dynamic>),
  myRoster: json['my_roster'] == null
      ? null
      : DraftRoster.fromJson(json['my_roster'] as Map<String, dynamic>),
  recentPicks: (json['recent_picks'] as List<dynamic>)
      .map((e) => RecentPick.fromJson(e as Map<String, dynamic>))
      .toList(),
  recompute: Recompute.fromJson(json['recompute'] as Map<String, dynamic>),
  board: DraftBoardMeta.fromJson(json['board'] as Map<String, dynamic>),
  poller: DraftPoller.fromJson(json['poller'] as Map<String, dynamic>),
  running: json['running'] as bool?,
  rows: (json['rows'] as List<dynamic>)
      .map((e) => DraftRow.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DraftStateToJson(_DraftState instance) =>
    <String, dynamic>{
      'draft_id': instance.draftId,
      'spec': instance.spec,
      'clock': instance.clock,
      'my_roster': instance.myRoster,
      'recent_picks': instance.recentPicks,
      'recompute': instance.recompute,
      'board': instance.board,
      'poller': instance.poller,
      'running': instance.running,
      'rows': instance.rows,
    };

_DraftSpec _$DraftSpecFromJson(Map<String, dynamic> json) => _DraftSpec(
  teams: (json['teams'] as num).toInt(),
  rounds: (json['rounds'] as num).toInt(),
  type: json['type'] as String,
  totalPicks: (json['total_picks'] as num).toInt(),
);

Map<String, dynamic> _$DraftSpecToJson(_DraftSpec instance) =>
    <String, dynamic>{
      'teams': instance.teams,
      'rounds': instance.rounds,
      'type': instance.type,
      'total_picks': instance.totalPicks,
    };

_DraftClock _$DraftClockFromJson(Map<String, dynamic> json) => _DraftClock(
  currentPick: (json['current_pick'] as num).toInt(),
  round: (json['round'] as num?)?.toInt(),
  onTheClock: (json['on_the_clock'] as num?)?.toInt(),
  onTheClockTeamName: json['on_the_clock_team_name'] as String?,
  mySlot: (json['my_slot'] as num?)?.toInt(),
  myTurn: json['my_turn'] as bool,
  myNextPick: (json['my_next_pick'] as num?)?.toInt(),
  picksUntilMyTurn: (json['picks_until_my_turn'] as num?)?.toInt(),
  picksMade: (json['picks_made'] as num).toInt(),
  complete: json['complete'] as bool,
  pickTimerS: (json['pick_timer_s'] as num?)?.toInt(),
  pickDeadline: json['pick_deadline'] == null
      ? null
      : DateTime.parse(json['pick_deadline'] as String),
);

Map<String, dynamic> _$DraftClockToJson(_DraftClock instance) =>
    <String, dynamic>{
      'current_pick': instance.currentPick,
      'round': instance.round,
      'on_the_clock': instance.onTheClock,
      'on_the_clock_team_name': instance.onTheClockTeamName,
      'my_slot': instance.mySlot,
      'my_turn': instance.myTurn,
      'my_next_pick': instance.myNextPick,
      'picks_until_my_turn': instance.picksUntilMyTurn,
      'picks_made': instance.picksMade,
      'complete': instance.complete,
      'pick_timer_s': instance.pickTimerS,
      'pick_deadline': instance.pickDeadline?.toIso8601String(),
    };

_DraftRoster _$DraftRosterFromJson(Map<String, dynamic> json) => _DraftRoster(
  slot: (json['slot'] as num).toInt(),
  picks: (json['picks'] as List<dynamic>)
      .map((e) => RosterPick.fromJson(e as Map<String, dynamic>))
      .toList(),
  counts: Map<String, int>.from(json['counts'] as Map),
  openStarters: Map<String, int>.from(json['open_starters'] as Map),
  openFlex: (json['open_flex'] as num).toInt(),
  openBench: (json['open_bench'] as num).toInt(),
  needs: (json['needs'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
);

Map<String, dynamic> _$DraftRosterToJson(_DraftRoster instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'picks': instance.picks,
      'counts': instance.counts,
      'open_starters': instance.openStarters,
      'open_flex': instance.openFlex,
      'open_bench': instance.openBench,
      'needs': instance.needs,
    };

_RosterPick _$RosterPickFromJson(Map<String, dynamic> json) => _RosterPick(
  pickNo: (json['pick_no'] as num).toInt(),
  sleeperId: json['sleeper_id'] as String?,
  name: json['name'] as String?,
  position: json['position'] as String?,
  seat: json['seat'] as String?,
);

Map<String, dynamic> _$RosterPickToJson(_RosterPick instance) =>
    <String, dynamic>{
      'pick_no': instance.pickNo,
      'sleeper_id': instance.sleeperId,
      'name': instance.name,
      'position': instance.position,
      'seat': instance.seat,
    };

_RecentPick _$RecentPickFromJson(Map<String, dynamic> json) => _RecentPick(
  pickNo: (json['pick_no'] as num).toInt(),
  slot: (json['slot'] as num?)?.toInt(),
  teamName: json['team_name'] as String?,
  sleeperId: json['sleeper_id'] as String?,
  name: json['name'] as String?,
  position: json['position'] as String?,
);

Map<String, dynamic> _$RecentPickToJson(_RecentPick instance) =>
    <String, dynamic>{
      'pick_no': instance.pickNo,
      'slot': instance.slot,
      'team_name': instance.teamName,
      'sleeper_id': instance.sleeperId,
      'name': instance.name,
      'position': instance.position,
    };

_Recompute _$RecomputeFromJson(Map<String, dynamic> json) => _Recompute(
  seq: (json['seq'] as num).toInt(),
  pickNo: (json['pick_no'] as num).toInt(),
  computedAt: DateTime.parse(json['computed_at'] as String),
  elapsedMs: (json['elapsed_ms'] as num).toDouble(),
  stale: json['stale'] as bool,
  error: json['error'] as String?,
  count: (json['count'] as num).toInt(),
  avgMs: (json['avg_ms'] as num).toDouble(),
  maxMs: (json['max_ms'] as num).toDouble(),
  failures: (json['failures'] as num).toInt(),
);

Map<String, dynamic> _$RecomputeToJson(_Recompute instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'pick_no': instance.pickNo,
      'computed_at': instance.computedAt.toIso8601String(),
      'elapsed_ms': instance.elapsedMs,
      'stale': instance.stale,
      'error': instance.error,
      'count': instance.count,
      'avg_ms': instance.avgMs,
      'max_ms': instance.maxMs,
      'failures': instance.failures,
    };

_DraftBoardMeta _$DraftBoardMetaFromJson(Map<String, dynamic> json) =>
    _DraftBoardMeta(
      builtAt: DateTime.parse(json['built_at'] as String),
      season: (json['season'] as num?)?.toInt(),
      rows: (json['rows'] as num).toInt(),
      available: (json['available'] as num).toInt(),
    );

Map<String, dynamic> _$DraftBoardMetaToJson(_DraftBoardMeta instance) =>
    <String, dynamic>{
      'built_at': instance.builtAt.toIso8601String(),
      'season': instance.season,
      'rows': instance.rows,
      'available': instance.available,
    };

_DraftPoller _$DraftPollerFromJson(Map<String, dynamic> json) => _DraftPoller(
  intervalS: (json['interval_s'] as num).toDouble(),
  status: json['status'] as String?,
  expectedPicks: (json['expected_picks'] as num?)?.toInt(),
  startedAt: json['started_at'] == null
      ? null
      : DateTime.parse(json['started_at'] as String),
  lastPollAt: json['last_poll_at'] == null
      ? null
      : DateTime.parse(json['last_poll_at'] as String),
  lastOkAt: json['last_ok_at'] == null
      ? null
      : DateTime.parse(json['last_ok_at'] as String),
  failuresInARow: (json['failures_in_a_row'] as num).toInt(),
  lastError: json['last_error'] as String?,
  degraded: json['degraded'] as bool,
  runnerError: json['runner_error'] as String?,
  rebuildPending: json['rebuild_pending'] as bool,
  persist: json['persist'] as Map<String, dynamic>?,
  summary: json['summary'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$DraftPollerToJson(_DraftPoller instance) =>
    <String, dynamic>{
      'interval_s': instance.intervalS,
      'status': instance.status,
      'expected_picks': instance.expectedPicks,
      'started_at': instance.startedAt?.toIso8601String(),
      'last_poll_at': instance.lastPollAt?.toIso8601String(),
      'last_ok_at': instance.lastOkAt?.toIso8601String(),
      'failures_in_a_row': instance.failuresInARow,
      'last_error': instance.lastError,
      'degraded': instance.degraded,
      'runner_error': instance.runnerError,
      'rebuild_pending': instance.rebuildPending,
      'persist': instance.persist,
      'summary': instance.summary,
    };

_DraftRow _$DraftRowFromJson(Map<String, dynamic> json) => _DraftRow(
  rank: (json['rank'] as num).toInt(),
  sleeperId: json['sleeper_id'] as String,
  name: json['name'] as String,
  position: json['position'] as String,
  team: json['team'] as String?,
  injuryStatus: json['injury_status'] as String?,
  bye: (json['bye'] as num?)?.toInt(),
  points: (json['points'] as num).toDouble(),
  vorp: (json['vorp'] as num).toDouble(),
  posRank: (json['pos_rank'] as num).toInt(),
  tier: (json['tier'] as num?)?.toInt(),
  cliff: json['cliff'] as bool,
  gapToNext: (json['gap_to_next'] as num?)?.toDouble(),
  adp: (json['adp'] as num?)?.toDouble(),
  adpDelta: (json['adp_delta'] as num?)?.toDouble(),
  adpFlag: json['adp_flag'] as String?,
  disagree: json['disagree'] as bool,
  survival: (json['survival'] as num?)?.toDouble(),
  run: json['run'] as bool,
  runCount: (json['run_count'] as num).toInt(),
  pickScore: (json['pick_score'] as num?)?.toDouble(),
);

Map<String, dynamic> _$DraftRowToJson(_DraftRow instance) => <String, dynamic>{
  'rank': instance.rank,
  'sleeper_id': instance.sleeperId,
  'name': instance.name,
  'position': instance.position,
  'team': instance.team,
  'injury_status': instance.injuryStatus,
  'bye': instance.bye,
  'points': instance.points,
  'vorp': instance.vorp,
  'pos_rank': instance.posRank,
  'tier': instance.tier,
  'cliff': instance.cliff,
  'gap_to_next': instance.gapToNext,
  'adp': instance.adp,
  'adp_delta': instance.adpDelta,
  'adp_flag': instance.adpFlag,
  'disagree': instance.disagree,
  'survival': instance.survival,
  'run': instance.run,
  'run_count': instance.runCount,
  'pick_score': instance.pickScore,
};
