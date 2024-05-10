// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponType _$CouponTypeFromJson(Map<String, dynamic> json) => CouponType(
      id: const IdJsonConverter().fromJson(json['id'] as int?),
      layer: const LayerJsonConverter().fromJson(json['layer'] as int),
      rootTermId:
          const RootTermIdJsonConverter().fromJson(json['rootTermId'] as int),
      numberOfObjects: const NumberOfObjectsJsonConverter()
          .fromJson(json['numberOfObjects'] as int),
    );

Map<String, dynamic> _$CouponTypeToJson(CouponType instance) =>
    <String, dynamic>{
      'id': const IdJsonConverter().toJson(instance.id),
      'layer': const LayerJsonConverter().toJson(instance.layer),
      'rootTermId': const RootTermIdJsonConverter().toJson(instance.rootTermId),
      'numberOfObjects':
          const NumberOfObjectsJsonConverter().toJson(instance.numberOfObjects),
    };
