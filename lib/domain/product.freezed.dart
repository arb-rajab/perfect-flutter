// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Product {

@IdJsonConverter() Id get id;@TitleJsonConverter() Title get name;@JsonKey(name: 'image_url') String get imageUrl;@PriceJsonConverter() Price get price;@JsonKey(name: 'offer_price')@PriceJsonConverter() Price get offerPrice;@JsonKey(name: 'single_price')@PriceJsonConverter() Price get singlePrice;@UnitJsonConverter() Unit get unit;@JsonKey(name: 'description_rtl')@DescriptionJsonConverter() Description? get descriptionRtl;@JsonKey(name: 'description_ltr')@DescriptionJsonConverter() Description? get descriptionLtr;@JsonKey(name: 'created_at')@DateTimeConverter() DateTime? get createdAt;@JsonKey(includeFromJson: false, includeToJson: false) List<String>? get images;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.price, price) || other.price == price)&&(identical(other.offerPrice, offerPrice) || other.offerPrice == offerPrice)&&(identical(other.singlePrice, singlePrice) || other.singlePrice == singlePrice)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.descriptionRtl, descriptionRtl) || other.descriptionRtl == descriptionRtl)&&(identical(other.descriptionLtr, descriptionLtr) || other.descriptionLtr == descriptionLtr)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.images, images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl,price,offerPrice,singlePrice,unit,descriptionRtl,descriptionLtr,createdAt,const DeepCollectionEquality().hash(images));

@override
String toString() {
  return 'Product(id: $id, name: $name, imageUrl: $imageUrl, price: $price, offerPrice: $offerPrice, singlePrice: $singlePrice, unit: $unit, descriptionRtl: $descriptionRtl, descriptionLtr: $descriptionLtr, createdAt: $createdAt, images: $images)';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title name,@JsonKey(name: 'image_url') String imageUrl,@PriceJsonConverter() Price price,@JsonKey(name: 'offer_price')@PriceJsonConverter() Price offerPrice,@JsonKey(name: 'single_price')@PriceJsonConverter() Price singlePrice,@UnitJsonConverter() Unit unit,@JsonKey(name: 'description_rtl')@DescriptionJsonConverter() Description? descriptionRtl,@JsonKey(name: 'description_ltr')@DescriptionJsonConverter() Description? descriptionLtr,@JsonKey(name: 'created_at')@DateTimeConverter() DateTime? createdAt,@JsonKey(includeFromJson: false, includeToJson: false) List<String>? images
});


$IdCopyWith<$Res> get id;$TitleCopyWith<$Res> get name;$PriceCopyWith<$Res> get price;$PriceCopyWith<$Res> get offerPrice;$PriceCopyWith<$Res> get singlePrice;$UnitCopyWith<$Res> get unit;$DescriptionCopyWith<$Res>? get descriptionRtl;$DescriptionCopyWith<$Res>? get descriptionLtr;

}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? price = null,Object? offerPrice = null,Object? singlePrice = null,Object? unit = null,Object? descriptionRtl = freezed,Object? descriptionLtr = freezed,Object? createdAt = freezed,Object? images = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as Title,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Price,offerPrice: null == offerPrice ? _self.offerPrice : offerPrice // ignore: cast_nullable_to_non_nullable
as Price,singlePrice: null == singlePrice ? _self.singlePrice : singlePrice // ignore: cast_nullable_to_non_nullable
as Price,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as Unit,descriptionRtl: freezed == descriptionRtl ? _self.descriptionRtl : descriptionRtl // ignore: cast_nullable_to_non_nullable
as Description?,descriptionLtr: freezed == descriptionLtr ? _self.descriptionLtr : descriptionLtr // ignore: cast_nullable_to_non_nullable
as Description?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get name {
  
  return $TitleCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceCopyWith<$Res> get price {
  
  return $PriceCopyWith<$Res>(_self.price, (value) {
    return _then(_self.copyWith(price: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceCopyWith<$Res> get offerPrice {
  
  return $PriceCopyWith<$Res>(_self.offerPrice, (value) {
    return _then(_self.copyWith(offerPrice: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceCopyWith<$Res> get singlePrice {
  
  return $PriceCopyWith<$Res>(_self.singlePrice, (value) {
    return _then(_self.copyWith(singlePrice: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitCopyWith<$Res> get unit {
  
  return $UnitCopyWith<$Res>(_self.unit, (value) {
    return _then(_self.copyWith(unit: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DescriptionCopyWith<$Res>? get descriptionRtl {
    if (_self.descriptionRtl == null) {
    return null;
  }

  return $DescriptionCopyWith<$Res>(_self.descriptionRtl!, (value) {
    return _then(_self.copyWith(descriptionRtl: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DescriptionCopyWith<$Res>? get descriptionLtr {
    if (_self.descriptionLtr == null) {
    return null;
  }

  return $DescriptionCopyWith<$Res>(_self.descriptionLtr!, (value) {
    return _then(_self.copyWith(descriptionLtr: value));
  });
}
}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title name, @JsonKey(name: 'image_url')  String imageUrl, @PriceJsonConverter()  Price price, @JsonKey(name: 'offer_price')@PriceJsonConverter()  Price offerPrice, @JsonKey(name: 'single_price')@PriceJsonConverter()  Price singlePrice, @UnitJsonConverter()  Unit unit, @JsonKey(name: 'description_rtl')@DescriptionJsonConverter()  Description? descriptionRtl, @JsonKey(name: 'description_ltr')@DescriptionJsonConverter()  Description? descriptionLtr, @JsonKey(name: 'created_at')@DateTimeConverter()  DateTime? createdAt, @JsonKey(includeFromJson: false, includeToJson: false)  List<String>? images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.price,_that.offerPrice,_that.singlePrice,_that.unit,_that.descriptionRtl,_that.descriptionLtr,_that.createdAt,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title name, @JsonKey(name: 'image_url')  String imageUrl, @PriceJsonConverter()  Price price, @JsonKey(name: 'offer_price')@PriceJsonConverter()  Price offerPrice, @JsonKey(name: 'single_price')@PriceJsonConverter()  Price singlePrice, @UnitJsonConverter()  Unit unit, @JsonKey(name: 'description_rtl')@DescriptionJsonConverter()  Description? descriptionRtl, @JsonKey(name: 'description_ltr')@DescriptionJsonConverter()  Description? descriptionLtr, @JsonKey(name: 'created_at')@DateTimeConverter()  DateTime? createdAt, @JsonKey(includeFromJson: false, includeToJson: false)  List<String>? images)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.name,_that.imageUrl,_that.price,_that.offerPrice,_that.singlePrice,_that.unit,_that.descriptionRtl,_that.descriptionLtr,_that.createdAt,_that.images);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title name, @JsonKey(name: 'image_url')  String imageUrl, @PriceJsonConverter()  Price price, @JsonKey(name: 'offer_price')@PriceJsonConverter()  Price offerPrice, @JsonKey(name: 'single_price')@PriceJsonConverter()  Price singlePrice, @UnitJsonConverter()  Unit unit, @JsonKey(name: 'description_rtl')@DescriptionJsonConverter()  Description? descriptionRtl, @JsonKey(name: 'description_ltr')@DescriptionJsonConverter()  Description? descriptionLtr, @JsonKey(name: 'created_at')@DateTimeConverter()  DateTime? createdAt, @JsonKey(includeFromJson: false, includeToJson: false)  List<String>? images)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.price,_that.offerPrice,_that.singlePrice,_that.unit,_that.descriptionRtl,_that.descriptionLtr,_that.createdAt,_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Product implements Product {
   _Product({@IdJsonConverter() required this.id, @TitleJsonConverter() required this.name, @JsonKey(name: 'image_url') required this.imageUrl, @PriceJsonConverter() required this.price, @JsonKey(name: 'offer_price')@PriceJsonConverter() required this.offerPrice, @JsonKey(name: 'single_price')@PriceJsonConverter() required this.singlePrice, @UnitJsonConverter() required this.unit, @JsonKey(name: 'description_rtl')@DescriptionJsonConverter() this.descriptionRtl, @JsonKey(name: 'description_ltr')@DescriptionJsonConverter() this.descriptionLtr, @JsonKey(name: 'created_at')@DateTimeConverter() this.createdAt, @JsonKey(includeFromJson: false, includeToJson: false) final  List<String>? images}): _images = images;
  factory _Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

@override@IdJsonConverter() final  Id id;
@override@TitleJsonConverter() final  Title name;
@override@JsonKey(name: 'image_url') final  String imageUrl;
@override@PriceJsonConverter() final  Price price;
@override@JsonKey(name: 'offer_price')@PriceJsonConverter() final  Price offerPrice;
@override@JsonKey(name: 'single_price')@PriceJsonConverter() final  Price singlePrice;
@override@UnitJsonConverter() final  Unit unit;
@override@JsonKey(name: 'description_rtl')@DescriptionJsonConverter() final  Description? descriptionRtl;
@override@JsonKey(name: 'description_ltr')@DescriptionJsonConverter() final  Description? descriptionLtr;
@override@JsonKey(name: 'created_at')@DateTimeConverter() final  DateTime? createdAt;
 final  List<String>? _images;
@override@JsonKey(includeFromJson: false, includeToJson: false) List<String>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.price, price) || other.price == price)&&(identical(other.offerPrice, offerPrice) || other.offerPrice == offerPrice)&&(identical(other.singlePrice, singlePrice) || other.singlePrice == singlePrice)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.descriptionRtl, descriptionRtl) || other.descriptionRtl == descriptionRtl)&&(identical(other.descriptionLtr, descriptionLtr) || other.descriptionLtr == descriptionLtr)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl,price,offerPrice,singlePrice,unit,descriptionRtl,descriptionLtr,createdAt,const DeepCollectionEquality().hash(_images));

@override
String toString() {
  return 'Product(id: $id, name: $name, imageUrl: $imageUrl, price: $price, offerPrice: $offerPrice, singlePrice: $singlePrice, unit: $unit, descriptionRtl: $descriptionRtl, descriptionLtr: $descriptionLtr, createdAt: $createdAt, images: $images)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title name,@JsonKey(name: 'image_url') String imageUrl,@PriceJsonConverter() Price price,@JsonKey(name: 'offer_price')@PriceJsonConverter() Price offerPrice,@JsonKey(name: 'single_price')@PriceJsonConverter() Price singlePrice,@UnitJsonConverter() Unit unit,@JsonKey(name: 'description_rtl')@DescriptionJsonConverter() Description? descriptionRtl,@JsonKey(name: 'description_ltr')@DescriptionJsonConverter() Description? descriptionLtr,@JsonKey(name: 'created_at')@DateTimeConverter() DateTime? createdAt,@JsonKey(includeFromJson: false, includeToJson: false) List<String>? images
});


@override $IdCopyWith<$Res> get id;@override $TitleCopyWith<$Res> get name;@override $PriceCopyWith<$Res> get price;@override $PriceCopyWith<$Res> get offerPrice;@override $PriceCopyWith<$Res> get singlePrice;@override $UnitCopyWith<$Res> get unit;@override $DescriptionCopyWith<$Res>? get descriptionRtl;@override $DescriptionCopyWith<$Res>? get descriptionLtr;

}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? price = null,Object? offerPrice = null,Object? singlePrice = null,Object? unit = null,Object? descriptionRtl = freezed,Object? descriptionLtr = freezed,Object? createdAt = freezed,Object? images = freezed,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as Title,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Price,offerPrice: null == offerPrice ? _self.offerPrice : offerPrice // ignore: cast_nullable_to_non_nullable
as Price,singlePrice: null == singlePrice ? _self.singlePrice : singlePrice // ignore: cast_nullable_to_non_nullable
as Price,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as Unit,descriptionRtl: freezed == descriptionRtl ? _self.descriptionRtl : descriptionRtl // ignore: cast_nullable_to_non_nullable
as Description?,descriptionLtr: freezed == descriptionLtr ? _self.descriptionLtr : descriptionLtr // ignore: cast_nullable_to_non_nullable
as Description?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get name {
  
  return $TitleCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceCopyWith<$Res> get price {
  
  return $PriceCopyWith<$Res>(_self.price, (value) {
    return _then(_self.copyWith(price: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceCopyWith<$Res> get offerPrice {
  
  return $PriceCopyWith<$Res>(_self.offerPrice, (value) {
    return _then(_self.copyWith(offerPrice: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceCopyWith<$Res> get singlePrice {
  
  return $PriceCopyWith<$Res>(_self.singlePrice, (value) {
    return _then(_self.copyWith(singlePrice: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitCopyWith<$Res> get unit {
  
  return $UnitCopyWith<$Res>(_self.unit, (value) {
    return _then(_self.copyWith(unit: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DescriptionCopyWith<$Res>? get descriptionRtl {
    if (_self.descriptionRtl == null) {
    return null;
  }

  return $DescriptionCopyWith<$Res>(_self.descriptionRtl!, (value) {
    return _then(_self.copyWith(descriptionRtl: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DescriptionCopyWith<$Res>? get descriptionLtr {
    if (_self.descriptionLtr == null) {
    return null;
  }

  return $DescriptionCopyWith<$Res>(_self.descriptionLtr!, (value) {
    return _then(_self.copyWith(descriptionLtr: value));
  });
}
}

// dart format on
