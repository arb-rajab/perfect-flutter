// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermQuestion _$TermQuestionFromJson(Map<String, dynamic> json) => TermQuestion(
      id: const IdJsonConverter().fromJson((json['id'] as num?)?.toInt()),
      title: const TitleJsonConverter().fromJson(json['title'] as String),
      type: const TypeJsonConverter().fromJson((json['type'] as num).toInt()),
      multiSelections: (json['multi_selections'] as List<dynamic>)
          .map((e) => MultiSelectSelection.fromJson(e as Map<String, dynamic>))
          .toList(),
      answer: json['answer'] as String?,
    );

Map<String, dynamic> _$TermQuestionToJson(TermQuestion instance) =>
    <String, dynamic>{
      'id': const IdJsonConverter().toJson(instance.id),
      'title': const TitleJsonConverter().toJson(instance.title),
      'type': const TypeJsonConverter().toJson(instance.type),
      'multi_selections': instance.multiSelections,
      'answer': instance.answer,
    };
