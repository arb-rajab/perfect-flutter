// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_select_selection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiSelectSelection _$MultiSelectSelectionFromJson(
        Map<String, dynamic> json) =>
    MultiSelectSelection(
      id: const IdJsonConverter().fromJson(json['id'] as int?),
      title: const TitleJsonConverter().fromJson(json['title'] as String),
    );

Map<String, dynamic> _$MultiSelectSelectionToJson(
        MultiSelectSelection instance) =>
    <String, dynamic>{
      'id': const IdJsonConverter().toJson(instance.id),
      'title': const TitleJsonConverter().toJson(instance.title),
    };
