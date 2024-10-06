// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      id: const IdJsonConverter().fromJson((json['id'] as num?)?.toInt()),
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': const IdJsonConverter().toJson(instance.id),
      'name': instance.name,
    };
