// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_type_serializable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductTypeSerializable _$ProductTypeSerializableFromJson(
        Map<String, dynamic> json) =>
    ProductTypeSerializable(
      id: const ProductTypeIdJsonConverter()
          .fromJson((json['id'] as num).toInt()),
      parentTypeId: const ProductTypeIdJsonConverter()
          .fromJson((json['parent_type_id'] as num).toInt()),
      name: const TitleJsonConverter().fromJson(json['name'] as String),
      subtypes: (json['sub_types'] as List<dynamic>?)
              ?.map((e) =>
                  ProductTypeSerializable.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      products: (json['products'] as List<dynamic>?)
              ?.map(Product.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProductTypeSerializableToJson(
        ProductTypeSerializable instance) =>
    <String, dynamic>{
      'id': const ProductTypeIdJsonConverter().toJson(instance.id),
      'parent_type_id':
          const ProductTypeIdJsonConverter().toJson(instance.parentTypeId),
      'name': const TitleJsonConverter().toJson(instance.name),
      'sub_types': instance.subtypes,
      'products': instance.products,
    };
