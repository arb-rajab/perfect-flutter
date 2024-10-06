// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: const IdJsonConverter().fromJson((json['id'] as num?)?.toInt()),
      content: const TextJsonConverter().fromJson(json['content'] as String),
      device: json['device'] == null
          ? null
          : Device.fromJson(json['device'] as Map<String, dynamic>),
      admin: json['admin'] == null
          ? null
          : Admin.fromJson(json['admin'] as Map<String, dynamic>),
      numberOfComments: const NumberOfSubTermsJsonConverter()
          .fromJson((json['numberOfComments'] as num?)?.toInt()),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': const IdJsonConverter().toJson(instance.id),
      'content': const TextJsonConverter().toJson(instance.content),
      'device': instance.device,
      'admin': instance.admin,
      'numberOfComments': const NumberOfSubTermsJsonConverter()
          .toJson(instance.numberOfComments),
    };
