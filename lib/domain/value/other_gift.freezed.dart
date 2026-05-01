// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'other_gift.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtherGift {

 String? get value;
/// Create a copy of OtherGift
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtherGiftCopyWith<OtherGift> get copyWith => _$OtherGiftCopyWithImpl<OtherGift>(this as OtherGift, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtherGift&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'OtherGift(value: $value)';
}


}

/// @nodoc
abstract mixin class $OtherGiftCopyWith<$Res>  {
  factory $OtherGiftCopyWith(OtherGift value, $Res Function(OtherGift) _then) = _$OtherGiftCopyWithImpl;
@useResult
$Res call({
 String? value
});




}
/// @nodoc
class _$OtherGiftCopyWithImpl<$Res>
    implements $OtherGiftCopyWith<$Res> {
  _$OtherGiftCopyWithImpl(this._self, this._then);

  final OtherGift _self;
  final $Res Function(OtherGift) _then;

/// Create a copy of OtherGift
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OtherGift].
extension OtherGiftPatterns on OtherGift {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtherGift value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtherGift() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtherGift value)  $default,){
final _that = this;
switch (_that) {
case _OtherGift():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtherGift value)?  $default,){
final _that = this;
switch (_that) {
case _OtherGift() when $default != null:
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
case _OtherGift() when $default != null:
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
case _OtherGift():
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
case _OtherGift() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _OtherGift implements OtherGift {
  const _OtherGift([this.value]);
  

@override final  String? value;

/// Create a copy of OtherGift
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtherGiftCopyWith<_OtherGift> get copyWith => __$OtherGiftCopyWithImpl<_OtherGift>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtherGift&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'OtherGift(value: $value)';
}


}

/// @nodoc
abstract mixin class _$OtherGiftCopyWith<$Res> implements $OtherGiftCopyWith<$Res> {
  factory _$OtherGiftCopyWith(_OtherGift value, $Res Function(_OtherGift) _then) = __$OtherGiftCopyWithImpl;
@override @useResult
$Res call({
 String? value
});




}
/// @nodoc
class __$OtherGiftCopyWithImpl<$Res>
    implements _$OtherGiftCopyWith<$Res> {
  __$OtherGiftCopyWithImpl(this._self, this._then);

  final _OtherGift _self;
  final $Res Function(_OtherGift) _then;

/// Create a copy of OtherGift
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(_OtherGift(
freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
