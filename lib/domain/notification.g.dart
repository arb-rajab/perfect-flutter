// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      id: const IdJsonConverter().fromJson(json['id'] as int?),
      title: const TitleJsonConverter().fromJson(json['title'] as String),
      text: const TextJsonConverter().fromJson(json['text'] as String),
      data: const DataJsonConverter().fromJson(json['data'] as String),
      seen: _$JsonConverterFromJson<int, bool>(
          json['seen'], const BooleanConverter().fromJson),
      creation: const DateTimeConverter().fromJson(json['creation'] as String),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': const IdJsonConverter().toJson(instance.id),
      'title': const TitleJsonConverter().toJson(instance.title),
      'text': const TextJsonConverter().toJson(instance.text),
      'data': const DataJsonConverter().toJson(instance.data),
      'seen': _$JsonConverterToJson<int, bool>(
          instance.seen, const BooleanConverter().toJson),
      'creation': const DateTimeConverter().toJson(instance.creation),
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
