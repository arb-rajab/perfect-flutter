// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Admin _$AdminFromJson(Map<String, dynamic> json) => _Admin(
  id: const IdJsonConverter().fromJson((json['id'] as num?)?.toInt()),
  username: const TitleJsonConverter().fromJson(json['username'] as String),
);

Map<String, dynamic> _$AdminToJson(_Admin instance) => <String, dynamic>{
  'id': const IdJsonConverter().toJson(instance.id),
  'username': const TitleJsonConverter().toJson(instance.username),
};
