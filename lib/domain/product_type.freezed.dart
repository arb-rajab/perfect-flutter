// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductType _$ProductTypeFromJson(Map<String, dynamic> json) {
  return _ProductType.fromJson(json);
}

/// @nodoc
mixin _$ProductType {
  @ProductTypeIdJsonConverter()
  ProductTypeId get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_type_id')
  @ProductTypeIdJsonConverter()
  ProductTypeId get parentTypeId => throw _privateConstructorUsedError;
  @TitleJsonConverter()
  Title get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_types')
  List<ProductType> get subtypes => throw _privateConstructorUsedError;
  List<Product> get products => throw _privateConstructorUsedError;

  /// Serializes this ProductType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductTypeCopyWith<ProductType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductTypeCopyWith<$Res> {
  factory $ProductTypeCopyWith(
          ProductType value, $Res Function(ProductType) then) =
      _$ProductTypeCopyWithImpl<$Res, ProductType>;
  @useResult
  $Res call(
      {@ProductTypeIdJsonConverter() ProductTypeId id,
      @JsonKey(name: 'parent_type_id')
      @ProductTypeIdJsonConverter()
      ProductTypeId parentTypeId,
      @TitleJsonConverter() Title name,
      @JsonKey(name: 'sub_types') List<ProductType> subtypes,
      List<Product> products});

  $ProductTypeIdCopyWith<$Res> get id;
  $ProductTypeIdCopyWith<$Res> get parentTypeId;
  $TitleCopyWith<$Res> get name;
}

/// @nodoc
class _$ProductTypeCopyWithImpl<$Res, $Val extends ProductType>
    implements $ProductTypeCopyWith<$Res> {
  _$ProductTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentTypeId = null,
    Object? name = null,
    Object? subtypes = null,
    Object? products = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as ProductTypeId,
      parentTypeId: null == parentTypeId
          ? _value.parentTypeId
          : parentTypeId // ignore: cast_nullable_to_non_nullable
              as ProductTypeId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Title,
      subtypes: null == subtypes
          ? _value.subtypes
          : subtypes // ignore: cast_nullable_to_non_nullable
              as List<ProductType>,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
    ) as $Val);
  }

  /// Create a copy of ProductType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductTypeIdCopyWith<$Res> get id {
    return $ProductTypeIdCopyWith<$Res>(_value.id, (value) {
      return _then(_value.copyWith(id: value) as $Val);
    });
  }

  /// Create a copy of ProductType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductTypeIdCopyWith<$Res> get parentTypeId {
    return $ProductTypeIdCopyWith<$Res>(_value.parentTypeId, (value) {
      return _then(_value.copyWith(parentTypeId: value) as $Val);
    });
  }

  /// Create a copy of ProductType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TitleCopyWith<$Res> get name {
    return $TitleCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductTypeImplCopyWith<$Res>
    implements $ProductTypeCopyWith<$Res> {
  factory _$$ProductTypeImplCopyWith(
          _$ProductTypeImpl value, $Res Function(_$ProductTypeImpl) then) =
      __$$ProductTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ProductTypeIdJsonConverter() ProductTypeId id,
      @JsonKey(name: 'parent_type_id')
      @ProductTypeIdJsonConverter()
      ProductTypeId parentTypeId,
      @TitleJsonConverter() Title name,
      @JsonKey(name: 'sub_types') List<ProductType> subtypes,
      List<Product> products});

  @override
  $ProductTypeIdCopyWith<$Res> get id;
  @override
  $ProductTypeIdCopyWith<$Res> get parentTypeId;
  @override
  $TitleCopyWith<$Res> get name;
}

/// @nodoc
class __$$ProductTypeImplCopyWithImpl<$Res>
    extends _$ProductTypeCopyWithImpl<$Res, _$ProductTypeImpl>
    implements _$$ProductTypeImplCopyWith<$Res> {
  __$$ProductTypeImplCopyWithImpl(
      _$ProductTypeImpl _value, $Res Function(_$ProductTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentTypeId = null,
    Object? name = null,
    Object? subtypes = null,
    Object? products = null,
  }) {
    return _then(_$ProductTypeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as ProductTypeId,
      parentTypeId: null == parentTypeId
          ? _value.parentTypeId
          : parentTypeId // ignore: cast_nullable_to_non_nullable
              as ProductTypeId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Title,
      subtypes: null == subtypes
          ? _value._subtypes
          : subtypes // ignore: cast_nullable_to_non_nullable
              as List<ProductType>,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductTypeImpl implements _ProductType {
  _$ProductTypeImpl(
      {@ProductTypeIdJsonConverter() required this.id,
      @JsonKey(name: 'parent_type_id')
      @ProductTypeIdJsonConverter()
      required this.parentTypeId,
      @TitleJsonConverter() required this.name,
      @JsonKey(name: 'sub_types') final List<ProductType> subtypes = const [],
      final List<Product> products = const []})
      : _subtypes = subtypes,
        _products = products;

  factory _$ProductTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductTypeImplFromJson(json);

  @override
  @ProductTypeIdJsonConverter()
  final ProductTypeId id;
  @override
  @JsonKey(name: 'parent_type_id')
  @ProductTypeIdJsonConverter()
  final ProductTypeId parentTypeId;
  @override
  @TitleJsonConverter()
  final Title name;
  final List<ProductType> _subtypes;
  @override
  @JsonKey(name: 'sub_types')
  List<ProductType> get subtypes {
    if (_subtypes is EqualUnmodifiableListView) return _subtypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subtypes);
  }

  final List<Product> _products;
  @override
  @JsonKey()
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'ProductType(id: $id, parentTypeId: $parentTypeId, name: $name, subtypes: $subtypes, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentTypeId, parentTypeId) ||
                other.parentTypeId == parentTypeId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._subtypes, _subtypes) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      parentTypeId,
      name,
      const DeepCollectionEquality().hash(_subtypes),
      const DeepCollectionEquality().hash(_products));

  /// Create a copy of ProductType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductTypeImplCopyWith<_$ProductTypeImpl> get copyWith =>
      __$$ProductTypeImplCopyWithImpl<_$ProductTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductTypeImplToJson(
      this,
    );
  }
}

abstract class _ProductType implements ProductType {
  factory _ProductType(
      {@ProductTypeIdJsonConverter() required final ProductTypeId id,
      @JsonKey(name: 'parent_type_id')
      @ProductTypeIdJsonConverter()
      required final ProductTypeId parentTypeId,
      @TitleJsonConverter() required final Title name,
      @JsonKey(name: 'sub_types') final List<ProductType> subtypes,
      final List<Product> products}) = _$ProductTypeImpl;

  factory _ProductType.fromJson(Map<String, dynamic> json) =
      _$ProductTypeImpl.fromJson;

  @override
  @ProductTypeIdJsonConverter()
  ProductTypeId get id;
  @override
  @JsonKey(name: 'parent_type_id')
  @ProductTypeIdJsonConverter()
  ProductTypeId get parentTypeId;
  @override
  @TitleJsonConverter()
  Title get name;
  @override
  @JsonKey(name: 'sub_types')
  List<ProductType> get subtypes;
  @override
  List<Product> get products;

  /// Create a copy of ProductType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductTypeImplCopyWith<_$ProductTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
