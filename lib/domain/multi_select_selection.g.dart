// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_select_selection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MultiSelectSelection _$MultiSelectSelectionFromJson(
  Map<String, dynamic> json,
) => _MultiSelectSelection(
  id: const IdJsonConverter().fromJson((json['id'] as num?)?.toInt()),
  title: const TitleJsonConverter().fromJson(json['title'] as String),
);

Map<String, dynamic> _$MultiSelectSelectionToJson(
  _MultiSelectSelection instance,
) => <String, dynamic>{
  'id': const IdJsonConverter().toJson(instance.id),
  'title': const TitleJsonConverter().toJson(instance.title),
};
