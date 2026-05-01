// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
  id: const IdJsonConverter().fromJson((json['id'] as num?)?.toInt()),
  content: const TextJsonConverter().fromJson(json['content'] as String),
  device: json['device'] == null
      ? null
      : Device.fromJson(json['device'] as Map<String, dynamic>),
  admin: _$JsonConverterFromJson<Map<String, dynamic>, Admin>(
    json['admin'],
    const AdminJsonConverter().fromJson,
  ),
  numberOfComments: const NumberOfSubTermsJsonConverter().fromJson(
    (json['numberOfComments'] as num?)?.toInt(),
  ),
);

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'id': const IdJsonConverter().toJson(instance.id),
  'content': const TextJsonConverter().toJson(instance.content),
  'device': instance.device,
  'admin': _$JsonConverterToJson<Map<String, dynamic>, Admin>(
    instance.admin,
    const AdminJsonConverter().toJson,
  ),
  'numberOfComments': const NumberOfSubTermsJsonConverter().toJson(
    instance.numberOfComments,
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
