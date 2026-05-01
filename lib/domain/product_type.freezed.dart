// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductType {

@ProductTypeIdJsonConverter() ProductTypeId get id;@JsonKey(name: 'parent_type_id')@ProductTypeIdJsonConverter() ProductTypeId get parentTypeId;@TitleJsonConverter() Title get name;@JsonKey(name: 'sub_types') List<ProductType> get subtypes; List<Product> get products;
/// Create a copy of ProductType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductTypeCopyWith<ProductType> get copyWith => _$ProductTypeCopyWithImpl<ProductType>(this as ProductType, _$identity);

  /// Serializes this ProductType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductType&&(identical(other.id, id) || other.id == id)&&(identical(other.parentTypeId, parentTypeId) || other.parentTypeId == parentTypeId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.subtypes, subtypes)&&const DeepCollectionEquality().equals(other.products, products));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,parentTypeId,name,const DeepCollectionEquality().hash(subtypes),const DeepCollectionEquality().hash(products));

@override
String toString() {
  return 'ProductType(id: $id, parentTypeId: $parentTypeId, name: $name, subtypes: $subtypes, products: $products)';
}


}

/// @nodoc
abstract mixin class $ProductTypeCopyWith<$Res>  {
  factory $ProductTypeCopyWith(ProductType value, $Res Function(ProductType) _then) = _$ProductTypeCopyWithImpl;
@useResult
$Res call({
@ProductTypeIdJsonConverter() ProductTypeId id,@JsonKey(name: 'parent_type_id')@ProductTypeIdJsonConverter() ProductTypeId parentTypeId,@TitleJsonConverter() Title name,@JsonKey(name: 'sub_types') List<ProductType> subtypes, List<Product> products
});


$ProductTypeIdCopyWith<$Res> get id;$ProductTypeIdCopyWith<$Res> get parentTypeId;$TitleCopyWith<$Res> get name;

}
/// @nodoc
class _$ProductTypeCopyWithImpl<$Res>
    implements $ProductTypeCopyWith<$Res> {
  _$ProductTypeCopyWithImpl(this._self, this._then);

  final ProductType _self;
  final $Res Function(ProductType) _then;

/// Create a copy of ProductType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? parentTypeId = null,Object? name = null,Object? subtypes = null,Object? products = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as ProductTypeId,parentTypeId: null == parentTypeId ? _self.parentTypeId : parentTypeId // ignore: cast_nullable_to_non_nullable
as ProductTypeId,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as Title,subtypes: null == subtypes ? _self.subtypes : subtypes // ignore: cast_nullable_to_non_nullable
as List<ProductType>,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}
/// Create a copy of ProductType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductTypeIdCopyWith<$Res> get id {
  
  return $ProductTypeIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of ProductType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductTypeIdCopyWith<$Res> get parentTypeId {
  
  return $ProductTypeIdCopyWith<$Res>(_self.parentTypeId, (value) {
    return _then(_self.copyWith(parentTypeId: value));
  });
}/// Create a copy of ProductType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get name {
  
  return $TitleCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProductType].
extension ProductTypePatterns on ProductType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductType value)  $default,){
final _that = this;
switch (_that) {
case _ProductType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductType value)?  $default,){
final _that = this;
switch (_that) {
case _ProductType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@ProductTypeIdJsonConverter()  ProductTypeId id, @JsonKey(name: 'parent_type_id')@ProductTypeIdJsonConverter()  ProductTypeId parentTypeId, @TitleJsonConverter()  Title name, @JsonKey(name: 'sub_types')  List<ProductType> subtypes,  List<Product> products)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductType() when $default != null:
return $default(_that.id,_that.parentTypeId,_that.name,_that.subtypes,_that.products);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@ProductTypeIdJsonConverter()  ProductTypeId id, @JsonKey(name: 'parent_type_id')@ProductTypeIdJsonConverter()  ProductTypeId parentTypeId, @TitleJsonConverter()  Title name, @JsonKey(name: 'sub_types')  List<ProductType> subtypes,  List<Product> products)  $default,) {final _that = this;
switch (_that) {
case _ProductType():
return $default(_that.id,_that.parentTypeId,_that.name,_that.subtypes,_that.products);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@ProductTypeIdJsonConverter()  ProductTypeId id, @JsonKey(name: 'parent_type_id')@ProductTypeIdJsonConverter()  ProductTypeId parentTypeId, @TitleJsonConverter()  Title name, @JsonKey(name: 'sub_types')  List<ProductType> subtypes,  List<Product> products)?  $default,) {final _that = this;
switch (_that) {
case _ProductType() when $default != null:
return $default(_that.id,_that.parentTypeId,_that.name,_that.subtypes,_that.products);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductType implements ProductType {
   _ProductType({@ProductTypeIdJsonConverter() required this.id, @JsonKey(name: 'parent_type_id')@ProductTypeIdJsonConverter() required this.parentTypeId, @TitleJsonConverter() required this.name, @JsonKey(name: 'sub_types') final  List<ProductType> subtypes = const [], final  List<Product> products = const []}): _subtypes = subtypes,_products = products;
  factory _ProductType.fromJson(Map<String, dynamic> json) => _$ProductTypeFromJson(json);

@override@ProductTypeIdJsonConverter() final  ProductTypeId id;
@override@JsonKey(name: 'parent_type_id')@ProductTypeIdJsonConverter() final  ProductTypeId parentTypeId;
@override@TitleJsonConverter() final  Title name;
 final  List<ProductType> _subtypes;
@override@JsonKey(name: 'sub_types') List<ProductType> get subtypes {
  if (_subtypes is EqualUnmodifiableListView) return _subtypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subtypes);
}

 final  List<Product> _products;
@override@JsonKey() List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}


/// Create a copy of ProductType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductTypeCopyWith<_ProductType> get copyWith => __$ProductTypeCopyWithImpl<_ProductType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductType&&(identical(other.id, id) || other.id == id)&&(identical(other.parentTypeId, parentTypeId) || other.parentTypeId == parentTypeId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._subtypes, _subtypes)&&const DeepCollectionEquality().equals(other._products, _products));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,parentTypeId,name,const DeepCollectionEquality().hash(_subtypes),const DeepCollectionEquality().hash(_products));

@override
String toString() {
  return 'ProductType(id: $id, parentTypeId: $parentTypeId, name: $name, subtypes: $subtypes, products: $products)';
}


}

/// @nodoc
abstract mixin class _$ProductTypeCopyWith<$Res> implements $ProductTypeCopyWith<$Res> {
  factory _$ProductTypeCopyWith(_ProductType value, $Res Function(_ProductType) _then) = __$ProductTypeCopyWithImpl;
@override @useResult
$Res call({
@ProductTypeIdJsonConverter() ProductTypeId id,@JsonKey(name: 'parent_type_id')@ProductTypeIdJsonConverter() ProductTypeId parentTypeId,@TitleJsonConverter() Title name,@JsonKey(name: 'sub_types') List<ProductType> subtypes, List<Product> products
});


@override $ProductTypeIdCopyWith<$Res> get id;@override $ProductTypeIdCopyWith<$Res> get parentTypeId;@override $TitleCopyWith<$Res> get name;

}
/// @nodoc
class __$ProductTypeCopyWithImpl<$Res>
    implements _$ProductTypeCopyWith<$Res> {
  __$ProductTypeCopyWithImpl(this._self, this._then);

  final _ProductType _self;
  final $Res Function(_ProductType) _then;

/// Create a copy of ProductType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? parentTypeId = null,Object? name = null,Object? subtypes = null,Object? products = null,}) {
  return _then(_ProductType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as ProductTypeId,parentTypeId: null == parentTypeId ? _self.parentTypeId : parentTypeId // ignore: cast_nullable_to_non_nullable
as ProductTypeId,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as Title,subtypes: null == subtypes ? _self._subtypes : subtypes // ignore: cast_nullable_to_non_nullable
as List<ProductType>,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}

/// Create a copy of ProductType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductTypeIdCopyWith<$Res> get id {
  
  return $ProductTypeIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of ProductType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductTypeIdCopyWith<$Res> get parentTypeId {
  
  return $ProductTypeIdCopyWith<$Res>(_self.parentTypeId, (value) {
    return _then(_self.copyWith(parentTypeId: value));
  });
}/// Create a copy of ProductType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get name {
  
  return $TitleCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}

// dart format on
