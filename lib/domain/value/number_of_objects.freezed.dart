// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'number_of_objects.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NumberOfObjects {

 int get value;
/// Create a copy of NumberOfObjects
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumberOfObjectsCopyWith<NumberOfObjects> get copyWith => _$NumberOfObjectsCopyWithImpl<NumberOfObjects>(this as NumberOfObjects, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumberOfObjects&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'NumberOfObjects(value: $value)';
}


}

/// @nodoc
abstract mixin class $NumberOfObjectsCopyWith<$Res>  {
  factory $NumberOfObjectsCopyWith(NumberOfObjects value, $Res Function(NumberOfObjects) _then) = _$NumberOfObjectsCopyWithImpl;
@useResult
$Res call({
 int value
});




}
/// @nodoc
class _$NumberOfObjectsCopyWithImpl<$Res>
    implements $NumberOfObjectsCopyWith<$Res> {
  _$NumberOfObjectsCopyWithImpl(this._self, this._then);

  final NumberOfObjects _self;
  final $Res Function(NumberOfObjects) _then;

/// Create a copy of NumberOfObjects
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NumberOfObjects].
extension NumberOfObjectsPatterns on NumberOfObjects {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NumberOfObjects value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NumberOfObjects() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NumberOfObjects value)  $default,){
final _that = this;
switch (_that) {
case _NumberOfObjects():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NumberOfObjects value)?  $default,){
final _that = this;
switch (_that) {
case _NumberOfObjects() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NumberOfObjects() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int value)  $default,) {final _that = this;
switch (_that) {
case _NumberOfObjects():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int value)?  $default,) {final _that = this;
switch (_that) {
case _NumberOfObjects() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _NumberOfObjects implements NumberOfObjects {
  const _NumberOfObjects(this.value): assert(value>=1);
  

@override final  int value;

/// Create a copy of NumberOfObjects
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NumberOfObjectsCopyWith<_NumberOfObjects> get copyWith => __$NumberOfObjectsCopyWithImpl<_NumberOfObjects>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NumberOfObjects&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'NumberOfObjects(value: $value)';
}


}

/// @nodoc
abstract mixin class _$NumberOfObjectsCopyWith<$Res> implements $NumberOfObjectsCopyWith<$Res> {
  factory _$NumberOfObjectsCopyWith(_NumberOfObjects value, $Res Function(_NumberOfObjects) _then) = __$NumberOfObjectsCopyWithImpl;
@override @useResult
$Res call({
 int value
});




}
/// @nodoc
class __$NumberOfObjectsCopyWithImpl<$Res>
    implements _$NumberOfObjectsCopyWith<$Res> {
  __$NumberOfObjectsCopyWithImpl(this._self, this._then);

  final _NumberOfObjects _self;
  final $Res Function(_NumberOfObjects) _then;

/// Create a copy of NumberOfObjects
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_NumberOfObjects(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
