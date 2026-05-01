// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'description.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Description {

 String? get value;
/// Create a copy of Description
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DescriptionCopyWith<Description> get copyWith => _$DescriptionCopyWithImpl<Description>(this as Description, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Description&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'Description(value: $value)';
}


}

/// @nodoc
abstract mixin class $DescriptionCopyWith<$Res>  {
  factory $DescriptionCopyWith(Description value, $Res Function(Description) _then) = _$DescriptionCopyWithImpl;
@useResult
$Res call({
 String? value
});




}
/// @nodoc
class _$DescriptionCopyWithImpl<$Res>
    implements $DescriptionCopyWith<$Res> {
  _$DescriptionCopyWithImpl(this._self, this._then);

  final Description _self;
  final $Res Function(Description) _then;

/// Create a copy of Description
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Description].
extension DescriptionPatterns on Description {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Description value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Description() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Description value)  $default,){
final _that = this;
switch (_that) {
case _Description():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Description value)?  $default,){
final _that = this;
switch (_that) {
case _Description() when $default != null:
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
case _Description() when $default != null:
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
case _Description():
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
case _Description() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _Description implements Description {
  const _Description([this.value]);
  

@override final  String? value;

/// Create a copy of Description
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DescriptionCopyWith<_Description> get copyWith => __$DescriptionCopyWithImpl<_Description>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Description&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'Description(value: $value)';
}


}

/// @nodoc
abstract mixin class _$DescriptionCopyWith<$Res> implements $DescriptionCopyWith<$Res> {
  factory _$DescriptionCopyWith(_Description value, $Res Function(_Description) _then) = __$DescriptionCopyWithImpl;
@override @useResult
$Res call({
 String? value
});




}
/// @nodoc
class __$DescriptionCopyWithImpl<$Res>
    implements _$DescriptionCopyWith<$Res> {
  __$DescriptionCopyWithImpl(this._self, this._then);

  final _Description _self;
  final $Res Function(_Description) _then;

/// Create a copy of Description
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(_Description(
freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
