// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'path.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Path {

 String? get value;
/// Create a copy of Path
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PathCopyWith<Path> get copyWith => _$PathCopyWithImpl<Path>(this as Path, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Path&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'Path(value: $value)';
}


}

/// @nodoc
abstract mixin class $PathCopyWith<$Res>  {
  factory $PathCopyWith(Path value, $Res Function(Path) _then) = _$PathCopyWithImpl;
@useResult
$Res call({
 String? value
});




}
/// @nodoc
class _$PathCopyWithImpl<$Res>
    implements $PathCopyWith<$Res> {
  _$PathCopyWithImpl(this._self, this._then);

  final Path _self;
  final $Res Function(Path) _then;

/// Create a copy of Path
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Path].
extension PathPatterns on Path {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Path value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Path() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Path value)  $default,){
final _that = this;
switch (_that) {
case _Path():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Path value)?  $default,){
final _that = this;
switch (_that) {
case _Path() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Path() when $default != null:
return $default(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? value)  $default,) {final _that = this;
switch (_that) {
case _Path():
return $default(_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? value)?  $default,) {final _that = this;
switch (_that) {
case _Path() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _Path implements Path {
  const _Path([this.value]);
  

@override final  String? value;

/// Create a copy of Path
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PathCopyWith<_Path> get copyWith => __$PathCopyWithImpl<_Path>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Path&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'Path(value: $value)';
}


}

/// @nodoc
abstract mixin class _$PathCopyWith<$Res> implements $PathCopyWith<$Res> {
  factory _$PathCopyWith(_Path value, $Res Function(_Path) _then) = __$PathCopyWithImpl;
@override @useResult
$Res call({
 String? value
});




}
/// @nodoc
class __$PathCopyWithImpl<$Res>
    implements _$PathCopyWith<$Res> {
  __$PathCopyWithImpl(this._self, this._then);

  final _Path _self;
  final $Res Function(_Path) _then;

/// Create a copy of Path
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(_Path(
freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
