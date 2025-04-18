// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductTypeImpl _$$ProductTypeImplFromJson(Map<String, dynamic> json) =>
    _$ProductTypeImpl(
      id: const ProductTypeIdJsonConverter()
          .fromJson((json['id'] as num).toInt()),
      parentTypeId: const ProductTypeIdJsonConverter()
          .fromJson((json['parent_type_id'] as num).toInt()),
      name: const TitleJsonConverter().fromJson(json['name'] as String),
      subtypes: (json['sub_types'] as List<dynamic>?)
              ?.map(ProductType.fromJson)
              .toList() ??
          const [],
      products: (json['products'] as List<dynamic>?)
              ?.map(Product.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ProductTypeImplToJson(_$ProductTypeImpl instance) =>
    <String, dynamic>{
      'id': const ProductTypeIdJsonConverter().toJson(instance.id),
      'parent_type_id':
          const ProductTypeIdJsonConverter().toJson(instance.parentTypeId),
      'name': const TitleJsonConverter().toJson(instance.name),
      'sub_types': instance.subtypes,
      'products': instance.products,
    };
