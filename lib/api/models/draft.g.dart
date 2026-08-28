// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DraftSummary _$DraftSummaryFromJson(Map<String, dynamic> json) =>
    _DraftSummary(
      draftId: json['draft_id'] as String,
      running: json['running'] as bool,
      season: (json['season'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DraftSummaryToJson(_DraftSummary instance) =>
    <String, dynamic>{
      'draft_id': instance.draftId,
      'running': instance.running,
      'season': instance.season,
    };

_DraftStartOut _$DraftStartOutFromJson(Map<String, dynamic> json) =>
    _DraftStartOut(
      draftId: json['draft_id'] as String,
      season: (json['season'] as num).toInt(),
      running: json['running'] as bool,
      startedAt: json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at'] as String),
      alreadyRunning: json['already_running'] as bool,
      mySlot: (json['my_slot'] as num?)?.toInt(),
      picksMade: (json['picks_made'] as num).toInt(),
      boardRows: (json['board_rows'] as num).toInt(),
    );

Map<String, dynamic> _$DraftStartOutToJson(_DraftStartOut instance) =>
    <String, dynamic>{
      'draft_id': instance.draftId,
      'season': instance.season,
      'running': instance.running,
      'started_at': instance.startedAt?.toIso8601String(),
      'already_running': instance.alreadyRunning,
      'my_slot': instance.mySlot,
      'picks_made': instance.picksMade,
      'board_rows': instance.boardRows,
    };

_DraftStopOut _$DraftStopOutFromJson(Map<String, dynamic> json) =>
    _DraftStopOut(
      draftId: json['draft_id'] as String,
      running: json['running'] as bool,
    );

Map<String, dynamic> _$DraftStopOutToJson(_DraftStopOut instance) =>
    <String, dynamic>{
      'draft_id': instance.draftId,
      'running': instance.running,
    };
