// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Device _$DeviceFromJson(Map<String, dynamic> json) => _Device(
  id: const IdJsonConverter().fromJson((json['id'] as num?)?.toInt()),
  name: Name.fromJson(json['name'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DeviceToJson(_Device instance) => <String, dynamic>{
  'id': const IdJsonConverter().toJson(instance.id),
  'name': instance.name,
};
