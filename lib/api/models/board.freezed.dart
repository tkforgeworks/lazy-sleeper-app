// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BoardResponse {

 BoardMeta get board; List<BoardRow> get rows;
/// Create a copy of BoardResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardResponseCopyWith<BoardResponse> get copyWith => _$BoardResponseCopyWithImpl<BoardResponse>(this as BoardResponse, _$identity);

  /// Serializes this BoardResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardResponse&&(identical(other.board, board) || other.board == board)&&const DeepCollectionEquality().equals(other.rows, rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,board,const DeepCollectionEquality().hash(rows));

@override
String toString() {
  return 'BoardResponse(board: $board, rows: $rows)';
}


}

/// @nodoc
abstract mixin class $BoardResponseCopyWith<$Res>  {
  factory $BoardResponseCopyWith(BoardResponse value, $Res Function(BoardResponse) _then) = _$BoardResponseCopyWithImpl;
@useResult
$Res call({
 BoardMeta board, List<BoardRow> rows
});


$BoardMetaCopyWith<$Res> get board;

}
/// @nodoc
class _$BoardResponseCopyWithImpl<$Res>
    implements $BoardResponseCopyWith<$Res> {
  _$BoardResponseCopyWithImpl(this._self, this._then);

  final BoardResponse _self;
  final $Res Function(BoardResponse) _then;

/// Create a copy of BoardResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? board = null,Object? rows = null,}) {
  return _then(BoardResponse(
board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as BoardMeta,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<BoardRow>,
  ));
}
/// Create a copy of BoardResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardMetaCopyWith<$Res> get board {
  
  return $BoardMetaCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}
}


/// Adds pattern-matching-related methods to [BoardResponse].
extension BoardResponsePatterns on BoardResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardResponse value)  $default,){
final _that = this;
switch (_that) {
case _BoardResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardResponse value)?  $default,){
final _that = this;
switch (_that) {
case _BoardResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BoardMeta board,  List<BoardRow> rows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardResponse() when $default != null:
return $default(_that.board,_that.rows);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BoardMeta board,  List<BoardRow> rows)  $default,) {final _that = this;
switch (_that) {
case _BoardResponse():
return $default(_that.board,_that.rows);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BoardMeta board,  List<BoardRow> rows)?  $default,) {final _that = this;
switch (_that) {
case _BoardResponse() when $default != null:
return $default(_that.board,_that.rows);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _BoardResponse implements BoardResponse {
  const _BoardResponse({required this.board, required  List<BoardRow> rows}): _rows = rows;
  factory _BoardResponse.fromJson(Map<String, dynamic> json) => _$BoardResponseFromJson(json);

@override final  BoardMeta board;
 final  List<BoardRow> _rows;
@override List<BoardRow> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}


/// Create a copy of BoardResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardResponseCopyWith<_BoardResponse> get copyWith => __$BoardResponseCopyWithImpl<_BoardResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardResponse&&(identical(other.board, board) || other.board == board)&&const DeepCollectionEquality().equals(other._rows, _rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,board,const DeepCollectionEquality().hash(_rows));

@override
String toString() {
  return 'BoardResponse(board: $board, rows: $rows)';
}


}

/// @nodoc
abstract mixin class _$BoardResponseCopyWith<$Res> implements $BoardResponseCopyWith<$Res> {
  factory _$BoardResponseCopyWith(_BoardResponse value, $Res Function(_BoardResponse) _then) = __$BoardResponseCopyWithImpl;
@override @useResult
$Res call({
 BoardMeta board, List<BoardRow> rows
});


@override $BoardMetaCopyWith<$Res> get board;

}
/// @nodoc
class __$BoardResponseCopyWithImpl<$Res>
    implements _$BoardResponseCopyWith<$Res> {
  __$BoardResponseCopyWithImpl(this._self, this._then);

  final _BoardResponse _self;
  final $Res Function(_BoardResponse) _then;

/// Create a copy of BoardResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? board = null,Object? rows = null,}) {
  return _then(_BoardResponse(
board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as BoardMeta,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<BoardRow>,
  ));
}

/// Create a copy of BoardResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardMetaCopyWith<$Res> get board {
  
  return $BoardMetaCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}
}


/// @nodoc
mixin _$BoardMeta {

 int get id; int get season;/// `sleeper` | `espn` | `ensemble`.
 String get provider;/// `live` | `historical`.
 String get baseline; DateTime get generatedAt;/// Rows on the full board; the response may carry fewer (`limit`).
 int get rowCount;/// Snapshot of the dial values the board was built under.
 Map<String, dynamic> get config;
/// Create a copy of BoardMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardMetaCopyWith<BoardMeta> get copyWith => _$BoardMetaCopyWithImpl<BoardMeta>(this as BoardMeta, _$identity);

  /// Serializes this BoardMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardMeta&&(identical(other.id, id) || other.id == id)&&(identical(other.season, season) || other.season == season)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.baseline, baseline) || other.baseline == baseline)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.rowCount, rowCount) || other.rowCount == rowCount)&&const DeepCollectionEquality().equals(other.config, config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,season,provider,baseline,generatedAt,rowCount,const DeepCollectionEquality().hash(config));

@override
String toString() {
  return 'BoardMeta(id: $id, season: $season, provider: $provider, baseline: $baseline, generatedAt: $generatedAt, rowCount: $rowCount, config: $config)';
}


}

/// @nodoc
abstract mixin class $BoardMetaCopyWith<$Res>  {
  factory $BoardMetaCopyWith(BoardMeta value, $Res Function(BoardMeta) _then) = _$BoardMetaCopyWithImpl;
@useResult
$Res call({
 int id, int season, String provider, String baseline, DateTime generatedAt, int rowCount, Map<String, dynamic> config
});




}
/// @nodoc
class _$BoardMetaCopyWithImpl<$Res>
    implements $BoardMetaCopyWith<$Res> {
  _$BoardMetaCopyWithImpl(this._self, this._then);

  final BoardMeta _self;
  final $Res Function(BoardMeta) _then;

/// Create a copy of BoardMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? season = null,Object? provider = null,Object? baseline = null,Object? generatedAt = null,Object? rowCount = null,Object? config = null,}) {
  return _then(BoardMeta(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,baseline: null == baseline ? _self.baseline : baseline // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,rowCount: null == rowCount ? _self.rowCount : rowCount // ignore: cast_nullable_to_non_nullable
as int,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardMeta].
extension BoardMetaPatterns on BoardMeta {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardMeta() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardMeta value)  $default,){
final _that = this;
switch (_that) {
case _BoardMeta():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardMeta value)?  $default,){
final _that = this;
switch (_that) {
case _BoardMeta() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int season,  String provider,  String baseline,  DateTime generatedAt,  int rowCount,  Map<String, dynamic> config)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardMeta() when $default != null:
return $default(_that.id,_that.season,_that.provider,_that.baseline,_that.generatedAt,_that.rowCount,_that.config);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int season,  String provider,  String baseline,  DateTime generatedAt,  int rowCount,  Map<String, dynamic> config)  $default,) {final _that = this;
switch (_that) {
case _BoardMeta():
return $default(_that.id,_that.season,_that.provider,_that.baseline,_that.generatedAt,_that.rowCount,_that.config);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int season,  String provider,  String baseline,  DateTime generatedAt,  int rowCount,  Map<String, dynamic> config)?  $default,) {final _that = this;
switch (_that) {
case _BoardMeta() when $default != null:
return $default(_that.id,_that.season,_that.provider,_that.baseline,_that.generatedAt,_that.rowCount,_that.config);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _BoardMeta implements BoardMeta {
  const _BoardMeta({required this.id, required this.season, required this.provider, required this.baseline, required this.generatedAt, required this.rowCount, required  Map<String, dynamic> config}): _config = config;
  factory _BoardMeta.fromJson(Map<String, dynamic> json) => _$BoardMetaFromJson(json);

@override final  int id;
@override final  int season;
/// `sleeper` | `espn` | `ensemble`.
@override final  String provider;
/// `live` | `historical`.
@override final  String baseline;
@override final  DateTime generatedAt;
/// Rows on the full board; the response may carry fewer (`limit`).
@override final  int rowCount;
/// Snapshot of the dial values the board was built under.
 final  Map<String, dynamic> _config;
/// Snapshot of the dial values the board was built under.
@override Map<String, dynamic> get config {
  if (_config is EqualUnmodifiableMapView) return _config;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_config);
}


/// Create a copy of BoardMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardMetaCopyWith<_BoardMeta> get copyWith => __$BoardMetaCopyWithImpl<_BoardMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardMeta&&(identical(other.id, id) || other.id == id)&&(identical(other.season, season) || other.season == season)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.baseline, baseline) || other.baseline == baseline)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.rowCount, rowCount) || other.rowCount == rowCount)&&const DeepCollectionEquality().equals(other._config, _config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,season,provider,baseline,generatedAt,rowCount,const DeepCollectionEquality().hash(_config));

@override
String toString() {
  return 'BoardMeta(id: $id, season: $season, provider: $provider, baseline: $baseline, generatedAt: $generatedAt, rowCount: $rowCount, config: $config)';
}


}

/// @nodoc
abstract mixin class _$BoardMetaCopyWith<$Res> implements $BoardMetaCopyWith<$Res> {
  factory _$BoardMetaCopyWith(_BoardMeta value, $Res Function(_BoardMeta) _then) = __$BoardMetaCopyWithImpl;
@override @useResult
$Res call({
 int id, int season, String provider, String baseline, DateTime generatedAt, int rowCount, Map<String, dynamic> config
});




}
/// @nodoc
class __$BoardMetaCopyWithImpl<$Res>
    implements _$BoardMetaCopyWith<$Res> {
  __$BoardMetaCopyWithImpl(this._self, this._then);

  final _BoardMeta _self;
  final $Res Function(_BoardMeta) _then;

/// Create a copy of BoardMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? season = null,Object? provider = null,Object? baseline = null,Object? generatedAt = null,Object? rowCount = null,Object? config = null,}) {
  return _then(_BoardMeta(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,baseline: null == baseline ? _self.baseline : baseline // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,rowCount: null == rowCount ? _self.rowCount : rowCount // ignore: cast_nullable_to_non_nullable
as int,config: null == config ? _self._config : config // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$BoardRow {

 int get rank; String get sleeperId; String get name; String get position; String? get team;/// Sleeper's status string, e.g. `Questionable`, `IR`, `PUP`; null = healthy.
 String? get injuryStatus;/// Projected season points under the board's provider (ensemble by default).
 double get points;/// Replacement-level points used for this position.
 double get baseline; double get vorp; int get posRank;/// Null below the tiered depth for the position.
 int? get tier; bool get cliff; double? get gapToNext; double? get adp;/// Positive = value (ADP later than rank), negative = reach.
 double? get adpDelta;/// `value` | `reach` when |adpDelta| clears the configured threshold.
 String? get adpFlag;/// Point spread between ensemble members; null when only one provider.
 double? get spread; bool get disagree;/// Per-provider season points, e.g. `{"sleeper": 331.4, "espn": 364.8}`.
 Map<String, double> get components;
/// Create a copy of BoardRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardRowCopyWith<BoardRow> get copyWith => _$BoardRowCopyWithImpl<BoardRow>(this as BoardRow, _$identity);

  /// Serializes this BoardRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardRow&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.sleeperId, sleeperId) || other.sleeperId == sleeperId)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.team, team) || other.team == team)&&(identical(other.injuryStatus, injuryStatus) || other.injuryStatus == injuryStatus)&&(identical(other.points, points) || other.points == points)&&(identical(other.baseline, baseline) || other.baseline == baseline)&&(identical(other.vorp, vorp) || other.vorp == vorp)&&(identical(other.posRank, posRank) || other.posRank == posRank)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.cliff, cliff) || other.cliff == cliff)&&(identical(other.gapToNext, gapToNext) || other.gapToNext == gapToNext)&&(identical(other.adp, adp) || other.adp == adp)&&(identical(other.adpDelta, adpDelta) || other.adpDelta == adpDelta)&&(identical(other.adpFlag, adpFlag) || other.adpFlag == adpFlag)&&(identical(other.spread, spread) || other.spread == spread)&&(identical(other.disagree, disagree) || other.disagree == disagree)&&const DeepCollectionEquality().equals(other.components, components));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,rank,sleeperId,name,position,team,injuryStatus,points,baseline,vorp,posRank,tier,cliff,gapToNext,adp,adpDelta,adpFlag,spread,disagree,const DeepCollectionEquality().hash(components)]);

@override
String toString() {
  return 'BoardRow(rank: $rank, sleeperId: $sleeperId, name: $name, position: $position, team: $team, injuryStatus: $injuryStatus, points: $points, baseline: $baseline, vorp: $vorp, posRank: $posRank, tier: $tier, cliff: $cliff, gapToNext: $gapToNext, adp: $adp, adpDelta: $adpDelta, adpFlag: $adpFlag, spread: $spread, disagree: $disagree, components: $components)';
}


}

/// @nodoc
abstract mixin class $BoardRowCopyWith<$Res>  {
  factory $BoardRowCopyWith(BoardRow value, $Res Function(BoardRow) _then) = _$BoardRowCopyWithImpl;
@useResult
$Res call({
 int rank, String sleeperId, String name, String position, String? team, String? injuryStatus, double points, double baseline, double vorp, int posRank, int? tier, bool cliff, double? gapToNext, double? adp, double? adpDelta, String? adpFlag, double? spread, bool disagree, Map<String, double> components
});




}
/// @nodoc
class _$BoardRowCopyWithImpl<$Res>
    implements $BoardRowCopyWith<$Res> {
  _$BoardRowCopyWithImpl(this._self, this._then);

  final BoardRow _self;
  final $Res Function(BoardRow) _then;

/// Create a copy of BoardRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rank = null,Object? sleeperId = null,Object? name = null,Object? position = null,Object? team = freezed,Object? injuryStatus = freezed,Object? points = null,Object? baseline = null,Object? vorp = null,Object? posRank = null,Object? tier = freezed,Object? cliff = null,Object? gapToNext = freezed,Object? adp = freezed,Object? adpDelta = freezed,Object? adpFlag = freezed,Object? spread = freezed,Object? disagree = null,Object? components = null,}) {
  return _then(BoardRow(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,sleeperId: null == sleeperId ? _self.sleeperId : sleeperId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,team: freezed == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as String?,injuryStatus: freezed == injuryStatus ? _self.injuryStatus : injuryStatus // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,baseline: null == baseline ? _self.baseline : baseline // ignore: cast_nullable_to_non_nullable
as double,vorp: null == vorp ? _self.vorp : vorp // ignore: cast_nullable_to_non_nullable
as double,posRank: null == posRank ? _self.posRank : posRank // ignore: cast_nullable_to_non_nullable
as int,tier: freezed == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as int?,cliff: null == cliff ? _self.cliff : cliff // ignore: cast_nullable_to_non_nullable
as bool,gapToNext: freezed == gapToNext ? _self.gapToNext : gapToNext // ignore: cast_nullable_to_non_nullable
as double?,adp: freezed == adp ? _self.adp : adp // ignore: cast_nullable_to_non_nullable
as double?,adpDelta: freezed == adpDelta ? _self.adpDelta : adpDelta // ignore: cast_nullable_to_non_nullable
as double?,adpFlag: freezed == adpFlag ? _self.adpFlag : adpFlag // ignore: cast_nullable_to_non_nullable
as String?,spread: freezed == spread ? _self.spread : spread // ignore: cast_nullable_to_non_nullable
as double?,disagree: null == disagree ? _self.disagree : disagree // ignore: cast_nullable_to_non_nullable
as bool,components: null == components ? _self.components : components // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardRow].
extension BoardRowPatterns on BoardRow {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardRow() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardRow value)  $default,){
final _that = this;
switch (_that) {
case _BoardRow():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardRow value)?  $default,){
final _that = this;
switch (_that) {
case _BoardRow() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rank,  String sleeperId,  String name,  String position,  String? team,  String? injuryStatus,  double points,  double baseline,  double vorp,  int posRank,  int? tier,  bool cliff,  double? gapToNext,  double? adp,  double? adpDelta,  String? adpFlag,  double? spread,  bool disagree,  Map<String, double> components)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardRow() when $default != null:
return $default(_that.rank,_that.sleeperId,_that.name,_that.position,_that.team,_that.injuryStatus,_that.points,_that.baseline,_that.vorp,_that.posRank,_that.tier,_that.cliff,_that.gapToNext,_that.adp,_that.adpDelta,_that.adpFlag,_that.spread,_that.disagree,_that.components);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rank,  String sleeperId,  String name,  String position,  String? team,  String? injuryStatus,  double points,  double baseline,  double vorp,  int posRank,  int? tier,  bool cliff,  double? gapToNext,  double? adp,  double? adpDelta,  String? adpFlag,  double? spread,  bool disagree,  Map<String, double> components)  $default,) {final _that = this;
switch (_that) {
case _BoardRow():
return $default(_that.rank,_that.sleeperId,_that.name,_that.position,_that.team,_that.injuryStatus,_that.points,_that.baseline,_that.vorp,_that.posRank,_that.tier,_that.cliff,_that.gapToNext,_that.adp,_that.adpDelta,_that.adpFlag,_that.spread,_that.disagree,_that.components);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rank,  String sleeperId,  String name,  String position,  String? team,  String? injuryStatus,  double points,  double baseline,  double vorp,  int posRank,  int? tier,  bool cliff,  double? gapToNext,  double? adp,  double? adpDelta,  String? adpFlag,  double? spread,  bool disagree,  Map<String, double> components)?  $default,) {final _that = this;
switch (_that) {
case _BoardRow() when $default != null:
return $default(_that.rank,_that.sleeperId,_that.name,_that.position,_that.team,_that.injuryStatus,_that.points,_that.baseline,_that.vorp,_that.posRank,_that.tier,_that.cliff,_that.gapToNext,_that.adp,_that.adpDelta,_that.adpFlag,_that.spread,_that.disagree,_that.components);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _BoardRow implements BoardRow {
  const _BoardRow({required this.rank, required this.sleeperId, required this.name, required this.position, this.team, this.injuryStatus, required this.points, required this.baseline, required this.vorp, required this.posRank, this.tier, required this.cliff, this.gapToNext, this.adp, this.adpDelta, this.adpFlag, this.spread, required this.disagree, required  Map<String, double> components}): _components = components;
  factory _BoardRow.fromJson(Map<String, dynamic> json) => _$BoardRowFromJson(json);

@override final  int rank;
@override final  String sleeperId;
@override final  String name;
@override final  String position;
@override final  String? team;
/// Sleeper's status string, e.g. `Questionable`, `IR`, `PUP`; null = healthy.
@override final  String? injuryStatus;
/// Projected season points under the board's provider (ensemble by default).
@override final  double points;
/// Replacement-level points used for this position.
@override final  double baseline;
@override final  double vorp;
@override final  int posRank;
/// Null below the tiered depth for the position.
@override final  int? tier;
@override final  bool cliff;
@override final  double? gapToNext;
@override final  double? adp;
/// Positive = value (ADP later than rank), negative = reach.
@override final  double? adpDelta;
/// `value` | `reach` when |adpDelta| clears the configured threshold.
@override final  String? adpFlag;
/// Point spread between ensemble members; null when only one provider.
@override final  double? spread;
@override final  bool disagree;
/// Per-provider season points, e.g. `{"sleeper": 331.4, "espn": 364.8}`.
 final  Map<String, double> _components;
/// Per-provider season points, e.g. `{"sleeper": 331.4, "espn": 364.8}`.
@override Map<String, double> get components {
  if (_components is EqualUnmodifiableMapView) return _components;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_components);
}


/// Create a copy of BoardRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardRowCopyWith<_BoardRow> get copyWith => __$BoardRowCopyWithImpl<_BoardRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardRow&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.sleeperId, sleeperId) || other.sleeperId == sleeperId)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.team, team) || other.team == team)&&(identical(other.injuryStatus, injuryStatus) || other.injuryStatus == injuryStatus)&&(identical(other.points, points) || other.points == points)&&(identical(other.baseline, baseline) || other.baseline == baseline)&&(identical(other.vorp, vorp) || other.vorp == vorp)&&(identical(other.posRank, posRank) || other.posRank == posRank)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.cliff, cliff) || other.cliff == cliff)&&(identical(other.gapToNext, gapToNext) || other.gapToNext == gapToNext)&&(identical(other.adp, adp) || other.adp == adp)&&(identical(other.adpDelta, adpDelta) || other.adpDelta == adpDelta)&&(identical(other.adpFlag, adpFlag) || other.adpFlag == adpFlag)&&(identical(other.spread, spread) || other.spread == spread)&&(identical(other.disagree, disagree) || other.disagree == disagree)&&const DeepCollectionEquality().equals(other._components, _components));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,rank,sleeperId,name,position,team,injuryStatus,points,baseline,vorp,posRank,tier,cliff,gapToNext,adp,adpDelta,adpFlag,spread,disagree,const DeepCollectionEquality().hash(_components)]);

@override
String toString() {
  return 'BoardRow(rank: $rank, sleeperId: $sleeperId, name: $name, position: $position, team: $team, injuryStatus: $injuryStatus, points: $points, baseline: $baseline, vorp: $vorp, posRank: $posRank, tier: $tier, cliff: $cliff, gapToNext: $gapToNext, adp: $adp, adpDelta: $adpDelta, adpFlag: $adpFlag, spread: $spread, disagree: $disagree, components: $components)';
}


}

/// @nodoc
abstract mixin class _$BoardRowCopyWith<$Res> implements $BoardRowCopyWith<$Res> {
  factory _$BoardRowCopyWith(_BoardRow value, $Res Function(_BoardRow) _then) = __$BoardRowCopyWithImpl;
@override @useResult
$Res call({
 int rank, String sleeperId, String name, String position, String? team, String? injuryStatus, double points, double baseline, double vorp, int posRank, int? tier, bool cliff, double? gapToNext, double? adp, double? adpDelta, String? adpFlag, double? spread, bool disagree, Map<String, double> components
});




}
/// @nodoc
class __$BoardRowCopyWithImpl<$Res>
    implements _$BoardRowCopyWith<$Res> {
  __$BoardRowCopyWithImpl(this._self, this._then);

  final _BoardRow _self;
  final $Res Function(_BoardRow) _then;

/// Create a copy of BoardRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rank = null,Object? sleeperId = null,Object? name = null,Object? position = null,Object? team = freezed,Object? injuryStatus = freezed,Object? points = null,Object? baseline = null,Object? vorp = null,Object? posRank = null,Object? tier = freezed,Object? cliff = null,Object? gapToNext = freezed,Object? adp = freezed,Object? adpDelta = freezed,Object? adpFlag = freezed,Object? spread = freezed,Object? disagree = null,Object? components = null,}) {
  return _then(_BoardRow(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,sleeperId: null == sleeperId ? _self.sleeperId : sleeperId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,team: freezed == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as String?,injuryStatus: freezed == injuryStatus ? _self.injuryStatus : injuryStatus // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,baseline: null == baseline ? _self.baseline : baseline // ignore: cast_nullable_to_non_nullable
as double,vorp: null == vorp ? _self.vorp : vorp // ignore: cast_nullable_to_non_nullable
as double,posRank: null == posRank ? _self.posRank : posRank // ignore: cast_nullable_to_non_nullable
as int,tier: freezed == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as int?,cliff: null == cliff ? _self.cliff : cliff // ignore: cast_nullable_to_non_nullable
as bool,gapToNext: freezed == gapToNext ? _self.gapToNext : gapToNext // ignore: cast_nullable_to_non_nullable
as double?,adp: freezed == adp ? _self.adp : adp // ignore: cast_nullable_to_non_nullable
as double?,adpDelta: freezed == adpDelta ? _self.adpDelta : adpDelta // ignore: cast_nullable_to_non_nullable
as double?,adpFlag: freezed == adpFlag ? _self.adpFlag : adpFlag // ignore: cast_nullable_to_non_nullable
as String?,spread: freezed == spread ? _self.spread : spread // ignore: cast_nullable_to_non_nullable
as double?,disagree: null == disagree ? _self.disagree : disagree // ignore: cast_nullable_to_non_nullable
as bool,components: null == components ? _self._components : components // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}

// dart format on
