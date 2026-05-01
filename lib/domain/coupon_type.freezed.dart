// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coupon_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CouponType {

@IdJsonConverter() Id get id;@LayerJsonConverter() Layer get layer;@RootTermIdJsonConverter() RootTermId get rootTermId;@NumberOfObjectsJsonConverter() NumberOfObjects get numberOfObjects;
/// Create a copy of CouponType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CouponTypeCopyWith<CouponType> get copyWith => _$CouponTypeCopyWithImpl<CouponType>(this as CouponType, _$identity);

  /// Serializes this CouponType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CouponType&&(identical(other.id, id) || other.id == id)&&(identical(other.layer, layer) || other.layer == layer)&&(identical(other.rootTermId, rootTermId) || other.rootTermId == rootTermId)&&(identical(other.numberOfObjects, numberOfObjects) || other.numberOfObjects == numberOfObjects));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,layer,rootTermId,numberOfObjects);

@override
String toString() {
  return 'CouponType(id: $id, layer: $layer, rootTermId: $rootTermId, numberOfObjects: $numberOfObjects)';
}


}

/// @nodoc
abstract mixin class $CouponTypeCopyWith<$Res>  {
  factory $CouponTypeCopyWith(CouponType value, $Res Function(CouponType) _then) = _$CouponTypeCopyWithImpl;
@useResult
$Res call({
@IdJsonConverter() Id id,@LayerJsonConverter() Layer layer,@RootTermIdJsonConverter() RootTermId rootTermId,@NumberOfObjectsJsonConverter() NumberOfObjects numberOfObjects
});


$IdCopyWith<$Res> get id;$LayerCopyWith<$Res> get layer;$RootTermIdCopyWith<$Res> get rootTermId;$NumberOfObjectsCopyWith<$Res> get numberOfObjects;

}
/// @nodoc
class _$CouponTypeCopyWithImpl<$Res>
    implements $CouponTypeCopyWith<$Res> {
  _$CouponTypeCopyWithImpl(this._self, this._then);

  final CouponType _self;
  final $Res Function(CouponType) _then;

/// Create a copy of CouponType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? layer = null,Object? rootTermId = null,Object? numberOfObjects = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,layer: null == layer ? _self.layer : layer // ignore: cast_nullable_to_non_nullable
as Layer,rootTermId: null == rootTermId ? _self.rootTermId : rootTermId // ignore: cast_nullable_to_non_nullable
as RootTermId,numberOfObjects: null == numberOfObjects ? _self.numberOfObjects : numberOfObjects // ignore: cast_nullable_to_non_nullable
as NumberOfObjects,
  ));
}
/// Create a copy of CouponType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of CouponType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LayerCopyWith<$Res> get layer {
  
  return $LayerCopyWith<$Res>(_self.layer, (value) {
    return _then(_self.copyWith(layer: value));
  });
}/// Create a copy of CouponType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RootTermIdCopyWith<$Res> get rootTermId {
  
  return $RootTermIdCopyWith<$Res>(_self.rootTermId, (value) {
    return _then(_self.copyWith(rootTermId: value));
  });
}/// Create a copy of CouponType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NumberOfObjectsCopyWith<$Res> get numberOfObjects {
  
  return $NumberOfObjectsCopyWith<$Res>(_self.numberOfObjects, (value) {
    return _then(_self.copyWith(numberOfObjects: value));
  });
}
}


/// Adds pattern-matching-related methods to [CouponType].
extension CouponTypePatterns on CouponType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CouponType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CouponType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CouponType value)  $default,){
final _that = this;
switch (_that) {
case _CouponType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CouponType value)?  $default,){
final _that = this;
switch (_that) {
case _CouponType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @LayerJsonConverter()  Layer layer, @RootTermIdJsonConverter()  RootTermId rootTermId, @NumberOfObjectsJsonConverter()  NumberOfObjects numberOfObjects)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CouponType() when $default != null:
return $default(_that.id,_that.layer,_that.rootTermId,_that.numberOfObjects);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @LayerJsonConverter()  Layer layer, @RootTermIdJsonConverter()  RootTermId rootTermId, @NumberOfObjectsJsonConverter()  NumberOfObjects numberOfObjects)  $default,) {final _that = this;
switch (_that) {
case _CouponType():
return $default(_that.id,_that.layer,_that.rootTermId,_that.numberOfObjects);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdJsonConverter()  Id id, @LayerJsonConverter()  Layer layer, @RootTermIdJsonConverter()  RootTermId rootTermId, @NumberOfObjectsJsonConverter()  NumberOfObjects numberOfObjects)?  $default,) {final _that = this;
switch (_that) {
case _CouponType() when $default != null:
return $default(_that.id,_that.layer,_that.rootTermId,_that.numberOfObjects);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CouponType implements CouponType {
   _CouponType({@IdJsonConverter() required this.id, @LayerJsonConverter() required this.layer, @RootTermIdJsonConverter() required this.rootTermId, @NumberOfObjectsJsonConverter() required this.numberOfObjects});
  factory _CouponType.fromJson(Map<String, dynamic> json) => _$CouponTypeFromJson(json);

@override@IdJsonConverter() final  Id id;
@override@LayerJsonConverter() final  Layer layer;
@override@RootTermIdJsonConverter() final  RootTermId rootTermId;
@override@NumberOfObjectsJsonConverter() final  NumberOfObjects numberOfObjects;

/// Create a copy of CouponType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CouponTypeCopyWith<_CouponType> get copyWith => __$CouponTypeCopyWithImpl<_CouponType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CouponTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CouponType&&(identical(other.id, id) || other.id == id)&&(identical(other.layer, layer) || other.layer == layer)&&(identical(other.rootTermId, rootTermId) || other.rootTermId == rootTermId)&&(identical(other.numberOfObjects, numberOfObjects) || other.numberOfObjects == numberOfObjects));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,layer,rootTermId,numberOfObjects);

@override
String toString() {
  return 'CouponType(id: $id, layer: $layer, rootTermId: $rootTermId, numberOfObjects: $numberOfObjects)';
}


}

/// @nodoc
abstract mixin class _$CouponTypeCopyWith<$Res> implements $CouponTypeCopyWith<$Res> {
  factory _$CouponTypeCopyWith(_CouponType value, $Res Function(_CouponType) _then) = __$CouponTypeCopyWithImpl;
@override @useResult
$Res call({
@IdJsonConverter() Id id,@LayerJsonConverter() Layer layer,@RootTermIdJsonConverter() RootTermId rootTermId,@NumberOfObjectsJsonConverter() NumberOfObjects numberOfObjects
});


@override $IdCopyWith<$Res> get id;@override $LayerCopyWith<$Res> get layer;@override $RootTermIdCopyWith<$Res> get rootTermId;@override $NumberOfObjectsCopyWith<$Res> get numberOfObjects;

}
/// @nodoc
class __$CouponTypeCopyWithImpl<$Res>
    implements _$CouponTypeCopyWith<$Res> {
  __$CouponTypeCopyWithImpl(this._self, this._then);

  final _CouponType _self;
  final $Res Function(_CouponType) _then;

/// Create a copy of CouponType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? layer = null,Object? rootTermId = null,Object? numberOfObjects = null,}) {
  return _then(_CouponType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,layer: null == layer ? _self.layer : layer // ignore: cast_nullable_to_non_nullable
as Layer,rootTermId: null == rootTermId ? _self.rootTermId : rootTermId // ignore: cast_nullable_to_non_nullable
as RootTermId,numberOfObjects: null == numberOfObjects ? _self.numberOfObjects : numberOfObjects // ignore: cast_nullable_to_non_nullable
as NumberOfObjects,
  ));
}

/// Create a copy of CouponType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of CouponType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LayerCopyWith<$Res> get layer {
  
  return $LayerCopyWith<$Res>(_self.layer, (value) {
    return _then(_self.copyWith(layer: value));
  });
}/// Create a copy of CouponType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RootTermIdCopyWith<$Res> get rootTermId {
  
  return $RootTermIdCopyWith<$Res>(_self.rootTermId, (value) {
    return _then(_self.copyWith(rootTermId: value));
  });
}/// Create a copy of CouponType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NumberOfObjectsCopyWith<$Res> get numberOfObjects {
  
  return $NumberOfObjectsCopyWith<$Res>(_self.numberOfObjects, (value) {
    return _then(_self.copyWith(numberOfObjects: value));
  });
}
}

// dart format on
