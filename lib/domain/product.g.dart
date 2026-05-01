// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: const IdJsonConverter().fromJson((json['id'] as num?)?.toInt()),
  name: const TitleJsonConverter().fromJson(json['name'] as String),
  imageUrl: json['image_url'] as String,
  price: const PriceJsonConverter().fromJson((json['price'] as num?)?.toInt()),
  offerPrice: const PriceJsonConverter().fromJson(
    (json['offer_price'] as num?)?.toInt(),
  ),
  singlePrice: const PriceJsonConverter().fromJson(
    (json['single_price'] as num?)?.toInt(),
  ),
  unit: const UnitJsonConverter().fromJson((json['unit'] as num).toInt()),
  descriptionRtl: _$JsonConverterFromJson<String, Description>(
    json['description_rtl'],
    const DescriptionJsonConverter().fromJson,
  ),
  descriptionLtr: _$JsonConverterFromJson<String, Description>(
    json['description_ltr'],
    const DescriptionJsonConverter().fromJson,
  ),
  createdAt: _$JsonConverterFromJson<String, DateTime>(
    json['created_at'],
    const DateTimeConverter().fromJson,
  ),
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': const IdJsonConverter().toJson(instance.id),
  'name': const TitleJsonConverter().toJson(instance.name),
  'image_url': instance.imageUrl,
  'price': const PriceJsonConverter().toJson(instance.price),
  'offer_price': const PriceJsonConverter().toJson(instance.offerPrice),
  'single_price': const PriceJsonConverter().toJson(instance.singlePrice),
  'unit': const UnitJsonConverter().toJson(instance.unit),
  'description_rtl': _$JsonConverterToJson<String, Description>(
    instance.descriptionRtl,
    const DescriptionJsonConverter().toJson,
  ),
  'description_ltr': _$JsonConverterToJson<String, Description>(
    instance.descriptionLtr,
    const DescriptionJsonConverter().toJson,
  ),
  'created_at': _$JsonConverterToJson<String, DateTime>(
    instance.createdAt,
    const DateTimeConverter().toJson,
  ),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
