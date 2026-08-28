// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DraftSummary {

 String get draftId; bool get running; int? get season;
/// Create a copy of DraftSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftSummaryCopyWith<DraftSummary> get copyWith => _$DraftSummaryCopyWithImpl<DraftSummary>(this as DraftSummary, _$identity);

  /// Serializes this DraftSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftSummary&&(identical(other.draftId, draftId) || other.draftId == draftId)&&(identical(other.running, running) || other.running == running)&&(identical(other.season, season) || other.season == season));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,draftId,running,season);

@override
String toString() {
  return 'DraftSummary(draftId: $draftId, running: $running, season: $season)';
}


}

/// @nodoc
abstract mixin class $DraftSummaryCopyWith<$Res>  {
  factory $DraftSummaryCopyWith(DraftSummary value, $Res Function(DraftSummary) _then) = _$DraftSummaryCopyWithImpl;
@useResult
$Res call({
 String draftId, bool running, int? season
});




}
/// @nodoc
class _$DraftSummaryCopyWithImpl<$Res>
    implements $DraftSummaryCopyWith<$Res> {
  _$DraftSummaryCopyWithImpl(this._self, this._then);

  final DraftSummary _self;
  final $Res Function(DraftSummary) _then;

/// Create a copy of DraftSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? draftId = null,Object? running = null,Object? season = freezed,}) {
  return _then(DraftSummary(
draftId: null == draftId ? _self.draftId : draftId // ignore: cast_nullable_to_non_nullable
as String,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,season: freezed == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftSummary].
extension DraftSummaryPatterns on DraftSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftSummary value)  $default,){
final _that = this;
switch (_that) {
case _DraftSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftSummary value)?  $default,){
final _that = this;
switch (_that) {
case _DraftSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String draftId,  bool running,  int? season)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftSummary() when $default != null:
return $default(_that.draftId,_that.running,_that.season);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String draftId,  bool running,  int? season)  $default,) {final _that = this;
switch (_that) {
case _DraftSummary():
return $default(_that.draftId,_that.running,_that.season);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String draftId,  bool running,  int? season)?  $default,) {final _that = this;
switch (_that) {
case _DraftSummary() when $default != null:
return $default(_that.draftId,_that.running,_that.season);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DraftSummary implements DraftSummary {
  const _DraftSummary({required this.draftId, required this.running, this.season});
  factory _DraftSummary.fromJson(Map<String, dynamic> json) => _$DraftSummaryFromJson(json);

@override final  String draftId;
@override final  bool running;
@override final  int? season;

/// Create a copy of DraftSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftSummaryCopyWith<_DraftSummary> get copyWith => __$DraftSummaryCopyWithImpl<_DraftSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftSummary&&(identical(other.draftId, draftId) || other.draftId == draftId)&&(identical(other.running, running) || other.running == running)&&(identical(other.season, season) || other.season == season));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,draftId,running,season);

@override
String toString() {
  return 'DraftSummary(draftId: $draftId, running: $running, season: $season)';
}


}

/// @nodoc
abstract mixin class _$DraftSummaryCopyWith<$Res> implements $DraftSummaryCopyWith<$Res> {
  factory _$DraftSummaryCopyWith(_DraftSummary value, $Res Function(_DraftSummary) _then) = __$DraftSummaryCopyWithImpl;
@override @useResult
$Res call({
 String draftId, bool running, int? season
});




}
/// @nodoc
class __$DraftSummaryCopyWithImpl<$Res>
    implements _$DraftSummaryCopyWith<$Res> {
  __$DraftSummaryCopyWithImpl(this._self, this._then);

  final _DraftSummary _self;
  final $Res Function(_DraftSummary) _then;

/// Create a copy of DraftSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? draftId = null,Object? running = null,Object? season = freezed,}) {
  return _then(_DraftSummary(
draftId: null == draftId ? _self.draftId : draftId // ignore: cast_nullable_to_non_nullable
as String,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,season: freezed == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$DraftStartOut {

 String get draftId; int get season; bool get running; DateTime? get startedAt;/// True when the runner was already alive: the call was a no-op.
 bool get alreadyRunning;/// Null until Sleeper assigns `draft_order` (often late on mocks).
 int? get mySlot; int get picksMade; int get boardRows;
/// Create a copy of DraftStartOut
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftStartOutCopyWith<DraftStartOut> get copyWith => _$DraftStartOutCopyWithImpl<DraftStartOut>(this as DraftStartOut, _$identity);

  /// Serializes this DraftStartOut to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftStartOut&&(identical(other.draftId, draftId) || other.draftId == draftId)&&(identical(other.season, season) || other.season == season)&&(identical(other.running, running) || other.running == running)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.alreadyRunning, alreadyRunning) || other.alreadyRunning == alreadyRunning)&&(identical(other.mySlot, mySlot) || other.mySlot == mySlot)&&(identical(other.picksMade, picksMade) || other.picksMade == picksMade)&&(identical(other.boardRows, boardRows) || other.boardRows == boardRows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,draftId,season,running,startedAt,alreadyRunning,mySlot,picksMade,boardRows);

@override
String toString() {
  return 'DraftStartOut(draftId: $draftId, season: $season, running: $running, startedAt: $startedAt, alreadyRunning: $alreadyRunning, mySlot: $mySlot, picksMade: $picksMade, boardRows: $boardRows)';
}


}

/// @nodoc
abstract mixin class $DraftStartOutCopyWith<$Res>  {
  factory $DraftStartOutCopyWith(DraftStartOut value, $Res Function(DraftStartOut) _then) = _$DraftStartOutCopyWithImpl;
@useResult
$Res call({
 String draftId, int season, bool running, DateTime? startedAt, bool alreadyRunning, int? mySlot, int picksMade, int boardRows
});




}
/// @nodoc
class _$DraftStartOutCopyWithImpl<$Res>
    implements $DraftStartOutCopyWith<$Res> {
  _$DraftStartOutCopyWithImpl(this._self, this._then);

  final DraftStartOut _self;
  final $Res Function(DraftStartOut) _then;

/// Create a copy of DraftStartOut
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? draftId = null,Object? season = null,Object? running = null,Object? startedAt = freezed,Object? alreadyRunning = null,Object? mySlot = freezed,Object? picksMade = null,Object? boardRows = null,}) {
  return _then(DraftStartOut(
draftId: null == draftId ? _self.draftId : draftId // ignore: cast_nullable_to_non_nullable
as String,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,alreadyRunning: null == alreadyRunning ? _self.alreadyRunning : alreadyRunning // ignore: cast_nullable_to_non_nullable
as bool,mySlot: freezed == mySlot ? _self.mySlot : mySlot // ignore: cast_nullable_to_non_nullable
as int?,picksMade: null == picksMade ? _self.picksMade : picksMade // ignore: cast_nullable_to_non_nullable
as int,boardRows: null == boardRows ? _self.boardRows : boardRows // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftStartOut].
extension DraftStartOutPatterns on DraftStartOut {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftStartOut value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftStartOut() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftStartOut value)  $default,){
final _that = this;
switch (_that) {
case _DraftStartOut():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftStartOut value)?  $default,){
final _that = this;
switch (_that) {
case _DraftStartOut() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String draftId,  int season,  bool running,  DateTime? startedAt,  bool alreadyRunning,  int? mySlot,  int picksMade,  int boardRows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftStartOut() when $default != null:
return $default(_that.draftId,_that.season,_that.running,_that.startedAt,_that.alreadyRunning,_that.mySlot,_that.picksMade,_that.boardRows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String draftId,  int season,  bool running,  DateTime? startedAt,  bool alreadyRunning,  int? mySlot,  int picksMade,  int boardRows)  $default,) {final _that = this;
switch (_that) {
case _DraftStartOut():
return $default(_that.draftId,_that.season,_that.running,_that.startedAt,_that.alreadyRunning,_that.mySlot,_that.picksMade,_that.boardRows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String draftId,  int season,  bool running,  DateTime? startedAt,  bool alreadyRunning,  int? mySlot,  int picksMade,  int boardRows)?  $default,) {final _that = this;
switch (_that) {
case _DraftStartOut() when $default != null:
return $default(_that.draftId,_that.season,_that.running,_that.startedAt,_that.alreadyRunning,_that.mySlot,_that.picksMade,_that.boardRows);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DraftStartOut implements DraftStartOut {
  const _DraftStartOut({required this.draftId, required this.season, required this.running, this.startedAt, required this.alreadyRunning, this.mySlot, required this.picksMade, required this.boardRows});
  factory _DraftStartOut.fromJson(Map<String, dynamic> json) => _$DraftStartOutFromJson(json);

@override final  String draftId;
@override final  int season;
@override final  bool running;
@override final  DateTime? startedAt;
/// True when the runner was already alive: the call was a no-op.
@override final  bool alreadyRunning;
/// Null until Sleeper assigns `draft_order` (often late on mocks).
@override final  int? mySlot;
@override final  int picksMade;
@override final  int boardRows;

/// Create a copy of DraftStartOut
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftStartOutCopyWith<_DraftStartOut> get copyWith => __$DraftStartOutCopyWithImpl<_DraftStartOut>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftStartOutToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftStartOut&&(identical(other.draftId, draftId) || other.draftId == draftId)&&(identical(other.season, season) || other.season == season)&&(identical(other.running, running) || other.running == running)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.alreadyRunning, alreadyRunning) || other.alreadyRunning == alreadyRunning)&&(identical(other.mySlot, mySlot) || other.mySlot == mySlot)&&(identical(other.picksMade, picksMade) || other.picksMade == picksMade)&&(identical(other.boardRows, boardRows) || other.boardRows == boardRows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,draftId,season,running,startedAt,alreadyRunning,mySlot,picksMade,boardRows);

@override
String toString() {
  return 'DraftStartOut(draftId: $draftId, season: $season, running: $running, startedAt: $startedAt, alreadyRunning: $alreadyRunning, mySlot: $mySlot, picksMade: $picksMade, boardRows: $boardRows)';
}


}

/// @nodoc
abstract mixin class _$DraftStartOutCopyWith<$Res> implements $DraftStartOutCopyWith<$Res> {
  factory _$DraftStartOutCopyWith(_DraftStartOut value, $Res Function(_DraftStartOut) _then) = __$DraftStartOutCopyWithImpl;
@override @useResult
$Res call({
 String draftId, int season, bool running, DateTime? startedAt, bool alreadyRunning, int? mySlot, int picksMade, int boardRows
});




}
/// @nodoc
class __$DraftStartOutCopyWithImpl<$Res>
    implements _$DraftStartOutCopyWith<$Res> {
  __$DraftStartOutCopyWithImpl(this._self, this._then);

  final _DraftStartOut _self;
  final $Res Function(_DraftStartOut) _then;

/// Create a copy of DraftStartOut
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? draftId = null,Object? season = null,Object? running = null,Object? startedAt = freezed,Object? alreadyRunning = null,Object? mySlot = freezed,Object? picksMade = null,Object? boardRows = null,}) {
  return _then(_DraftStartOut(
draftId: null == draftId ? _self.draftId : draftId // ignore: cast_nullable_to_non_nullable
as String,season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,alreadyRunning: null == alreadyRunning ? _self.alreadyRunning : alreadyRunning // ignore: cast_nullable_to_non_nullable
as bool,mySlot: freezed == mySlot ? _self.mySlot : mySlot // ignore: cast_nullable_to_non_nullable
as int?,picksMade: null == picksMade ? _self.picksMade : picksMade // ignore: cast_nullable_to_non_nullable
as int,boardRows: null == boardRows ? _self.boardRows : boardRows // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DraftStopOut {

 String get draftId; bool get running;
/// Create a copy of DraftStopOut
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftStopOutCopyWith<DraftStopOut> get copyWith => _$DraftStopOutCopyWithImpl<DraftStopOut>(this as DraftStopOut, _$identity);

  /// Serializes this DraftStopOut to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftStopOut&&(identical(other.draftId, draftId) || other.draftId == draftId)&&(identical(other.running, running) || other.running == running));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,draftId,running);

@override
String toString() {
  return 'DraftStopOut(draftId: $draftId, running: $running)';
}


}

/// @nodoc
abstract mixin class $DraftStopOutCopyWith<$Res>  {
  factory $DraftStopOutCopyWith(DraftStopOut value, $Res Function(DraftStopOut) _then) = _$DraftStopOutCopyWithImpl;
@useResult
$Res call({
 String draftId, bool running
});




}
/// @nodoc
class _$DraftStopOutCopyWithImpl<$Res>
    implements $DraftStopOutCopyWith<$Res> {
  _$DraftStopOutCopyWithImpl(this._self, this._then);

  final DraftStopOut _self;
  final $Res Function(DraftStopOut) _then;

/// Create a copy of DraftStopOut
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? draftId = null,Object? running = null,}) {
  return _then(DraftStopOut(
draftId: null == draftId ? _self.draftId : draftId // ignore: cast_nullable_to_non_nullable
as String,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftStopOut].
extension DraftStopOutPatterns on DraftStopOut {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftStopOut value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftStopOut() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftStopOut value)  $default,){
final _that = this;
switch (_that) {
case _DraftStopOut():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftStopOut value)?  $default,){
final _that = this;
switch (_that) {
case _DraftStopOut() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String draftId,  bool running)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftStopOut() when $default != null:
return $default(_that.draftId,_that.running);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String draftId,  bool running)  $default,) {final _that = this;
switch (_that) {
case _DraftStopOut():
return $default(_that.draftId,_that.running);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String draftId,  bool running)?  $default,) {final _that = this;
switch (_that) {
case _DraftStopOut() when $default != null:
return $default(_that.draftId,_that.running);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DraftStopOut implements DraftStopOut {
  const _DraftStopOut({required this.draftId, required this.running});
  factory _DraftStopOut.fromJson(Map<String, dynamic> json) => _$DraftStopOutFromJson(json);

@override final  String draftId;
@override final  bool running;

/// Create a copy of DraftStopOut
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftStopOutCopyWith<_DraftStopOut> get copyWith => __$DraftStopOutCopyWithImpl<_DraftStopOut>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftStopOutToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftStopOut&&(identical(other.draftId, draftId) || other.draftId == draftId)&&(identical(other.running, running) || other.running == running));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,draftId,running);

@override
String toString() {
  return 'DraftStopOut(draftId: $draftId, running: $running)';
}


}

/// @nodoc
abstract mixin class _$DraftStopOutCopyWith<$Res> implements $DraftStopOutCopyWith<$Res> {
  factory _$DraftStopOutCopyWith(_DraftStopOut value, $Res Function(_DraftStopOut) _then) = __$DraftStopOutCopyWithImpl;
@override @useResult
$Res call({
 String draftId, bool running
});




}
/// @nodoc
class __$DraftStopOutCopyWithImpl<$Res>
    implements _$DraftStopOutCopyWith<$Res> {
  __$DraftStopOutCopyWithImpl(this._self, this._then);

  final _DraftStopOut _self;
  final $Res Function(_DraftStopOut) _then;

/// Create a copy of DraftStopOut
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? draftId = null,Object? running = null,}) {
  return _then(_DraftStopOut(
draftId: null == draftId ? _self.draftId : draftId // ignore: cast_nullable_to_non_nullable
as String,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
