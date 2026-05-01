// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_News _$NewsFromJson(Map<String, dynamic> json) => _News(
  id: const IdJsonConverter().fromJson((json['id'] as num?)?.toInt()),
  title: const TitleJsonConverter().fromJson(json['title'] as String),
  content: const DescriptionJsonConverter().fromJson(json['content'] as String),
  createdAt: const DateTimeConverter().fromJson(json['created_at'] as String),
);

Map<String, dynamic> _$NewsToJson(_News instance) => <String, dynamic>{
  'id': const IdJsonConverter().toJson(instance.id),
  'title': const TitleJsonConverter().toJson(instance.title),
  'content': const DescriptionJsonConverter().toJson(instance.content),
  'created_at': const DateTimeConverter().toJson(instance.createdAt),
};
