// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_type_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductTypeId {

 int get value;
/// Create a copy of ProductTypeId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductTypeIdCopyWith<ProductTypeId> get copyWith => _$ProductTypeIdCopyWithImpl<ProductTypeId>(this as ProductTypeId, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductTypeId&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ProductTypeId(value: $value)';
}


}

/// @nodoc
abstract mixin class $ProductTypeIdCopyWith<$Res>  {
  factory $ProductTypeIdCopyWith(ProductTypeId value, $Res Function(ProductTypeId) _then) = _$ProductTypeIdCopyWithImpl;
@useResult
$Res call({
 int value
});




}
/// @nodoc
class _$ProductTypeIdCopyWithImpl<$Res>
    implements $ProductTypeIdCopyWith<$Res> {
  _$ProductTypeIdCopyWithImpl(this._self, this._then);

  final ProductTypeId _self;
  final $Res Function(ProductTypeId) _then;

/// Create a copy of ProductTypeId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductTypeId].
extension ProductTypeIdPatterns on ProductTypeId {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductTypeId value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductTypeId() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductTypeId value)  $default,){
final _that = this;
switch (_that) {
case _ProductTypeId():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductTypeId value)?  $default,){
final _that = this;
switch (_that) {
case _ProductTypeId() when $default != null:
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
case _ProductTypeId() when $default != null:
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
case _ProductTypeId():
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
case _ProductTypeId() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _ProductTypeId implements ProductTypeId {
  const _ProductTypeId(this.value): assert(value>=0);
  

@override final  int value;

/// Create a copy of ProductTypeId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductTypeIdCopyWith<_ProductTypeId> get copyWith => __$ProductTypeIdCopyWithImpl<_ProductTypeId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductTypeId&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ProductTypeId(value: $value)';
}


}

/// @nodoc
abstract mixin class _$ProductTypeIdCopyWith<$Res> implements $ProductTypeIdCopyWith<$Res> {
  factory _$ProductTypeIdCopyWith(_ProductTypeId value, $Res Function(_ProductTypeId) _then) = __$ProductTypeIdCopyWithImpl;
@override @useResult
$Res call({
 int value
});




}
/// @nodoc
class __$ProductTypeIdCopyWithImpl<$Res>
    implements _$ProductTypeIdCopyWith<$Res> {
  __$ProductTypeIdCopyWithImpl(this._self, this._then);

  final _ProductTypeId _self;
  final $Res Function(_ProductTypeId) _then;

/// Create a copy of ProductTypeId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_ProductTypeId(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
