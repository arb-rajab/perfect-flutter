// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  @IdJsonConverter()
  Id get id => throw _privateConstructorUsedError;
  @TitleJsonConverter()
  Title get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @PriceJsonConverter()
  Price get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'offer_price')
  @PriceJsonConverter()
  Price get offerPrice => throw _privateConstructorUsedError;
  @UnitJsonConverter()
  Unit get unit => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_rtl')
  @DescriptionJsonConverter()
  Description? get descriptionRtl => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_ltr')
  @DescriptionJsonConverter()
  Description? get descriptionLtr => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  @DateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? get images => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {@IdJsonConverter() Id id,
      @TitleJsonConverter() Title name,
      @JsonKey(name: 'image_url') String imageUrl,
      @PriceJsonConverter() Price price,
      @JsonKey(name: 'offer_price') @PriceJsonConverter() Price offerPrice,
      @UnitJsonConverter() Unit unit,
      @JsonKey(name: 'description_rtl')
      @DescriptionJsonConverter()
      Description? descriptionRtl,
      @JsonKey(name: 'description_ltr')
      @DescriptionJsonConverter()
      Description? descriptionLtr,
      @JsonKey(name: 'created_at') @DateTimeConverter() DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<String>? images});

  $IdCopyWith<$Res> get id;
  $TitleCopyWith<$Res> get name;
  $PriceCopyWith<$Res> get price;
  $PriceCopyWith<$Res> get offerPrice;
  $UnitCopyWith<$Res> get unit;
  $DescriptionCopyWith<$Res>? get descriptionRtl;
  $DescriptionCopyWith<$Res>? get descriptionLtr;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? price = null,
    Object? offerPrice = null,
    Object? unit = null,
    Object? descriptionRtl = freezed,
    Object? descriptionLtr = freezed,
    Object? createdAt = freezed,
    Object? images = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Id,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Title,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as Price,
      offerPrice: null == offerPrice
          ? _value.offerPrice
          : offerPrice // ignore: cast_nullable_to_non_nullable
              as Price,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as Unit,
      descriptionRtl: freezed == descriptionRtl
          ? _value.descriptionRtl
          : descriptionRtl // ignore: cast_nullable_to_non_nullable
              as Description?,
      descriptionLtr: freezed == descriptionLtr
          ? _value.descriptionLtr
          : descriptionLtr // ignore: cast_nullable_to_non_nullable
              as Description?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IdCopyWith<$Res> get id {
    return $IdCopyWith<$Res>(_value.id, (value) {
      return _then(_value.copyWith(id: value) as $Val);
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TitleCopyWith<$Res> get name {
    return $TitleCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceCopyWith<$Res> get price {
    return $PriceCopyWith<$Res>(_value.price, (value) {
      return _then(_value.copyWith(price: value) as $Val);
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceCopyWith<$Res> get offerPrice {
    return $PriceCopyWith<$Res>(_value.offerPrice, (value) {
      return _then(_value.copyWith(offerPrice: value) as $Val);
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UnitCopyWith<$Res> get unit {
    return $UnitCopyWith<$Res>(_value.unit, (value) {
      return _then(_value.copyWith(unit: value) as $Val);
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DescriptionCopyWith<$Res>? get descriptionRtl {
    if (_value.descriptionRtl == null) {
      return null;
    }

    return $DescriptionCopyWith<$Res>(_value.descriptionRtl!, (value) {
      return _then(_value.copyWith(descriptionRtl: value) as $Val);
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DescriptionCopyWith<$Res>? get descriptionLtr {
    if (_value.descriptionLtr == null) {
      return null;
    }

    return $DescriptionCopyWith<$Res>(_value.descriptionLtr!, (value) {
      return _then(_value.copyWith(descriptionLtr: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IdJsonConverter() Id id,
      @TitleJsonConverter() Title name,
      @JsonKey(name: 'image_url') String imageUrl,
      @PriceJsonConverter() Price price,
      @JsonKey(name: 'offer_price') @PriceJsonConverter() Price offerPrice,
      @UnitJsonConverter() Unit unit,
      @JsonKey(name: 'description_rtl')
      @DescriptionJsonConverter()
      Description? descriptionRtl,
      @JsonKey(name: 'description_ltr')
      @DescriptionJsonConverter()
      Description? descriptionLtr,
      @JsonKey(name: 'created_at') @DateTimeConverter() DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<String>? images});

  @override
  $IdCopyWith<$Res> get id;
  @override
  $TitleCopyWith<$Res> get name;
  @override
  $PriceCopyWith<$Res> get price;
  @override
  $PriceCopyWith<$Res> get offerPrice;
  @override
  $UnitCopyWith<$Res> get unit;
  @override
  $DescriptionCopyWith<$Res>? get descriptionRtl;
  @override
  $DescriptionCopyWith<$Res>? get descriptionLtr;
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? price = null,
    Object? offerPrice = null,
    Object? unit = null,
    Object? descriptionRtl = freezed,
    Object? descriptionLtr = freezed,
    Object? createdAt = freezed,
    Object? images = freezed,
  }) {
    return _then(_$ProductImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Id,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Title,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as Price,
      offerPrice: null == offerPrice
          ? _value.offerPrice
          : offerPrice // ignore: cast_nullable_to_non_nullable
              as Price,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as Unit,
      descriptionRtl: freezed == descriptionRtl
          ? _value.descriptionRtl
          : descriptionRtl // ignore: cast_nullable_to_non_nullable
              as Description?,
      descriptionLtr: freezed == descriptionLtr
          ? _value.descriptionLtr
          : descriptionLtr // ignore: cast_nullable_to_non_nullable
              as Description?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  _$ProductImpl(
      {@IdJsonConverter() required this.id,
      @TitleJsonConverter() required this.name,
      @JsonKey(name: 'image_url') required this.imageUrl,
      @PriceJsonConverter() required this.price,
      @JsonKey(name: 'offer_price')
      @PriceJsonConverter()
      required this.offerPrice,
      @UnitJsonConverter() required this.unit,
      @JsonKey(name: 'description_rtl')
      @DescriptionJsonConverter()
      this.descriptionRtl,
      @JsonKey(name: 'description_ltr')
      @DescriptionJsonConverter()
      this.descriptionLtr,
      @JsonKey(name: 'created_at') @DateTimeConverter() this.createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<String>? images})
      : _images = images;

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  @IdJsonConverter()
  final Id id;
  @override
  @TitleJsonConverter()
  final Title name;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @PriceJsonConverter()
  final Price price;
  @override
  @JsonKey(name: 'offer_price')
  @PriceJsonConverter()
  final Price offerPrice;
  @override
  @UnitJsonConverter()
  final Unit unit;
  @override
  @JsonKey(name: 'description_rtl')
  @DescriptionJsonConverter()
  final Description? descriptionRtl;
  @override
  @JsonKey(name: 'description_ltr')
  @DescriptionJsonConverter()
  final Description? descriptionLtr;
  @override
  @JsonKey(name: 'created_at')
  @DateTimeConverter()
  final DateTime? createdAt;
  final List<String>? _images;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, imageUrl: $imageUrl, price: $price, offerPrice: $offerPrice, unit: $unit, descriptionRtl: $descriptionRtl, descriptionLtr: $descriptionLtr, createdAt: $createdAt, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.offerPrice, offerPrice) ||
                other.offerPrice == offerPrice) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.descriptionRtl, descriptionRtl) ||
                other.descriptionRtl == descriptionRtl) &&
            (identical(other.descriptionLtr, descriptionLtr) ||
                other.descriptionLtr == descriptionLtr) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      imageUrl,
      price,
      offerPrice,
      unit,
      descriptionRtl,
      descriptionLtr,
      createdAt,
      const DeepCollectionEquality().hash(_images));

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  factory _Product(
      {@IdJsonConverter() required final Id id,
      @TitleJsonConverter() required final Title name,
      @JsonKey(name: 'image_url') required final String imageUrl,
      @PriceJsonConverter() required final Price price,
      @JsonKey(name: 'offer_price')
      @PriceJsonConverter()
      required final Price offerPrice,
      @UnitJsonConverter() required final Unit unit,
      @JsonKey(name: 'description_rtl')
      @DescriptionJsonConverter()
      final Description? descriptionRtl,
      @JsonKey(name: 'description_ltr')
      @DescriptionJsonConverter()
      final Description? descriptionLtr,
      @JsonKey(name: 'created_at')
      @DateTimeConverter()
      final DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<String>? images}) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  @IdJsonConverter()
  Id get id;
  @override
  @TitleJsonConverter()
  Title get name;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @PriceJsonConverter()
  Price get price;
  @override
  @JsonKey(name: 'offer_price')
  @PriceJsonConverter()
  Price get offerPrice;
  @override
  @UnitJsonConverter()
  Unit get unit;
  @override
  @JsonKey(name: 'description_rtl')
  @DescriptionJsonConverter()
  Description? get descriptionRtl;
  @override
  @JsonKey(name: 'description_ltr')
  @DescriptionJsonConverter()
  Description? get descriptionLtr;
  @override
  @JsonKey(name: 'created_at')
  @DateTimeConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? get images;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
