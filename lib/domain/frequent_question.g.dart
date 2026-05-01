// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frequent_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FrequentQuestion _$FrequentQuestionFromJson(Map<String, dynamic> json) =>
    _FrequentQuestion(
      id: const IdJsonConverter().fromJson((json['id'] as num?)?.toInt()),
      title: const TitleJsonConverter().fromJson(json['title'] as String),
      description: const DescriptionJsonConverter().fromJson(
        json['description'] as String,
      ),
    );

Map<String, dynamic> _$FrequentQuestionToJson(
  _FrequentQuestion instance,
) => <String, dynamic>{
  'id': const IdJsonConverter().toJson(instance.id),
  'title': const TitleJsonConverter().toJson(instance.title),
  'description': const DescriptionJsonConverter().toJson(instance.description),
};
