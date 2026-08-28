// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'draft_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DraftState {

 String get draftId; DraftSpec get spec; DraftClock get clock;/// Null until the runner knows my slot.
 DraftRoster? get myRoster;/// League-wide feed, most recent first (last 8).
 List<RecentPick> get recentPicks; Recompute get recompute; DraftBoardMeta get board; DraftPoller get poller; bool? get running;/// Best pick first by `pick_score`. `rank` is overall and does not
/// renumber under a position filter.
 List<DraftRow> get rows;
/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftStateCopyWith<DraftState> get copyWith => _$DraftStateCopyWithImpl<DraftState>(this as DraftState, _$identity);

  /// Serializes this DraftState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftState&&(identical(other.draftId, draftId) || other.draftId == draftId)&&(identical(other.spec, spec) || other.spec == spec)&&(identical(other.clock, clock) || other.clock == clock)&&(identical(other.myRoster, myRoster) || other.myRoster == myRoster)&&const DeepCollectionEquality().equals(other.recentPicks, recentPicks)&&(identical(other.recompute, recompute) || other.recompute == recompute)&&(identical(other.board, board) || other.board == board)&&(identical(other.poller, poller) || other.poller == poller)&&(identical(other.running, running) || other.running == running)&&const DeepCollectionEquality().equals(other.rows, rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,draftId,spec,clock,myRoster,const DeepCollectionEquality().hash(recentPicks),recompute,board,poller,running,const DeepCollectionEquality().hash(rows));

@override
String toString() {
  return 'DraftState(draftId: $draftId, spec: $spec, clock: $clock, myRoster: $myRoster, recentPicks: $recentPicks, recompute: $recompute, board: $board, poller: $poller, running: $running, rows: $rows)';
}


}

/// @nodoc
abstract mixin class $DraftStateCopyWith<$Res>  {
  factory $DraftStateCopyWith(DraftState value, $Res Function(DraftState) _then) = _$DraftStateCopyWithImpl;
@useResult
$Res call({
 String draftId, DraftSpec spec, DraftClock clock, DraftRoster? myRoster, List<RecentPick> recentPicks, Recompute recompute, DraftBoardMeta board, DraftPoller poller, bool? running, List<DraftRow> rows
});


$DraftSpecCopyWith<$Res> get spec;$DraftClockCopyWith<$Res> get clock;$DraftRosterCopyWith<$Res>? get myRoster;$RecomputeCopyWith<$Res> get recompute;$DraftBoardMetaCopyWith<$Res> get board;$DraftPollerCopyWith<$Res> get poller;

}
/// @nodoc
class _$DraftStateCopyWithImpl<$Res>
    implements $DraftStateCopyWith<$Res> {
  _$DraftStateCopyWithImpl(this._self, this._then);

  final DraftState _self;
  final $Res Function(DraftState) _then;

/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? draftId = null,Object? spec = null,Object? clock = null,Object? myRoster = freezed,Object? recentPicks = null,Object? recompute = null,Object? board = null,Object? poller = null,Object? running = freezed,Object? rows = null,}) {
  return _then(DraftState(
draftId: null == draftId ? _self.draftId : draftId // ignore: cast_nullable_to_non_nullable
as String,spec: null == spec ? _self.spec : spec // ignore: cast_nullable_to_non_nullable
as DraftSpec,clock: null == clock ? _self.clock : clock // ignore: cast_nullable_to_non_nullable
as DraftClock,myRoster: freezed == myRoster ? _self.myRoster : myRoster // ignore: cast_nullable_to_non_nullable
as DraftRoster?,recentPicks: null == recentPicks ? _self.recentPicks : recentPicks // ignore: cast_nullable_to_non_nullable
as List<RecentPick>,recompute: null == recompute ? _self.recompute : recompute // ignore: cast_nullable_to_non_nullable
as Recompute,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as DraftBoardMeta,poller: null == poller ? _self.poller : poller // ignore: cast_nullable_to_non_nullable
as DraftPoller,running: freezed == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool?,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<DraftRow>,
  ));
}
/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DraftSpecCopyWith<$Res> get spec {
  
  return $DraftSpecCopyWith<$Res>(_self.spec, (value) {
    return _then(_self.copyWith(spec: value));
  });
}/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DraftClockCopyWith<$Res> get clock {
  
  return $DraftClockCopyWith<$Res>(_self.clock, (value) {
    return _then(_self.copyWith(clock: value));
  });
}/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DraftRosterCopyWith<$Res>? get myRoster {
    if (_self.myRoster == null) {
    return null;
  }

  return $DraftRosterCopyWith<$Res>(_self.myRoster!, (value) {
    return _then(_self.copyWith(myRoster: value));
  });
}/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecomputeCopyWith<$Res> get recompute {
  
  return $RecomputeCopyWith<$Res>(_self.recompute, (value) {
    return _then(_self.copyWith(recompute: value));
  });
}/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DraftBoardMetaCopyWith<$Res> get board {
  
  return $DraftBoardMetaCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DraftPollerCopyWith<$Res> get poller {
  
  return $DraftPollerCopyWith<$Res>(_self.poller, (value) {
    return _then(_self.copyWith(poller: value));
  });
}
}


/// Adds pattern-matching-related methods to [DraftState].
extension DraftStatePatterns on DraftState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftState value)  $default,){
final _that = this;
switch (_that) {
case _DraftState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftState value)?  $default,){
final _that = this;
switch (_that) {
case _DraftState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String draftId,  DraftSpec spec,  DraftClock clock,  DraftRoster? myRoster,  List<RecentPick> recentPicks,  Recompute recompute,  DraftBoardMeta board,  DraftPoller poller,  bool? running,  List<DraftRow> rows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftState() when $default != null:
return $default(_that.draftId,_that.spec,_that.clock,_that.myRoster,_that.recentPicks,_that.recompute,_that.board,_that.poller,_that.running,_that.rows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String draftId,  DraftSpec spec,  DraftClock clock,  DraftRoster? myRoster,  List<RecentPick> recentPicks,  Recompute recompute,  DraftBoardMeta board,  DraftPoller poller,  bool? running,  List<DraftRow> rows)  $default,) {final _that = this;
switch (_that) {
case _DraftState():
return $default(_that.draftId,_that.spec,_that.clock,_that.myRoster,_that.recentPicks,_that.recompute,_that.board,_that.poller,_that.running,_that.rows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String draftId,  DraftSpec spec,  DraftClock clock,  DraftRoster? myRoster,  List<RecentPick> recentPicks,  Recompute recompute,  DraftBoardMeta board,  DraftPoller poller,  bool? running,  List<DraftRow> rows)?  $default,) {final _that = this;
switch (_that) {
case _DraftState() when $default != null:
return $default(_that.draftId,_that.spec,_that.clock,_that.myRoster,_that.recentPicks,_that.recompute,_that.board,_that.poller,_that.running,_that.rows);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DraftState implements DraftState {
  const _DraftState({required this.draftId, required this.spec, required this.clock, this.myRoster, required  List<RecentPick> recentPicks, required this.recompute, required this.board, required this.poller, this.running, required  List<DraftRow> rows}): _recentPicks = recentPicks,_rows = rows;
  factory _DraftState.fromJson(Map<String, dynamic> json) => _$DraftStateFromJson(json);

@override final  String draftId;
@override final  DraftSpec spec;
@override final  DraftClock clock;
/// Null until the runner knows my slot.
@override final  DraftRoster? myRoster;
/// League-wide feed, most recent first (last 8).
 final  List<RecentPick> _recentPicks;
/// League-wide feed, most recent first (last 8).
@override List<RecentPick> get recentPicks {
  if (_recentPicks is EqualUnmodifiableListView) return _recentPicks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentPicks);
}

@override final  Recompute recompute;
@override final  DraftBoardMeta board;
@override final  DraftPoller poller;
@override final  bool? running;
/// Best pick first by `pick_score`. `rank` is overall and does not
/// renumber under a position filter.
 final  List<DraftRow> _rows;
/// Best pick first by `pick_score`. `rank` is overall and does not
/// renumber under a position filter.
@override List<DraftRow> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}


/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftStateCopyWith<_DraftState> get copyWith => __$DraftStateCopyWithImpl<_DraftState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftState&&(identical(other.draftId, draftId) || other.draftId == draftId)&&(identical(other.spec, spec) || other.spec == spec)&&(identical(other.clock, clock) || other.clock == clock)&&(identical(other.myRoster, myRoster) || other.myRoster == myRoster)&&const DeepCollectionEquality().equals(other._recentPicks, _recentPicks)&&(identical(other.recompute, recompute) || other.recompute == recompute)&&(identical(other.board, board) || other.board == board)&&(identical(other.poller, poller) || other.poller == poller)&&(identical(other.running, running) || other.running == running)&&const DeepCollectionEquality().equals(other._rows, _rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,draftId,spec,clock,myRoster,const DeepCollectionEquality().hash(_recentPicks),recompute,board,poller,running,const DeepCollectionEquality().hash(_rows));

@override
String toString() {
  return 'DraftState(draftId: $draftId, spec: $spec, clock: $clock, myRoster: $myRoster, recentPicks: $recentPicks, recompute: $recompute, board: $board, poller: $poller, running: $running, rows: $rows)';
}


}

/// @nodoc
abstract mixin class _$DraftStateCopyWith<$Res> implements $DraftStateCopyWith<$Res> {
  factory _$DraftStateCopyWith(_DraftState value, $Res Function(_DraftState) _then) = __$DraftStateCopyWithImpl;
@override @useResult
$Res call({
 String draftId, DraftSpec spec, DraftClock clock, DraftRoster? myRoster, List<RecentPick> recentPicks, Recompute recompute, DraftBoardMeta board, DraftPoller poller, bool? running, List<DraftRow> rows
});


@override $DraftSpecCopyWith<$Res> get spec;@override $DraftClockCopyWith<$Res> get clock;@override $DraftRosterCopyWith<$Res>? get myRoster;@override $RecomputeCopyWith<$Res> get recompute;@override $DraftBoardMetaCopyWith<$Res> get board;@override $DraftPollerCopyWith<$Res> get poller;

}
/// @nodoc
class __$DraftStateCopyWithImpl<$Res>
    implements _$DraftStateCopyWith<$Res> {
  __$DraftStateCopyWithImpl(this._self, this._then);

  final _DraftState _self;
  final $Res Function(_DraftState) _then;

/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? draftId = null,Object? spec = null,Object? clock = null,Object? myRoster = freezed,Object? recentPicks = null,Object? recompute = null,Object? board = null,Object? poller = null,Object? running = freezed,Object? rows = null,}) {
  return _then(_DraftState(
draftId: null == draftId ? _self.draftId : draftId // ignore: cast_nullable_to_non_nullable
as String,spec: null == spec ? _self.spec : spec // ignore: cast_nullable_to_non_nullable
as DraftSpec,clock: null == clock ? _self.clock : clock // ignore: cast_nullable_to_non_nullable
as DraftClock,myRoster: freezed == myRoster ? _self.myRoster : myRoster // ignore: cast_nullable_to_non_nullable
as DraftRoster?,recentPicks: null == recentPicks ? _self._recentPicks : recentPicks // ignore: cast_nullable_to_non_nullable
as List<RecentPick>,recompute: null == recompute ? _self.recompute : recompute // ignore: cast_nullable_to_non_nullable
as Recompute,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as DraftBoardMeta,poller: null == poller ? _self.poller : poller // ignore: cast_nullable_to_non_nullable
as DraftPoller,running: freezed == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool?,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<DraftRow>,
  ));
}

/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DraftSpecCopyWith<$Res> get spec {
  
  return $DraftSpecCopyWith<$Res>(_self.spec, (value) {
    return _then(_self.copyWith(spec: value));
  });
}/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DraftClockCopyWith<$Res> get clock {
  
  return $DraftClockCopyWith<$Res>(_self.clock, (value) {
    return _then(_self.copyWith(clock: value));
  });
}/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DraftRosterCopyWith<$Res>? get myRoster {
    if (_self.myRoster == null) {
    return null;
  }

  return $DraftRosterCopyWith<$Res>(_self.myRoster!, (value) {
    return _then(_self.copyWith(myRoster: value));
  });
}/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecomputeCopyWith<$Res> get recompute {
  
  return $RecomputeCopyWith<$Res>(_self.recompute, (value) {
    return _then(_self.copyWith(recompute: value));
  });
}/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DraftBoardMetaCopyWith<$Res> get board {
  
  return $DraftBoardMetaCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DraftPollerCopyWith<$Res> get poller {
  
  return $DraftPollerCopyWith<$Res>(_self.poller, (value) {
    return _then(_self.copyWith(poller: value));
  });
}
}


/// @nodoc
mixin _$DraftSpec {

 int get teams; int get rounds; String get type; int get totalPicks;
/// Create a copy of DraftSpec
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftSpecCopyWith<DraftSpec> get copyWith => _$DraftSpecCopyWithImpl<DraftSpec>(this as DraftSpec, _$identity);

  /// Serializes this DraftSpec to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftSpec&&(identical(other.teams, teams) || other.teams == teams)&&(identical(other.rounds, rounds) || other.rounds == rounds)&&(identical(other.type, type) || other.type == type)&&(identical(other.totalPicks, totalPicks) || other.totalPicks == totalPicks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teams,rounds,type,totalPicks);

@override
String toString() {
  return 'DraftSpec(teams: $teams, rounds: $rounds, type: $type, totalPicks: $totalPicks)';
}


}

/// @nodoc
abstract mixin class $DraftSpecCopyWith<$Res>  {
  factory $DraftSpecCopyWith(DraftSpec value, $Res Function(DraftSpec) _then) = _$DraftSpecCopyWithImpl;
@useResult
$Res call({
 int teams, int rounds, String type, int totalPicks
});




}
/// @nodoc
class _$DraftSpecCopyWithImpl<$Res>
    implements $DraftSpecCopyWith<$Res> {
  _$DraftSpecCopyWithImpl(this._self, this._then);

  final DraftSpec _self;
  final $Res Function(DraftSpec) _then;

/// Create a copy of DraftSpec
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teams = null,Object? rounds = null,Object? type = null,Object? totalPicks = null,}) {
  return _then(DraftSpec(
teams: null == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as int,rounds: null == rounds ? _self.rounds : rounds // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,totalPicks: null == totalPicks ? _self.totalPicks : totalPicks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftSpec].
extension DraftSpecPatterns on DraftSpec {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftSpec value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftSpec() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftSpec value)  $default,){
final _that = this;
switch (_that) {
case _DraftSpec():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftSpec value)?  $default,){
final _that = this;
switch (_that) {
case _DraftSpec() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int teams,  int rounds,  String type,  int totalPicks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftSpec() when $default != null:
return $default(_that.teams,_that.rounds,_that.type,_that.totalPicks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int teams,  int rounds,  String type,  int totalPicks)  $default,) {final _that = this;
switch (_that) {
case _DraftSpec():
return $default(_that.teams,_that.rounds,_that.type,_that.totalPicks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int teams,  int rounds,  String type,  int totalPicks)?  $default,) {final _that = this;
switch (_that) {
case _DraftSpec() when $default != null:
return $default(_that.teams,_that.rounds,_that.type,_that.totalPicks);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DraftSpec implements DraftSpec {
  const _DraftSpec({required this.teams, required this.rounds, required this.type, required this.totalPicks});
  factory _DraftSpec.fromJson(Map<String, dynamic> json) => _$DraftSpecFromJson(json);

@override final  int teams;
@override final  int rounds;
@override final  String type;
@override final  int totalPicks;

/// Create a copy of DraftSpec
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftSpecCopyWith<_DraftSpec> get copyWith => __$DraftSpecCopyWithImpl<_DraftSpec>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftSpecToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftSpec&&(identical(other.teams, teams) || other.teams == teams)&&(identical(other.rounds, rounds) || other.rounds == rounds)&&(identical(other.type, type) || other.type == type)&&(identical(other.totalPicks, totalPicks) || other.totalPicks == totalPicks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teams,rounds,type,totalPicks);

@override
String toString() {
  return 'DraftSpec(teams: $teams, rounds: $rounds, type: $type, totalPicks: $totalPicks)';
}


}

/// @nodoc
abstract mixin class _$DraftSpecCopyWith<$Res> implements $DraftSpecCopyWith<$Res> {
  factory _$DraftSpecCopyWith(_DraftSpec value, $Res Function(_DraftSpec) _then) = __$DraftSpecCopyWithImpl;
@override @useResult
$Res call({
 int teams, int rounds, String type, int totalPicks
});




}
/// @nodoc
class __$DraftSpecCopyWithImpl<$Res>
    implements _$DraftSpecCopyWith<$Res> {
  __$DraftSpecCopyWithImpl(this._self, this._then);

  final _DraftSpec _self;
  final $Res Function(_DraftSpec) _then;

/// Create a copy of DraftSpec
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teams = null,Object? rounds = null,Object? type = null,Object? totalPicks = null,}) {
  return _then(_DraftSpec(
teams: null == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as int,rounds: null == rounds ? _self.rounds : rounds // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,totalPicks: null == totalPicks ? _self.totalPicks : totalPicks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DraftClock {

 int get currentPick; int? get round;/// Slot number on the clock; null when the draft is complete.
 int? get onTheClock;/// Null until Sleeper assigns `draft_order` — fall back to the slot.
 String? get onTheClockTeamName; int? get mySlot; bool get myTurn; int? get myNextPick;/// 0 = on the clock. Null when there is no next pick.
 int? get picksUntilMyTurn; int get picksMade; bool get complete; int? get pickTimerS;/// UTC, fixed for the life of the current pick. Null when the draft has
/// no timer or the start of the current pick is unknown.
 DateTime? get pickDeadline;
/// Create a copy of DraftClock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftClockCopyWith<DraftClock> get copyWith => _$DraftClockCopyWithImpl<DraftClock>(this as DraftClock, _$identity);

  /// Serializes this DraftClock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftClock&&(identical(other.currentPick, currentPick) || other.currentPick == currentPick)&&(identical(other.round, round) || other.round == round)&&(identical(other.onTheClock, onTheClock) || other.onTheClock == onTheClock)&&(identical(other.onTheClockTeamName, onTheClockTeamName) || other.onTheClockTeamName == onTheClockTeamName)&&(identical(other.mySlot, mySlot) || other.mySlot == mySlot)&&(identical(other.myTurn, myTurn) || other.myTurn == myTurn)&&(identical(other.myNextPick, myNextPick) || other.myNextPick == myNextPick)&&(identical(other.picksUntilMyTurn, picksUntilMyTurn) || other.picksUntilMyTurn == picksUntilMyTurn)&&(identical(other.picksMade, picksMade) || other.picksMade == picksMade)&&(identical(other.complete, complete) || other.complete == complete)&&(identical(other.pickTimerS, pickTimerS) || other.pickTimerS == pickTimerS)&&(identical(other.pickDeadline, pickDeadline) || other.pickDeadline == pickDeadline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPick,round,onTheClock,onTheClockTeamName,mySlot,myTurn,myNextPick,picksUntilMyTurn,picksMade,complete,pickTimerS,pickDeadline);

@override
String toString() {
  return 'DraftClock(currentPick: $currentPick, round: $round, onTheClock: $onTheClock, onTheClockTeamName: $onTheClockTeamName, mySlot: $mySlot, myTurn: $myTurn, myNextPick: $myNextPick, picksUntilMyTurn: $picksUntilMyTurn, picksMade: $picksMade, complete: $complete, pickTimerS: $pickTimerS, pickDeadline: $pickDeadline)';
}


}

/// @nodoc
abstract mixin class $DraftClockCopyWith<$Res>  {
  factory $DraftClockCopyWith(DraftClock value, $Res Function(DraftClock) _then) = _$DraftClockCopyWithImpl;
@useResult
$Res call({
 int currentPick, int? round, int? onTheClock, String? onTheClockTeamName, int? mySlot, bool myTurn, int? myNextPick, int? picksUntilMyTurn, int picksMade, bool complete, int? pickTimerS, DateTime? pickDeadline
});




}
/// @nodoc
class _$DraftClockCopyWithImpl<$Res>
    implements $DraftClockCopyWith<$Res> {
  _$DraftClockCopyWithImpl(this._self, this._then);

  final DraftClock _self;
  final $Res Function(DraftClock) _then;

/// Create a copy of DraftClock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPick = null,Object? round = freezed,Object? onTheClock = freezed,Object? onTheClockTeamName = freezed,Object? mySlot = freezed,Object? myTurn = null,Object? myNextPick = freezed,Object? picksUntilMyTurn = freezed,Object? picksMade = null,Object? complete = null,Object? pickTimerS = freezed,Object? pickDeadline = freezed,}) {
  return _then(DraftClock(
currentPick: null == currentPick ? _self.currentPick : currentPick // ignore: cast_nullable_to_non_nullable
as int,round: freezed == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int?,onTheClock: freezed == onTheClock ? _self.onTheClock : onTheClock // ignore: cast_nullable_to_non_nullable
as int?,onTheClockTeamName: freezed == onTheClockTeamName ? _self.onTheClockTeamName : onTheClockTeamName // ignore: cast_nullable_to_non_nullable
as String?,mySlot: freezed == mySlot ? _self.mySlot : mySlot // ignore: cast_nullable_to_non_nullable
as int?,myTurn: null == myTurn ? _self.myTurn : myTurn // ignore: cast_nullable_to_non_nullable
as bool,myNextPick: freezed == myNextPick ? _self.myNextPick : myNextPick // ignore: cast_nullable_to_non_nullable
as int?,picksUntilMyTurn: freezed == picksUntilMyTurn ? _self.picksUntilMyTurn : picksUntilMyTurn // ignore: cast_nullable_to_non_nullable
as int?,picksMade: null == picksMade ? _self.picksMade : picksMade // ignore: cast_nullable_to_non_nullable
as int,complete: null == complete ? _self.complete : complete // ignore: cast_nullable_to_non_nullable
as bool,pickTimerS: freezed == pickTimerS ? _self.pickTimerS : pickTimerS // ignore: cast_nullable_to_non_nullable
as int?,pickDeadline: freezed == pickDeadline ? _self.pickDeadline : pickDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftClock].
extension DraftClockPatterns on DraftClock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftClock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftClock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftClock value)  $default,){
final _that = this;
switch (_that) {
case _DraftClock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftClock value)?  $default,){
final _that = this;
switch (_that) {
case _DraftClock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentPick,  int? round,  int? onTheClock,  String? onTheClockTeamName,  int? mySlot,  bool myTurn,  int? myNextPick,  int? picksUntilMyTurn,  int picksMade,  bool complete,  int? pickTimerS,  DateTime? pickDeadline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftClock() when $default != null:
return $default(_that.currentPick,_that.round,_that.onTheClock,_that.onTheClockTeamName,_that.mySlot,_that.myTurn,_that.myNextPick,_that.picksUntilMyTurn,_that.picksMade,_that.complete,_that.pickTimerS,_that.pickDeadline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentPick,  int? round,  int? onTheClock,  String? onTheClockTeamName,  int? mySlot,  bool myTurn,  int? myNextPick,  int? picksUntilMyTurn,  int picksMade,  bool complete,  int? pickTimerS,  DateTime? pickDeadline)  $default,) {final _that = this;
switch (_that) {
case _DraftClock():
return $default(_that.currentPick,_that.round,_that.onTheClock,_that.onTheClockTeamName,_that.mySlot,_that.myTurn,_that.myNextPick,_that.picksUntilMyTurn,_that.picksMade,_that.complete,_that.pickTimerS,_that.pickDeadline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentPick,  int? round,  int? onTheClock,  String? onTheClockTeamName,  int? mySlot,  bool myTurn,  int? myNextPick,  int? picksUntilMyTurn,  int picksMade,  bool complete,  int? pickTimerS,  DateTime? pickDeadline)?  $default,) {final _that = this;
switch (_that) {
case _DraftClock() when $default != null:
return $default(_that.currentPick,_that.round,_that.onTheClock,_that.onTheClockTeamName,_that.mySlot,_that.myTurn,_that.myNextPick,_that.picksUntilMyTurn,_that.picksMade,_that.complete,_that.pickTimerS,_that.pickDeadline);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DraftClock implements DraftClock {
  const _DraftClock({required this.currentPick, this.round, this.onTheClock, this.onTheClockTeamName, this.mySlot, required this.myTurn, this.myNextPick, this.picksUntilMyTurn, required this.picksMade, required this.complete, this.pickTimerS, this.pickDeadline});
  factory _DraftClock.fromJson(Map<String, dynamic> json) => _$DraftClockFromJson(json);

@override final  int currentPick;
@override final  int? round;
/// Slot number on the clock; null when the draft is complete.
@override final  int? onTheClock;
/// Null until Sleeper assigns `draft_order` — fall back to the slot.
@override final  String? onTheClockTeamName;
@override final  int? mySlot;
@override final  bool myTurn;
@override final  int? myNextPick;
/// 0 = on the clock. Null when there is no next pick.
@override final  int? picksUntilMyTurn;
@override final  int picksMade;
@override final  bool complete;
@override final  int? pickTimerS;
/// UTC, fixed for the life of the current pick. Null when the draft has
/// no timer or the start of the current pick is unknown.
@override final  DateTime? pickDeadline;

/// Create a copy of DraftClock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftClockCopyWith<_DraftClock> get copyWith => __$DraftClockCopyWithImpl<_DraftClock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftClockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftClock&&(identical(other.currentPick, currentPick) || other.currentPick == currentPick)&&(identical(other.round, round) || other.round == round)&&(identical(other.onTheClock, onTheClock) || other.onTheClock == onTheClock)&&(identical(other.onTheClockTeamName, onTheClockTeamName) || other.onTheClockTeamName == onTheClockTeamName)&&(identical(other.mySlot, mySlot) || other.mySlot == mySlot)&&(identical(other.myTurn, myTurn) || other.myTurn == myTurn)&&(identical(other.myNextPick, myNextPick) || other.myNextPick == myNextPick)&&(identical(other.picksUntilMyTurn, picksUntilMyTurn) || other.picksUntilMyTurn == picksUntilMyTurn)&&(identical(other.picksMade, picksMade) || other.picksMade == picksMade)&&(identical(other.complete, complete) || other.complete == complete)&&(identical(other.pickTimerS, pickTimerS) || other.pickTimerS == pickTimerS)&&(identical(other.pickDeadline, pickDeadline) || other.pickDeadline == pickDeadline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPick,round,onTheClock,onTheClockTeamName,mySlot,myTurn,myNextPick,picksUntilMyTurn,picksMade,complete,pickTimerS,pickDeadline);

@override
String toString() {
  return 'DraftClock(currentPick: $currentPick, round: $round, onTheClock: $onTheClock, onTheClockTeamName: $onTheClockTeamName, mySlot: $mySlot, myTurn: $myTurn, myNextPick: $myNextPick, picksUntilMyTurn: $picksUntilMyTurn, picksMade: $picksMade, complete: $complete, pickTimerS: $pickTimerS, pickDeadline: $pickDeadline)';
}


}

/// @nodoc
abstract mixin class _$DraftClockCopyWith<$Res> implements $DraftClockCopyWith<$Res> {
  factory _$DraftClockCopyWith(_DraftClock value, $Res Function(_DraftClock) _then) = __$DraftClockCopyWithImpl;
@override @useResult
$Res call({
 int currentPick, int? round, int? onTheClock, String? onTheClockTeamName, int? mySlot, bool myTurn, int? myNextPick, int? picksUntilMyTurn, int picksMade, bool complete, int? pickTimerS, DateTime? pickDeadline
});




}
/// @nodoc
class __$DraftClockCopyWithImpl<$Res>
    implements _$DraftClockCopyWith<$Res> {
  __$DraftClockCopyWithImpl(this._self, this._then);

  final _DraftClock _self;
  final $Res Function(_DraftClock) _then;

/// Create a copy of DraftClock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPick = null,Object? round = freezed,Object? onTheClock = freezed,Object? onTheClockTeamName = freezed,Object? mySlot = freezed,Object? myTurn = null,Object? myNextPick = freezed,Object? picksUntilMyTurn = freezed,Object? picksMade = null,Object? complete = null,Object? pickTimerS = freezed,Object? pickDeadline = freezed,}) {
  return _then(_DraftClock(
currentPick: null == currentPick ? _self.currentPick : currentPick // ignore: cast_nullable_to_non_nullable
as int,round: freezed == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int?,onTheClock: freezed == onTheClock ? _self.onTheClock : onTheClock // ignore: cast_nullable_to_non_nullable
as int?,onTheClockTeamName: freezed == onTheClockTeamName ? _self.onTheClockTeamName : onTheClockTeamName // ignore: cast_nullable_to_non_nullable
as String?,mySlot: freezed == mySlot ? _self.mySlot : mySlot // ignore: cast_nullable_to_non_nullable
as int?,myTurn: null == myTurn ? _self.myTurn : myTurn // ignore: cast_nullable_to_non_nullable
as bool,myNextPick: freezed == myNextPick ? _self.myNextPick : myNextPick // ignore: cast_nullable_to_non_nullable
as int?,picksUntilMyTurn: freezed == picksUntilMyTurn ? _self.picksUntilMyTurn : picksUntilMyTurn // ignore: cast_nullable_to_non_nullable
as int?,picksMade: null == picksMade ? _self.picksMade : picksMade // ignore: cast_nullable_to_non_nullable
as int,complete: null == complete ? _self.complete : complete // ignore: cast_nullable_to_non_nullable
as bool,pickTimerS: freezed == pickTimerS ? _self.pickTimerS : pickTimerS // ignore: cast_nullable_to_non_nullable
as int?,pickDeadline: freezed == pickDeadline ? _self.pickDeadline : pickDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$DraftRoster {

 int get slot; List<RosterPick> get picks;/// Position → players drafted.
 Map<String, int> get counts;/// Position → open starting seats.
 Map<String, int> get openStarters; int get openFlex; int get openBench;/// Position → need weight (higher = more urgent).
 Map<String, double> get needs;
/// Create a copy of DraftRoster
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftRosterCopyWith<DraftRoster> get copyWith => _$DraftRosterCopyWithImpl<DraftRoster>(this as DraftRoster, _$identity);

  /// Serializes this DraftRoster to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftRoster&&(identical(other.slot, slot) || other.slot == slot)&&const DeepCollectionEquality().equals(other.picks, picks)&&const DeepCollectionEquality().equals(other.counts, counts)&&const DeepCollectionEquality().equals(other.openStarters, openStarters)&&(identical(other.openFlex, openFlex) || other.openFlex == openFlex)&&(identical(other.openBench, openBench) || other.openBench == openBench)&&const DeepCollectionEquality().equals(other.needs, needs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slot,const DeepCollectionEquality().hash(picks),const DeepCollectionEquality().hash(counts),const DeepCollectionEquality().hash(openStarters),openFlex,openBench,const DeepCollectionEquality().hash(needs));

@override
String toString() {
  return 'DraftRoster(slot: $slot, picks: $picks, counts: $counts, openStarters: $openStarters, openFlex: $openFlex, openBench: $openBench, needs: $needs)';
}


}

/// @nodoc
abstract mixin class $DraftRosterCopyWith<$Res>  {
  factory $DraftRosterCopyWith(DraftRoster value, $Res Function(DraftRoster) _then) = _$DraftRosterCopyWithImpl;
@useResult
$Res call({
 int slot, List<RosterPick> picks, Map<String, int> counts, Map<String, int> openStarters, int openFlex, int openBench, Map<String, double> needs
});




}
/// @nodoc
class _$DraftRosterCopyWithImpl<$Res>
    implements $DraftRosterCopyWith<$Res> {
  _$DraftRosterCopyWithImpl(this._self, this._then);

  final DraftRoster _self;
  final $Res Function(DraftRoster) _then;

/// Create a copy of DraftRoster
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slot = null,Object? picks = null,Object? counts = null,Object? openStarters = null,Object? openFlex = null,Object? openBench = null,Object? needs = null,}) {
  return _then(DraftRoster(
slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as int,picks: null == picks ? _self.picks : picks // ignore: cast_nullable_to_non_nullable
as List<RosterPick>,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,openStarters: null == openStarters ? _self.openStarters : openStarters // ignore: cast_nullable_to_non_nullable
as Map<String, int>,openFlex: null == openFlex ? _self.openFlex : openFlex // ignore: cast_nullable_to_non_nullable
as int,openBench: null == openBench ? _self.openBench : openBench // ignore: cast_nullable_to_non_nullable
as int,needs: null == needs ? _self.needs : needs // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftRoster].
extension DraftRosterPatterns on DraftRoster {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftRoster value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftRoster() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftRoster value)  $default,){
final _that = this;
switch (_that) {
case _DraftRoster():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftRoster value)?  $default,){
final _that = this;
switch (_that) {
case _DraftRoster() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int slot,  List<RosterPick> picks,  Map<String, int> counts,  Map<String, int> openStarters,  int openFlex,  int openBench,  Map<String, double> needs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftRoster() when $default != null:
return $default(_that.slot,_that.picks,_that.counts,_that.openStarters,_that.openFlex,_that.openBench,_that.needs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int slot,  List<RosterPick> picks,  Map<String, int> counts,  Map<String, int> openStarters,  int openFlex,  int openBench,  Map<String, double> needs)  $default,) {final _that = this;
switch (_that) {
case _DraftRoster():
return $default(_that.slot,_that.picks,_that.counts,_that.openStarters,_that.openFlex,_that.openBench,_that.needs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int slot,  List<RosterPick> picks,  Map<String, int> counts,  Map<String, int> openStarters,  int openFlex,  int openBench,  Map<String, double> needs)?  $default,) {final _that = this;
switch (_that) {
case _DraftRoster() when $default != null:
return $default(_that.slot,_that.picks,_that.counts,_that.openStarters,_that.openFlex,_that.openBench,_that.needs);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DraftRoster implements DraftRoster {
  const _DraftRoster({required this.slot, required  List<RosterPick> picks, required  Map<String, int> counts, required  Map<String, int> openStarters, required this.openFlex, required this.openBench, required  Map<String, double> needs}): _picks = picks,_counts = counts,_openStarters = openStarters,_needs = needs;
  factory _DraftRoster.fromJson(Map<String, dynamic> json) => _$DraftRosterFromJson(json);

@override final  int slot;
 final  List<RosterPick> _picks;
@override List<RosterPick> get picks {
  if (_picks is EqualUnmodifiableListView) return _picks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_picks);
}

/// Position → players drafted.
 final  Map<String, int> _counts;
/// Position → players drafted.
@override Map<String, int> get counts {
  if (_counts is EqualUnmodifiableMapView) return _counts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_counts);
}

/// Position → open starting seats.
 final  Map<String, int> _openStarters;
/// Position → open starting seats.
@override Map<String, int> get openStarters {
  if (_openStarters is EqualUnmodifiableMapView) return _openStarters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_openStarters);
}

@override final  int openFlex;
@override final  int openBench;
/// Position → need weight (higher = more urgent).
 final  Map<String, double> _needs;
/// Position → need weight (higher = more urgent).
@override Map<String, double> get needs {
  if (_needs is EqualUnmodifiableMapView) return _needs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_needs);
}


/// Create a copy of DraftRoster
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftRosterCopyWith<_DraftRoster> get copyWith => __$DraftRosterCopyWithImpl<_DraftRoster>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftRosterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftRoster&&(identical(other.slot, slot) || other.slot == slot)&&const DeepCollectionEquality().equals(other._picks, _picks)&&const DeepCollectionEquality().equals(other._counts, _counts)&&const DeepCollectionEquality().equals(other._openStarters, _openStarters)&&(identical(other.openFlex, openFlex) || other.openFlex == openFlex)&&(identical(other.openBench, openBench) || other.openBench == openBench)&&const DeepCollectionEquality().equals(other._needs, _needs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slot,const DeepCollectionEquality().hash(_picks),const DeepCollectionEquality().hash(_counts),const DeepCollectionEquality().hash(_openStarters),openFlex,openBench,const DeepCollectionEquality().hash(_needs));

@override
String toString() {
  return 'DraftRoster(slot: $slot, picks: $picks, counts: $counts, openStarters: $openStarters, openFlex: $openFlex, openBench: $openBench, needs: $needs)';
}


}

/// @nodoc
abstract mixin class _$DraftRosterCopyWith<$Res> implements $DraftRosterCopyWith<$Res> {
  factory _$DraftRosterCopyWith(_DraftRoster value, $Res Function(_DraftRoster) _then) = __$DraftRosterCopyWithImpl;
@override @useResult
$Res call({
 int slot, List<RosterPick> picks, Map<String, int> counts, Map<String, int> openStarters, int openFlex, int openBench, Map<String, double> needs
});




}
/// @nodoc
class __$DraftRosterCopyWithImpl<$Res>
    implements _$DraftRosterCopyWith<$Res> {
  __$DraftRosterCopyWithImpl(this._self, this._then);

  final _DraftRoster _self;
  final $Res Function(_DraftRoster) _then;

/// Create a copy of DraftRoster
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slot = null,Object? picks = null,Object? counts = null,Object? openStarters = null,Object? openFlex = null,Object? openBench = null,Object? needs = null,}) {
  return _then(_DraftRoster(
slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as int,picks: null == picks ? _self._picks : picks // ignore: cast_nullable_to_non_nullable
as List<RosterPick>,counts: null == counts ? _self._counts : counts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,openStarters: null == openStarters ? _self._openStarters : openStarters // ignore: cast_nullable_to_non_nullable
as Map<String, int>,openFlex: null == openFlex ? _self.openFlex : openFlex // ignore: cast_nullable_to_non_nullable
as int,openBench: null == openBench ? _self.openBench : openBench // ignore: cast_nullable_to_non_nullable
as int,needs: null == needs ? _self._needs : needs // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}


/// @nodoc
mixin _$RosterPick {

 int get pickNo; String? get sleeperId; String? get name; String? get position; String? get seat;
/// Create a copy of RosterPick
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RosterPickCopyWith<RosterPick> get copyWith => _$RosterPickCopyWithImpl<RosterPick>(this as RosterPick, _$identity);

  /// Serializes this RosterPick to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RosterPick&&(identical(other.pickNo, pickNo) || other.pickNo == pickNo)&&(identical(other.sleeperId, sleeperId) || other.sleeperId == sleeperId)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.seat, seat) || other.seat == seat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pickNo,sleeperId,name,position,seat);

@override
String toString() {
  return 'RosterPick(pickNo: $pickNo, sleeperId: $sleeperId, name: $name, position: $position, seat: $seat)';
}


}

/// @nodoc
abstract mixin class $RosterPickCopyWith<$Res>  {
  factory $RosterPickCopyWith(RosterPick value, $Res Function(RosterPick) _then) = _$RosterPickCopyWithImpl;
@useResult
$Res call({
 int pickNo, String? sleeperId, String? name, String? position, String? seat
});




}
/// @nodoc
class _$RosterPickCopyWithImpl<$Res>
    implements $RosterPickCopyWith<$Res> {
  _$RosterPickCopyWithImpl(this._self, this._then);

  final RosterPick _self;
  final $Res Function(RosterPick) _then;

/// Create a copy of RosterPick
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pickNo = null,Object? sleeperId = freezed,Object? name = freezed,Object? position = freezed,Object? seat = freezed,}) {
  return _then(RosterPick(
pickNo: null == pickNo ? _self.pickNo : pickNo // ignore: cast_nullable_to_non_nullable
as int,sleeperId: freezed == sleeperId ? _self.sleeperId : sleeperId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,seat: freezed == seat ? _self.seat : seat // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RosterPick].
extension RosterPickPatterns on RosterPick {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RosterPick value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RosterPick() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RosterPick value)  $default,){
final _that = this;
switch (_that) {
case _RosterPick():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RosterPick value)?  $default,){
final _that = this;
switch (_that) {
case _RosterPick() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pickNo,  String? sleeperId,  String? name,  String? position,  String? seat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RosterPick() when $default != null:
return $default(_that.pickNo,_that.sleeperId,_that.name,_that.position,_that.seat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pickNo,  String? sleeperId,  String? name,  String? position,  String? seat)  $default,) {final _that = this;
switch (_that) {
case _RosterPick():
return $default(_that.pickNo,_that.sleeperId,_that.name,_that.position,_that.seat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pickNo,  String? sleeperId,  String? name,  String? position,  String? seat)?  $default,) {final _that = this;
switch (_that) {
case _RosterPick() when $default != null:
return $default(_that.pickNo,_that.sleeperId,_that.name,_that.position,_that.seat);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _RosterPick implements RosterPick {
  const _RosterPick({required this.pickNo, this.sleeperId, this.name, this.position, this.seat});
  factory _RosterPick.fromJson(Map<String, dynamic> json) => _$RosterPickFromJson(json);

@override final  int pickNo;
@override final  String? sleeperId;
@override final  String? name;
@override final  String? position;
@override final  String? seat;

/// Create a copy of RosterPick
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RosterPickCopyWith<_RosterPick> get copyWith => __$RosterPickCopyWithImpl<_RosterPick>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RosterPickToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RosterPick&&(identical(other.pickNo, pickNo) || other.pickNo == pickNo)&&(identical(other.sleeperId, sleeperId) || other.sleeperId == sleeperId)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.seat, seat) || other.seat == seat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pickNo,sleeperId,name,position,seat);

@override
String toString() {
  return 'RosterPick(pickNo: $pickNo, sleeperId: $sleeperId, name: $name, position: $position, seat: $seat)';
}


}

/// @nodoc
abstract mixin class _$RosterPickCopyWith<$Res> implements $RosterPickCopyWith<$Res> {
  factory _$RosterPickCopyWith(_RosterPick value, $Res Function(_RosterPick) _then) = __$RosterPickCopyWithImpl;
@override @useResult
$Res call({
 int pickNo, String? sleeperId, String? name, String? position, String? seat
});




}
/// @nodoc
class __$RosterPickCopyWithImpl<$Res>
    implements _$RosterPickCopyWith<$Res> {
  __$RosterPickCopyWithImpl(this._self, this._then);

  final _RosterPick _self;
  final $Res Function(_RosterPick) _then;

/// Create a copy of RosterPick
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pickNo = null,Object? sleeperId = freezed,Object? name = freezed,Object? position = freezed,Object? seat = freezed,}) {
  return _then(_RosterPick(
pickNo: null == pickNo ? _self.pickNo : pickNo // ignore: cast_nullable_to_non_nullable
as int,sleeperId: freezed == sleeperId ? _self.sleeperId : sleeperId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,seat: freezed == seat ? _self.seat : seat // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RecentPick {

 int get pickNo; int? get slot; String? get teamName; String? get sleeperId; String? get name; String? get position;
/// Create a copy of RecentPick
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentPickCopyWith<RecentPick> get copyWith => _$RecentPickCopyWithImpl<RecentPick>(this as RecentPick, _$identity);

  /// Serializes this RecentPick to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentPick&&(identical(other.pickNo, pickNo) || other.pickNo == pickNo)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.teamName, teamName) || other.teamName == teamName)&&(identical(other.sleeperId, sleeperId) || other.sleeperId == sleeperId)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pickNo,slot,teamName,sleeperId,name,position);

@override
String toString() {
  return 'RecentPick(pickNo: $pickNo, slot: $slot, teamName: $teamName, sleeperId: $sleeperId, name: $name, position: $position)';
}


}

/// @nodoc
abstract mixin class $RecentPickCopyWith<$Res>  {
  factory $RecentPickCopyWith(RecentPick value, $Res Function(RecentPick) _then) = _$RecentPickCopyWithImpl;
@useResult
$Res call({
 int pickNo, int? slot, String? teamName, String? sleeperId, String? name, String? position
});




}
/// @nodoc
class _$RecentPickCopyWithImpl<$Res>
    implements $RecentPickCopyWith<$Res> {
  _$RecentPickCopyWithImpl(this._self, this._then);

  final RecentPick _self;
  final $Res Function(RecentPick) _then;

/// Create a copy of RecentPick
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pickNo = null,Object? slot = freezed,Object? teamName = freezed,Object? sleeperId = freezed,Object? name = freezed,Object? position = freezed,}) {
  return _then(RecentPick(
pickNo: null == pickNo ? _self.pickNo : pickNo // ignore: cast_nullable_to_non_nullable
as int,slot: freezed == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as int?,teamName: freezed == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String?,sleeperId: freezed == sleeperId ? _self.sleeperId : sleeperId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentPick].
extension RecentPickPatterns on RecentPick {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentPick value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentPick() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentPick value)  $default,){
final _that = this;
switch (_that) {
case _RecentPick():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentPick value)?  $default,){
final _that = this;
switch (_that) {
case _RecentPick() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pickNo,  int? slot,  String? teamName,  String? sleeperId,  String? name,  String? position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentPick() when $default != null:
return $default(_that.pickNo,_that.slot,_that.teamName,_that.sleeperId,_that.name,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pickNo,  int? slot,  String? teamName,  String? sleeperId,  String? name,  String? position)  $default,) {final _that = this;
switch (_that) {
case _RecentPick():
return $default(_that.pickNo,_that.slot,_that.teamName,_that.sleeperId,_that.name,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pickNo,  int? slot,  String? teamName,  String? sleeperId,  String? name,  String? position)?  $default,) {final _that = this;
switch (_that) {
case _RecentPick() when $default != null:
return $default(_that.pickNo,_that.slot,_that.teamName,_that.sleeperId,_that.name,_that.position);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _RecentPick implements RecentPick {
  const _RecentPick({required this.pickNo, this.slot, this.teamName, this.sleeperId, this.name, this.position});
  factory _RecentPick.fromJson(Map<String, dynamic> json) => _$RecentPickFromJson(json);

@override final  int pickNo;
@override final  int? slot;
@override final  String? teamName;
@override final  String? sleeperId;
@override final  String? name;
@override final  String? position;

/// Create a copy of RecentPick
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentPickCopyWith<_RecentPick> get copyWith => __$RecentPickCopyWithImpl<_RecentPick>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentPickToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentPick&&(identical(other.pickNo, pickNo) || other.pickNo == pickNo)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.teamName, teamName) || other.teamName == teamName)&&(identical(other.sleeperId, sleeperId) || other.sleeperId == sleeperId)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pickNo,slot,teamName,sleeperId,name,position);

@override
String toString() {
  return 'RecentPick(pickNo: $pickNo, slot: $slot, teamName: $teamName, sleeperId: $sleeperId, name: $name, position: $position)';
}


}

/// @nodoc
abstract mixin class _$RecentPickCopyWith<$Res> implements $RecentPickCopyWith<$Res> {
  factory _$RecentPickCopyWith(_RecentPick value, $Res Function(_RecentPick) _then) = __$RecentPickCopyWithImpl;
@override @useResult
$Res call({
 int pickNo, int? slot, String? teamName, String? sleeperId, String? name, String? position
});




}
/// @nodoc
class __$RecentPickCopyWithImpl<$Res>
    implements _$RecentPickCopyWith<$Res> {
  __$RecentPickCopyWithImpl(this._self, this._then);

  final _RecentPick _self;
  final $Res Function(_RecentPick) _then;

/// Create a copy of RecentPick
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pickNo = null,Object? slot = freezed,Object? teamName = freezed,Object? sleeperId = freezed,Object? name = freezed,Object? position = freezed,}) {
  return _then(_RecentPick(
pickNo: null == pickNo ? _self.pickNo : pickNo // ignore: cast_nullable_to_non_nullable
as int,slot: freezed == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as int?,teamName: freezed == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String?,sleeperId: freezed == sleeperId ? _self.sleeperId : sleeperId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Recompute {

 int get seq; int get pickNo; DateTime get computedAt; double get elapsedMs; bool get stale; String? get error; int get count; double get avgMs; double get maxMs; int get failures;
/// Create a copy of Recompute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecomputeCopyWith<Recompute> get copyWith => _$RecomputeCopyWithImpl<Recompute>(this as Recompute, _$identity);

  /// Serializes this Recompute to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Recompute&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.pickNo, pickNo) || other.pickNo == pickNo)&&(identical(other.computedAt, computedAt) || other.computedAt == computedAt)&&(identical(other.elapsedMs, elapsedMs) || other.elapsedMs == elapsedMs)&&(identical(other.stale, stale) || other.stale == stale)&&(identical(other.error, error) || other.error == error)&&(identical(other.count, count) || other.count == count)&&(identical(other.avgMs, avgMs) || other.avgMs == avgMs)&&(identical(other.maxMs, maxMs) || other.maxMs == maxMs)&&(identical(other.failures, failures) || other.failures == failures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seq,pickNo,computedAt,elapsedMs,stale,error,count,avgMs,maxMs,failures);

@override
String toString() {
  return 'Recompute(seq: $seq, pickNo: $pickNo, computedAt: $computedAt, elapsedMs: $elapsedMs, stale: $stale, error: $error, count: $count, avgMs: $avgMs, maxMs: $maxMs, failures: $failures)';
}


}

/// @nodoc
abstract mixin class $RecomputeCopyWith<$Res>  {
  factory $RecomputeCopyWith(Recompute value, $Res Function(Recompute) _then) = _$RecomputeCopyWithImpl;
@useResult
$Res call({
 int seq, int pickNo, DateTime computedAt, double elapsedMs, bool stale, String? error, int count, double avgMs, double maxMs, int failures
});




}
/// @nodoc
class _$RecomputeCopyWithImpl<$Res>
    implements $RecomputeCopyWith<$Res> {
  _$RecomputeCopyWithImpl(this._self, this._then);

  final Recompute _self;
  final $Res Function(Recompute) _then;

/// Create a copy of Recompute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seq = null,Object? pickNo = null,Object? computedAt = null,Object? elapsedMs = null,Object? stale = null,Object? error = freezed,Object? count = null,Object? avgMs = null,Object? maxMs = null,Object? failures = null,}) {
  return _then(Recompute(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,pickNo: null == pickNo ? _self.pickNo : pickNo // ignore: cast_nullable_to_non_nullable
as int,computedAt: null == computedAt ? _self.computedAt : computedAt // ignore: cast_nullable_to_non_nullable
as DateTime,elapsedMs: null == elapsedMs ? _self.elapsedMs : elapsedMs // ignore: cast_nullable_to_non_nullable
as double,stale: null == stale ? _self.stale : stale // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,avgMs: null == avgMs ? _self.avgMs : avgMs // ignore: cast_nullable_to_non_nullable
as double,maxMs: null == maxMs ? _self.maxMs : maxMs // ignore: cast_nullable_to_non_nullable
as double,failures: null == failures ? _self.failures : failures // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Recompute].
extension RecomputePatterns on Recompute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Recompute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Recompute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Recompute value)  $default,){
final _that = this;
switch (_that) {
case _Recompute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Recompute value)?  $default,){
final _that = this;
switch (_that) {
case _Recompute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seq,  int pickNo,  DateTime computedAt,  double elapsedMs,  bool stale,  String? error,  int count,  double avgMs,  double maxMs,  int failures)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Recompute() when $default != null:
return $default(_that.seq,_that.pickNo,_that.computedAt,_that.elapsedMs,_that.stale,_that.error,_that.count,_that.avgMs,_that.maxMs,_that.failures);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seq,  int pickNo,  DateTime computedAt,  double elapsedMs,  bool stale,  String? error,  int count,  double avgMs,  double maxMs,  int failures)  $default,) {final _that = this;
switch (_that) {
case _Recompute():
return $default(_that.seq,_that.pickNo,_that.computedAt,_that.elapsedMs,_that.stale,_that.error,_that.count,_that.avgMs,_that.maxMs,_that.failures);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seq,  int pickNo,  DateTime computedAt,  double elapsedMs,  bool stale,  String? error,  int count,  double avgMs,  double maxMs,  int failures)?  $default,) {final _that = this;
switch (_that) {
case _Recompute() when $default != null:
return $default(_that.seq,_that.pickNo,_that.computedAt,_that.elapsedMs,_that.stale,_that.error,_that.count,_that.avgMs,_that.maxMs,_that.failures);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Recompute implements Recompute {
  const _Recompute({required this.seq, required this.pickNo, required this.computedAt, required this.elapsedMs, required this.stale, this.error, required this.count, required this.avgMs, required this.maxMs, required this.failures});
  factory _Recompute.fromJson(Map<String, dynamic> json) => _$RecomputeFromJson(json);

@override final  int seq;
@override final  int pickNo;
@override final  DateTime computedAt;
@override final  double elapsedMs;
@override final  bool stale;
@override final  String? error;
@override final  int count;
@override final  double avgMs;
@override final  double maxMs;
@override final  int failures;

/// Create a copy of Recompute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecomputeCopyWith<_Recompute> get copyWith => __$RecomputeCopyWithImpl<_Recompute>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecomputeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Recompute&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.pickNo, pickNo) || other.pickNo == pickNo)&&(identical(other.computedAt, computedAt) || other.computedAt == computedAt)&&(identical(other.elapsedMs, elapsedMs) || other.elapsedMs == elapsedMs)&&(identical(other.stale, stale) || other.stale == stale)&&(identical(other.error, error) || other.error == error)&&(identical(other.count, count) || other.count == count)&&(identical(other.avgMs, avgMs) || other.avgMs == avgMs)&&(identical(other.maxMs, maxMs) || other.maxMs == maxMs)&&(identical(other.failures, failures) || other.failures == failures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seq,pickNo,computedAt,elapsedMs,stale,error,count,avgMs,maxMs,failures);

@override
String toString() {
  return 'Recompute(seq: $seq, pickNo: $pickNo, computedAt: $computedAt, elapsedMs: $elapsedMs, stale: $stale, error: $error, count: $count, avgMs: $avgMs, maxMs: $maxMs, failures: $failures)';
}


}

/// @nodoc
abstract mixin class _$RecomputeCopyWith<$Res> implements $RecomputeCopyWith<$Res> {
  factory _$RecomputeCopyWith(_Recompute value, $Res Function(_Recompute) _then) = __$RecomputeCopyWithImpl;
@override @useResult
$Res call({
 int seq, int pickNo, DateTime computedAt, double elapsedMs, bool stale, String? error, int count, double avgMs, double maxMs, int failures
});




}
/// @nodoc
class __$RecomputeCopyWithImpl<$Res>
    implements _$RecomputeCopyWith<$Res> {
  __$RecomputeCopyWithImpl(this._self, this._then);

  final _Recompute _self;
  final $Res Function(_Recompute) _then;

/// Create a copy of Recompute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seq = null,Object? pickNo = null,Object? computedAt = null,Object? elapsedMs = null,Object? stale = null,Object? error = freezed,Object? count = null,Object? avgMs = null,Object? maxMs = null,Object? failures = null,}) {
  return _then(_Recompute(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,pickNo: null == pickNo ? _self.pickNo : pickNo // ignore: cast_nullable_to_non_nullable
as int,computedAt: null == computedAt ? _self.computedAt : computedAt // ignore: cast_nullable_to_non_nullable
as DateTime,elapsedMs: null == elapsedMs ? _self.elapsedMs : elapsedMs // ignore: cast_nullable_to_non_nullable
as double,stale: null == stale ? _self.stale : stale // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,avgMs: null == avgMs ? _self.avgMs : avgMs // ignore: cast_nullable_to_non_nullable
as double,maxMs: null == maxMs ? _self.maxMs : maxMs // ignore: cast_nullable_to_non_nullable
as double,failures: null == failures ? _self.failures : failures // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DraftBoardMeta {

 DateTime get builtAt; int? get season; int get rows; int get available;
/// Create a copy of DraftBoardMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftBoardMetaCopyWith<DraftBoardMeta> get copyWith => _$DraftBoardMetaCopyWithImpl<DraftBoardMeta>(this as DraftBoardMeta, _$identity);

  /// Serializes this DraftBoardMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftBoardMeta&&(identical(other.builtAt, builtAt) || other.builtAt == builtAt)&&(identical(other.season, season) || other.season == season)&&(identical(other.rows, rows) || other.rows == rows)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,builtAt,season,rows,available);

@override
String toString() {
  return 'DraftBoardMeta(builtAt: $builtAt, season: $season, rows: $rows, available: $available)';
}


}

/// @nodoc
abstract mixin class $DraftBoardMetaCopyWith<$Res>  {
  factory $DraftBoardMetaCopyWith(DraftBoardMeta value, $Res Function(DraftBoardMeta) _then) = _$DraftBoardMetaCopyWithImpl;
@useResult
$Res call({
 DateTime builtAt, int? season, int rows, int available
});




}
/// @nodoc
class _$DraftBoardMetaCopyWithImpl<$Res>
    implements $DraftBoardMetaCopyWith<$Res> {
  _$DraftBoardMetaCopyWithImpl(this._self, this._then);

  final DraftBoardMeta _self;
  final $Res Function(DraftBoardMeta) _then;

/// Create a copy of DraftBoardMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? builtAt = null,Object? season = freezed,Object? rows = null,Object? available = null,}) {
  return _then(DraftBoardMeta(
builtAt: null == builtAt ? _self.builtAt : builtAt // ignore: cast_nullable_to_non_nullable
as DateTime,season: freezed == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int?,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftBoardMeta].
extension DraftBoardMetaPatterns on DraftBoardMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftBoardMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftBoardMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftBoardMeta value)  $default,){
final _that = this;
switch (_that) {
case _DraftBoardMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftBoardMeta value)?  $default,){
final _that = this;
switch (_that) {
case _DraftBoardMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime builtAt,  int? season,  int rows,  int available)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftBoardMeta() when $default != null:
return $default(_that.builtAt,_that.season,_that.rows,_that.available);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime builtAt,  int? season,  int rows,  int available)  $default,) {final _that = this;
switch (_that) {
case _DraftBoardMeta():
return $default(_that.builtAt,_that.season,_that.rows,_that.available);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime builtAt,  int? season,  int rows,  int available)?  $default,) {final _that = this;
switch (_that) {
case _DraftBoardMeta() when $default != null:
return $default(_that.builtAt,_that.season,_that.rows,_that.available);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DraftBoardMeta implements DraftBoardMeta {
  const _DraftBoardMeta({required this.builtAt, this.season, required this.rows, required this.available});
  factory _DraftBoardMeta.fromJson(Map<String, dynamic> json) => _$DraftBoardMetaFromJson(json);

@override final  DateTime builtAt;
@override final  int? season;
@override final  int rows;
@override final  int available;

/// Create a copy of DraftBoardMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftBoardMetaCopyWith<_DraftBoardMeta> get copyWith => __$DraftBoardMetaCopyWithImpl<_DraftBoardMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftBoardMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftBoardMeta&&(identical(other.builtAt, builtAt) || other.builtAt == builtAt)&&(identical(other.season, season) || other.season == season)&&(identical(other.rows, rows) || other.rows == rows)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,builtAt,season,rows,available);

@override
String toString() {
  return 'DraftBoardMeta(builtAt: $builtAt, season: $season, rows: $rows, available: $available)';
}


}

/// @nodoc
abstract mixin class _$DraftBoardMetaCopyWith<$Res> implements $DraftBoardMetaCopyWith<$Res> {
  factory _$DraftBoardMetaCopyWith(_DraftBoardMeta value, $Res Function(_DraftBoardMeta) _then) = __$DraftBoardMetaCopyWithImpl;
@override @useResult
$Res call({
 DateTime builtAt, int? season, int rows, int available
});




}
/// @nodoc
class __$DraftBoardMetaCopyWithImpl<$Res>
    implements _$DraftBoardMetaCopyWith<$Res> {
  __$DraftBoardMetaCopyWithImpl(this._self, this._then);

  final _DraftBoardMeta _self;
  final $Res Function(_DraftBoardMeta) _then;

/// Create a copy of DraftBoardMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? builtAt = null,Object? season = freezed,Object? rows = null,Object? available = null,}) {
  return _then(_DraftBoardMeta(
builtAt: null == builtAt ? _self.builtAt : builtAt // ignore: cast_nullable_to_non_nullable
as DateTime,season: freezed == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int?,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DraftPoller {

 double get intervalS; String? get status; int? get expectedPicks; DateTime? get startedAt; DateTime? get lastPollAt; DateTime? get lastOkAt; int get failuresInARow; String? get lastError; bool get degraded; String? get runnerError; bool get rebuildPending; Map<String, dynamic>? get persist; Map<String, dynamic>? get summary;
/// Create a copy of DraftPoller
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftPollerCopyWith<DraftPoller> get copyWith => _$DraftPollerCopyWithImpl<DraftPoller>(this as DraftPoller, _$identity);

  /// Serializes this DraftPoller to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftPoller&&(identical(other.intervalS, intervalS) || other.intervalS == intervalS)&&(identical(other.status, status) || other.status == status)&&(identical(other.expectedPicks, expectedPicks) || other.expectedPicks == expectedPicks)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.lastPollAt, lastPollAt) || other.lastPollAt == lastPollAt)&&(identical(other.lastOkAt, lastOkAt) || other.lastOkAt == lastOkAt)&&(identical(other.failuresInARow, failuresInARow) || other.failuresInARow == failuresInARow)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.degraded, degraded) || other.degraded == degraded)&&(identical(other.runnerError, runnerError) || other.runnerError == runnerError)&&(identical(other.rebuildPending, rebuildPending) || other.rebuildPending == rebuildPending)&&const DeepCollectionEquality().equals(other.persist, persist)&&const DeepCollectionEquality().equals(other.summary, summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intervalS,status,expectedPicks,startedAt,lastPollAt,lastOkAt,failuresInARow,lastError,degraded,runnerError,rebuildPending,const DeepCollectionEquality().hash(persist),const DeepCollectionEquality().hash(summary));

@override
String toString() {
  return 'DraftPoller(intervalS: $intervalS, status: $status, expectedPicks: $expectedPicks, startedAt: $startedAt, lastPollAt: $lastPollAt, lastOkAt: $lastOkAt, failuresInARow: $failuresInARow, lastError: $lastError, degraded: $degraded, runnerError: $runnerError, rebuildPending: $rebuildPending, persist: $persist, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $DraftPollerCopyWith<$Res>  {
  factory $DraftPollerCopyWith(DraftPoller value, $Res Function(DraftPoller) _then) = _$DraftPollerCopyWithImpl;
@useResult
$Res call({
 double intervalS, String? status, int? expectedPicks, DateTime? startedAt, DateTime? lastPollAt, DateTime? lastOkAt, int failuresInARow, String? lastError, bool degraded, String? runnerError, bool rebuildPending, Map<String, dynamic>? persist, Map<String, dynamic>? summary
});




}
/// @nodoc
class _$DraftPollerCopyWithImpl<$Res>
    implements $DraftPollerCopyWith<$Res> {
  _$DraftPollerCopyWithImpl(this._self, this._then);

  final DraftPoller _self;
  final $Res Function(DraftPoller) _then;

/// Create a copy of DraftPoller
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intervalS = null,Object? status = freezed,Object? expectedPicks = freezed,Object? startedAt = freezed,Object? lastPollAt = freezed,Object? lastOkAt = freezed,Object? failuresInARow = null,Object? lastError = freezed,Object? degraded = null,Object? runnerError = freezed,Object? rebuildPending = null,Object? persist = freezed,Object? summary = freezed,}) {
  return _then(DraftPoller(
intervalS: null == intervalS ? _self.intervalS : intervalS // ignore: cast_nullable_to_non_nullable
as double,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,expectedPicks: freezed == expectedPicks ? _self.expectedPicks : expectedPicks // ignore: cast_nullable_to_non_nullable
as int?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastPollAt: freezed == lastPollAt ? _self.lastPollAt : lastPollAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastOkAt: freezed == lastOkAt ? _self.lastOkAt : lastOkAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failuresInARow: null == failuresInARow ? _self.failuresInARow : failuresInARow // ignore: cast_nullable_to_non_nullable
as int,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,degraded: null == degraded ? _self.degraded : degraded // ignore: cast_nullable_to_non_nullable
as bool,runnerError: freezed == runnerError ? _self.runnerError : runnerError // ignore: cast_nullable_to_non_nullable
as String?,rebuildPending: null == rebuildPending ? _self.rebuildPending : rebuildPending // ignore: cast_nullable_to_non_nullable
as bool,persist: freezed == persist ? _self.persist : persist // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftPoller].
extension DraftPollerPatterns on DraftPoller {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftPoller value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftPoller() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftPoller value)  $default,){
final _that = this;
switch (_that) {
case _DraftPoller():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftPoller value)?  $default,){
final _that = this;
switch (_that) {
case _DraftPoller() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double intervalS,  String? status,  int? expectedPicks,  DateTime? startedAt,  DateTime? lastPollAt,  DateTime? lastOkAt,  int failuresInARow,  String? lastError,  bool degraded,  String? runnerError,  bool rebuildPending,  Map<String, dynamic>? persist,  Map<String, dynamic>? summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftPoller() when $default != null:
return $default(_that.intervalS,_that.status,_that.expectedPicks,_that.startedAt,_that.lastPollAt,_that.lastOkAt,_that.failuresInARow,_that.lastError,_that.degraded,_that.runnerError,_that.rebuildPending,_that.persist,_that.summary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double intervalS,  String? status,  int? expectedPicks,  DateTime? startedAt,  DateTime? lastPollAt,  DateTime? lastOkAt,  int failuresInARow,  String? lastError,  bool degraded,  String? runnerError,  bool rebuildPending,  Map<String, dynamic>? persist,  Map<String, dynamic>? summary)  $default,) {final _that = this;
switch (_that) {
case _DraftPoller():
return $default(_that.intervalS,_that.status,_that.expectedPicks,_that.startedAt,_that.lastPollAt,_that.lastOkAt,_that.failuresInARow,_that.lastError,_that.degraded,_that.runnerError,_that.rebuildPending,_that.persist,_that.summary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double intervalS,  String? status,  int? expectedPicks,  DateTime? startedAt,  DateTime? lastPollAt,  DateTime? lastOkAt,  int failuresInARow,  String? lastError,  bool degraded,  String? runnerError,  bool rebuildPending,  Map<String, dynamic>? persist,  Map<String, dynamic>? summary)?  $default,) {final _that = this;
switch (_that) {
case _DraftPoller() when $default != null:
return $default(_that.intervalS,_that.status,_that.expectedPicks,_that.startedAt,_that.lastPollAt,_that.lastOkAt,_that.failuresInARow,_that.lastError,_that.degraded,_that.runnerError,_that.rebuildPending,_that.persist,_that.summary);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DraftPoller implements DraftPoller {
  const _DraftPoller({required this.intervalS, this.status, this.expectedPicks, this.startedAt, this.lastPollAt, this.lastOkAt, required this.failuresInARow, this.lastError, required this.degraded, this.runnerError, required this.rebuildPending,  Map<String, dynamic>? persist,  Map<String, dynamic>? summary}): _persist = persist,_summary = summary;
  factory _DraftPoller.fromJson(Map<String, dynamic> json) => _$DraftPollerFromJson(json);

@override final  double intervalS;
@override final  String? status;
@override final  int? expectedPicks;
@override final  DateTime? startedAt;
@override final  DateTime? lastPollAt;
@override final  DateTime? lastOkAt;
@override final  int failuresInARow;
@override final  String? lastError;
@override final  bool degraded;
@override final  String? runnerError;
@override final  bool rebuildPending;
 final  Map<String, dynamic>? _persist;
@override Map<String, dynamic>? get persist {
  final value = _persist;
  if (value == null) return null;
  if (_persist is EqualUnmodifiableMapView) return _persist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _summary;
@override Map<String, dynamic>? get summary {
  final value = _summary;
  if (value == null) return null;
  if (_summary is EqualUnmodifiableMapView) return _summary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of DraftPoller
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftPollerCopyWith<_DraftPoller> get copyWith => __$DraftPollerCopyWithImpl<_DraftPoller>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftPollerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftPoller&&(identical(other.intervalS, intervalS) || other.intervalS == intervalS)&&(identical(other.status, status) || other.status == status)&&(identical(other.expectedPicks, expectedPicks) || other.expectedPicks == expectedPicks)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.lastPollAt, lastPollAt) || other.lastPollAt == lastPollAt)&&(identical(other.lastOkAt, lastOkAt) || other.lastOkAt == lastOkAt)&&(identical(other.failuresInARow, failuresInARow) || other.failuresInARow == failuresInARow)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.degraded, degraded) || other.degraded == degraded)&&(identical(other.runnerError, runnerError) || other.runnerError == runnerError)&&(identical(other.rebuildPending, rebuildPending) || other.rebuildPending == rebuildPending)&&const DeepCollectionEquality().equals(other._persist, _persist)&&const DeepCollectionEquality().equals(other._summary, _summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intervalS,status,expectedPicks,startedAt,lastPollAt,lastOkAt,failuresInARow,lastError,degraded,runnerError,rebuildPending,const DeepCollectionEquality().hash(_persist),const DeepCollectionEquality().hash(_summary));

@override
String toString() {
  return 'DraftPoller(intervalS: $intervalS, status: $status, expectedPicks: $expectedPicks, startedAt: $startedAt, lastPollAt: $lastPollAt, lastOkAt: $lastOkAt, failuresInARow: $failuresInARow, lastError: $lastError, degraded: $degraded, runnerError: $runnerError, rebuildPending: $rebuildPending, persist: $persist, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$DraftPollerCopyWith<$Res> implements $DraftPollerCopyWith<$Res> {
  factory _$DraftPollerCopyWith(_DraftPoller value, $Res Function(_DraftPoller) _then) = __$DraftPollerCopyWithImpl;
@override @useResult
$Res call({
 double intervalS, String? status, int? expectedPicks, DateTime? startedAt, DateTime? lastPollAt, DateTime? lastOkAt, int failuresInARow, String? lastError, bool degraded, String? runnerError, bool rebuildPending, Map<String, dynamic>? persist, Map<String, dynamic>? summary
});




}
/// @nodoc
class __$DraftPollerCopyWithImpl<$Res>
    implements _$DraftPollerCopyWith<$Res> {
  __$DraftPollerCopyWithImpl(this._self, this._then);

  final _DraftPoller _self;
  final $Res Function(_DraftPoller) _then;

/// Create a copy of DraftPoller
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intervalS = null,Object? status = freezed,Object? expectedPicks = freezed,Object? startedAt = freezed,Object? lastPollAt = freezed,Object? lastOkAt = freezed,Object? failuresInARow = null,Object? lastError = freezed,Object? degraded = null,Object? runnerError = freezed,Object? rebuildPending = null,Object? persist = freezed,Object? summary = freezed,}) {
  return _then(_DraftPoller(
intervalS: null == intervalS ? _self.intervalS : intervalS // ignore: cast_nullable_to_non_nullable
as double,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,expectedPicks: freezed == expectedPicks ? _self.expectedPicks : expectedPicks // ignore: cast_nullable_to_non_nullable
as int?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastPollAt: freezed == lastPollAt ? _self.lastPollAt : lastPollAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastOkAt: freezed == lastOkAt ? _self.lastOkAt : lastOkAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failuresInARow: null == failuresInARow ? _self.failuresInARow : failuresInARow // ignore: cast_nullable_to_non_nullable
as int,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,degraded: null == degraded ? _self.degraded : degraded // ignore: cast_nullable_to_non_nullable
as bool,runnerError: freezed == runnerError ? _self.runnerError : runnerError // ignore: cast_nullable_to_non_nullable
as String?,rebuildPending: null == rebuildPending ? _self.rebuildPending : rebuildPending // ignore: cast_nullable_to_non_nullable
as bool,persist: freezed == persist ? _self._persist : persist // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,summary: freezed == summary ? _self._summary : summary // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$DraftRow {

 int get rank; String get sleeperId; String get name; String get position; String? get team; String? get injuryStatus; int? get bye; double get points; double get vorp; int get posRank; int? get tier; bool get cliff; double? get gapToNext; double? get adp; double? get adpDelta; String? get adpFlag; bool get disagree;/// 0–1 probability the player is still there at my next pick.
 double? get survival; bool get run; int get runCount; double? get pickScore;
/// Create a copy of DraftRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftRowCopyWith<DraftRow> get copyWith => _$DraftRowCopyWithImpl<DraftRow>(this as DraftRow, _$identity);

  /// Serializes this DraftRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftRow&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.sleeperId, sleeperId) || other.sleeperId == sleeperId)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.team, team) || other.team == team)&&(identical(other.injuryStatus, injuryStatus) || other.injuryStatus == injuryStatus)&&(identical(other.bye, bye) || other.bye == bye)&&(identical(other.points, points) || other.points == points)&&(identical(other.vorp, vorp) || other.vorp == vorp)&&(identical(other.posRank, posRank) || other.posRank == posRank)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.cliff, cliff) || other.cliff == cliff)&&(identical(other.gapToNext, gapToNext) || other.gapToNext == gapToNext)&&(identical(other.adp, adp) || other.adp == adp)&&(identical(other.adpDelta, adpDelta) || other.adpDelta == adpDelta)&&(identical(other.adpFlag, adpFlag) || other.adpFlag == adpFlag)&&(identical(other.disagree, disagree) || other.disagree == disagree)&&(identical(other.survival, survival) || other.survival == survival)&&(identical(other.run, run) || other.run == run)&&(identical(other.runCount, runCount) || other.runCount == runCount)&&(identical(other.pickScore, pickScore) || other.pickScore == pickScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,rank,sleeperId,name,position,team,injuryStatus,bye,points,vorp,posRank,tier,cliff,gapToNext,adp,adpDelta,adpFlag,disagree,survival,run,runCount,pickScore]);

@override
String toString() {
  return 'DraftRow(rank: $rank, sleeperId: $sleeperId, name: $name, position: $position, team: $team, injuryStatus: $injuryStatus, bye: $bye, points: $points, vorp: $vorp, posRank: $posRank, tier: $tier, cliff: $cliff, gapToNext: $gapToNext, adp: $adp, adpDelta: $adpDelta, adpFlag: $adpFlag, disagree: $disagree, survival: $survival, run: $run, runCount: $runCount, pickScore: $pickScore)';
}


}

/// @nodoc
abstract mixin class $DraftRowCopyWith<$Res>  {
  factory $DraftRowCopyWith(DraftRow value, $Res Function(DraftRow) _then) = _$DraftRowCopyWithImpl;
@useResult
$Res call({
 int rank, String sleeperId, String name, String position, String? team, String? injuryStatus, int? bye, double points, double vorp, int posRank, int? tier, bool cliff, double? gapToNext, double? adp, double? adpDelta, String? adpFlag, bool disagree, double? survival, bool run, int runCount, double? pickScore
});




}
/// @nodoc
class _$DraftRowCopyWithImpl<$Res>
    implements $DraftRowCopyWith<$Res> {
  _$DraftRowCopyWithImpl(this._self, this._then);

  final DraftRow _self;
  final $Res Function(DraftRow) _then;

/// Create a copy of DraftRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rank = null,Object? sleeperId = null,Object? name = null,Object? position = null,Object? team = freezed,Object? injuryStatus = freezed,Object? bye = freezed,Object? points = null,Object? vorp = null,Object? posRank = null,Object? tier = freezed,Object? cliff = null,Object? gapToNext = freezed,Object? adp = freezed,Object? adpDelta = freezed,Object? adpFlag = freezed,Object? disagree = null,Object? survival = freezed,Object? run = null,Object? runCount = null,Object? pickScore = freezed,}) {
  return _then(DraftRow(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,sleeperId: null == sleeperId ? _self.sleeperId : sleeperId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,team: freezed == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as String?,injuryStatus: freezed == injuryStatus ? _self.injuryStatus : injuryStatus // ignore: cast_nullable_to_non_nullable
as String?,bye: freezed == bye ? _self.bye : bye // ignore: cast_nullable_to_non_nullable
as int?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,vorp: null == vorp ? _self.vorp : vorp // ignore: cast_nullable_to_non_nullable
as double,posRank: null == posRank ? _self.posRank : posRank // ignore: cast_nullable_to_non_nullable
as int,tier: freezed == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as int?,cliff: null == cliff ? _self.cliff : cliff // ignore: cast_nullable_to_non_nullable
as bool,gapToNext: freezed == gapToNext ? _self.gapToNext : gapToNext // ignore: cast_nullable_to_non_nullable
as double?,adp: freezed == adp ? _self.adp : adp // ignore: cast_nullable_to_non_nullable
as double?,adpDelta: freezed == adpDelta ? _self.adpDelta : adpDelta // ignore: cast_nullable_to_non_nullable
as double?,adpFlag: freezed == adpFlag ? _self.adpFlag : adpFlag // ignore: cast_nullable_to_non_nullable
as String?,disagree: null == disagree ? _self.disagree : disagree // ignore: cast_nullable_to_non_nullable
as bool,survival: freezed == survival ? _self.survival : survival // ignore: cast_nullable_to_non_nullable
as double?,run: null == run ? _self.run : run // ignore: cast_nullable_to_non_nullable
as bool,runCount: null == runCount ? _self.runCount : runCount // ignore: cast_nullable_to_non_nullable
as int,pickScore: freezed == pickScore ? _self.pickScore : pickScore // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftRow].
extension DraftRowPatterns on DraftRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftRow value)  $default,){
final _that = this;
switch (_that) {
case _DraftRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftRow value)?  $default,){
final _that = this;
switch (_that) {
case _DraftRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rank,  String sleeperId,  String name,  String position,  String? team,  String? injuryStatus,  int? bye,  double points,  double vorp,  int posRank,  int? tier,  bool cliff,  double? gapToNext,  double? adp,  double? adpDelta,  String? adpFlag,  bool disagree,  double? survival,  bool run,  int runCount,  double? pickScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftRow() when $default != null:
return $default(_that.rank,_that.sleeperId,_that.name,_that.position,_that.team,_that.injuryStatus,_that.bye,_that.points,_that.vorp,_that.posRank,_that.tier,_that.cliff,_that.gapToNext,_that.adp,_that.adpDelta,_that.adpFlag,_that.disagree,_that.survival,_that.run,_that.runCount,_that.pickScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rank,  String sleeperId,  String name,  String position,  String? team,  String? injuryStatus,  int? bye,  double points,  double vorp,  int posRank,  int? tier,  bool cliff,  double? gapToNext,  double? adp,  double? adpDelta,  String? adpFlag,  bool disagree,  double? survival,  bool run,  int runCount,  double? pickScore)  $default,) {final _that = this;
switch (_that) {
case _DraftRow():
return $default(_that.rank,_that.sleeperId,_that.name,_that.position,_that.team,_that.injuryStatus,_that.bye,_that.points,_that.vorp,_that.posRank,_that.tier,_that.cliff,_that.gapToNext,_that.adp,_that.adpDelta,_that.adpFlag,_that.disagree,_that.survival,_that.run,_that.runCount,_that.pickScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rank,  String sleeperId,  String name,  String position,  String? team,  String? injuryStatus,  int? bye,  double points,  double vorp,  int posRank,  int? tier,  bool cliff,  double? gapToNext,  double? adp,  double? adpDelta,  String? adpFlag,  bool disagree,  double? survival,  bool run,  int runCount,  double? pickScore)?  $default,) {final _that = this;
switch (_that) {
case _DraftRow() when $default != null:
return $default(_that.rank,_that.sleeperId,_that.name,_that.position,_that.team,_that.injuryStatus,_that.bye,_that.points,_that.vorp,_that.posRank,_that.tier,_that.cliff,_that.gapToNext,_that.adp,_that.adpDelta,_that.adpFlag,_that.disagree,_that.survival,_that.run,_that.runCount,_that.pickScore);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DraftRow implements DraftRow {
  const _DraftRow({required this.rank, required this.sleeperId, required this.name, required this.position, this.team, this.injuryStatus, this.bye, required this.points, required this.vorp, required this.posRank, this.tier, required this.cliff, this.gapToNext, this.adp, this.adpDelta, this.adpFlag, required this.disagree, this.survival, required this.run, required this.runCount, this.pickScore});
  factory _DraftRow.fromJson(Map<String, dynamic> json) => _$DraftRowFromJson(json);

@override final  int rank;
@override final  String sleeperId;
@override final  String name;
@override final  String position;
@override final  String? team;
@override final  String? injuryStatus;
@override final  int? bye;
@override final  double points;
@override final  double vorp;
@override final  int posRank;
@override final  int? tier;
@override final  bool cliff;
@override final  double? gapToNext;
@override final  double? adp;
@override final  double? adpDelta;
@override final  String? adpFlag;
@override final  bool disagree;
/// 0–1 probability the player is still there at my next pick.
@override final  double? survival;
@override final  bool run;
@override final  int runCount;
@override final  double? pickScore;

/// Create a copy of DraftRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftRowCopyWith<_DraftRow> get copyWith => __$DraftRowCopyWithImpl<_DraftRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftRow&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.sleeperId, sleeperId) || other.sleeperId == sleeperId)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.team, team) || other.team == team)&&(identical(other.injuryStatus, injuryStatus) || other.injuryStatus == injuryStatus)&&(identical(other.bye, bye) || other.bye == bye)&&(identical(other.points, points) || other.points == points)&&(identical(other.vorp, vorp) || other.vorp == vorp)&&(identical(other.posRank, posRank) || other.posRank == posRank)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.cliff, cliff) || other.cliff == cliff)&&(identical(other.gapToNext, gapToNext) || other.gapToNext == gapToNext)&&(identical(other.adp, adp) || other.adp == adp)&&(identical(other.adpDelta, adpDelta) || other.adpDelta == adpDelta)&&(identical(other.adpFlag, adpFlag) || other.adpFlag == adpFlag)&&(identical(other.disagree, disagree) || other.disagree == disagree)&&(identical(other.survival, survival) || other.survival == survival)&&(identical(other.run, run) || other.run == run)&&(identical(other.runCount, runCount) || other.runCount == runCount)&&(identical(other.pickScore, pickScore) || other.pickScore == pickScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,rank,sleeperId,name,position,team,injuryStatus,bye,points,vorp,posRank,tier,cliff,gapToNext,adp,adpDelta,adpFlag,disagree,survival,run,runCount,pickScore]);

@override
String toString() {
  return 'DraftRow(rank: $rank, sleeperId: $sleeperId, name: $name, position: $position, team: $team, injuryStatus: $injuryStatus, bye: $bye, points: $points, vorp: $vorp, posRank: $posRank, tier: $tier, cliff: $cliff, gapToNext: $gapToNext, adp: $adp, adpDelta: $adpDelta, adpFlag: $adpFlag, disagree: $disagree, survival: $survival, run: $run, runCount: $runCount, pickScore: $pickScore)';
}


}

/// @nodoc
abstract mixin class _$DraftRowCopyWith<$Res> implements $DraftRowCopyWith<$Res> {
  factory _$DraftRowCopyWith(_DraftRow value, $Res Function(_DraftRow) _then) = __$DraftRowCopyWithImpl;
@override @useResult
$Res call({
 int rank, String sleeperId, String name, String position, String? team, String? injuryStatus, int? bye, double points, double vorp, int posRank, int? tier, bool cliff, double? gapToNext, double? adp, double? adpDelta, String? adpFlag, bool disagree, double? survival, bool run, int runCount, double? pickScore
});




}
/// @nodoc
class __$DraftRowCopyWithImpl<$Res>
    implements _$DraftRowCopyWith<$Res> {
  __$DraftRowCopyWithImpl(this._self, this._then);

  final _DraftRow _self;
  final $Res Function(_DraftRow) _then;

/// Create a copy of DraftRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rank = null,Object? sleeperId = null,Object? name = null,Object? position = null,Object? team = freezed,Object? injuryStatus = freezed,Object? bye = freezed,Object? points = null,Object? vorp = null,Object? posRank = null,Object? tier = freezed,Object? cliff = null,Object? gapToNext = freezed,Object? adp = freezed,Object? adpDelta = freezed,Object? adpFlag = freezed,Object? disagree = null,Object? survival = freezed,Object? run = null,Object? runCount = null,Object? pickScore = freezed,}) {
  return _then(_DraftRow(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,sleeperId: null == sleeperId ? _self.sleeperId : sleeperId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,team: freezed == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as String?,injuryStatus: freezed == injuryStatus ? _self.injuryStatus : injuryStatus // ignore: cast_nullable_to_non_nullable
as String?,bye: freezed == bye ? _self.bye : bye // ignore: cast_nullable_to_non_nullable
as int?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,vorp: null == vorp ? _self.vorp : vorp // ignore: cast_nullable_to_non_nullable
as double,posRank: null == posRank ? _self.posRank : posRank // ignore: cast_nullable_to_non_nullable
as int,tier: freezed == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as int?,cliff: null == cliff ? _self.cliff : cliff // ignore: cast_nullable_to_non_nullable
as bool,gapToNext: freezed == gapToNext ? _self.gapToNext : gapToNext // ignore: cast_nullable_to_non_nullable
as double?,adp: freezed == adp ? _self.adp : adp // ignore: cast_nullable_to_non_nullable
as double?,adpDelta: freezed == adpDelta ? _self.adpDelta : adpDelta // ignore: cast_nullable_to_non_nullable
as double?,adpFlag: freezed == adpFlag ? _self.adpFlag : adpFlag // ignore: cast_nullable_to_non_nullable
as String?,disagree: null == disagree ? _self.disagree : disagree // ignore: cast_nullable_to_non_nullable
as bool,survival: freezed == survival ? _self.survival : survival // ignore: cast_nullable_to_non_nullable
as double?,run: null == run ? _self.run : run // ignore: cast_nullable_to_non_nullable
as bool,runCount: null == runCount ? _self.runCount : runCount // ignore: cast_nullable_to_non_nullable
as int,pickScore: freezed == pickScore ? _self.pickScore : pickScore // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
