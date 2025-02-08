// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: const IdJsonConverter().fromJson((json['id'] as num?)?.toInt()),
      name: const TitleJsonConverter().fromJson(json['name'] as String),
      imageUrl: json['image_url'] as String,
      price:
          const PriceJsonConverter().fromJson((json['price'] as num).toInt()),
      description: _$JsonConverterFromJson<String, Description>(
          json['description'], const DescriptionJsonConverter().fromJson),
      createdAt: _$JsonConverterFromJson<String, DateTime>(
          json['created_at'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': const IdJsonConverter().toJson(instance.id),
      'name': const TitleJsonConverter().toJson(instance.name),
      'image_url': instance.imageUrl,
      'price': const PriceJsonConverter().toJson(instance.price),
      'description': _$JsonConverterToJson<String, Description>(
          instance.description, const DescriptionJsonConverter().toJson),
      'created_at': _$JsonConverterToJson<String, DateTime>(
          instance.createdAt, const DateTimeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
