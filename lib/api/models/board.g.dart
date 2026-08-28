// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoardResponse _$BoardResponseFromJson(Map<String, dynamic> json) =>
    _BoardResponse(
      board: BoardMeta.fromJson(json['board'] as Map<String, dynamic>),
      rows: (json['rows'] as List<dynamic>)
          .map((e) => BoardRow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BoardResponseToJson(_BoardResponse instance) =>
    <String, dynamic>{'board': instance.board, 'rows': instance.rows};

_BoardMeta _$BoardMetaFromJson(Map<String, dynamic> json) => _BoardMeta(
  id: (json['id'] as num).toInt(),
  season: (json['season'] as num).toInt(),
  provider: json['provider'] as String,
  baseline: json['baseline'] as String,
  generatedAt: DateTime.parse(json['generated_at'] as String),
  rowCount: (json['row_count'] as num).toInt(),
  config: json['config'] as Map<String, dynamic>,
);

Map<String, dynamic> _$BoardMetaToJson(_BoardMeta instance) =>
    <String, dynamic>{
      'id': instance.id,
      'season': instance.season,
      'provider': instance.provider,
      'baseline': instance.baseline,
      'generated_at': instance.generatedAt.toIso8601String(),
      'row_count': instance.rowCount,
      'config': instance.config,
    };

_BoardRow _$BoardRowFromJson(Map<String, dynamic> json) => _BoardRow(
  rank: (json['rank'] as num).toInt(),
  sleeperId: json['sleeper_id'] as String,
  name: json['name'] as String,
  position: json['position'] as String,
  team: json['team'] as String?,
  injuryStatus: json['injury_status'] as String?,
  points: (json['points'] as num).toDouble(),
  baseline: (json['baseline'] as num).toDouble(),
  vorp: (json['vorp'] as num).toDouble(),
  posRank: (json['pos_rank'] as num).toInt(),
  tier: (json['tier'] as num?)?.toInt(),
  cliff: json['cliff'] as bool,
  gapToNext: (json['gap_to_next'] as num?)?.toDouble(),
  adp: (json['adp'] as num?)?.toDouble(),
  adpDelta: (json['adp_delta'] as num?)?.toDouble(),
  adpFlag: json['adp_flag'] as String?,
  spread: (json['spread'] as num?)?.toDouble(),
  disagree: json['disagree'] as bool,
  components: (json['components'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
);

Map<String, dynamic> _$BoardRowToJson(_BoardRow instance) => <String, dynamic>{
  'rank': instance.rank,
  'sleeper_id': instance.sleeperId,
  'name': instance.name,
  'position': instance.position,
  'team': instance.team,
  'injury_status': instance.injuryStatus,
  'points': instance.points,
  'baseline': instance.baseline,
  'vorp': instance.vorp,
  'pos_rank': instance.posRank,
  'tier': instance.tier,
  'cliff': instance.cliff,
  'gap_to_next': instance.gapToNext,
  'adp': instance.adp,
  'adp_delta': instance.adpDelta,
  'adp_flag': instance.adpFlag,
  'spread': instance.spread,
  'disagree': instance.disagree,
  'components': instance.components,
};
