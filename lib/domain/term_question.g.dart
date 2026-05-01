// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TermQuestion _$TermQuestionFromJson(Map<String, dynamic> json) =>
    _TermQuestion(
      id: const IdJsonConverter().fromJson((json['id'] as num?)?.toInt()),
      title: const TitleJsonConverter().fromJson(json['title'] as String),
      type: const TypeJsonConverter().fromJson((json['type'] as num).toInt()),
      multiSelections: (json['multi_selections'] as List<dynamic>)
          .map(
            (e) => const MultiSelectSelectionJsonConverter().fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      answer: json['answer'] as String?,
    );

Map<String, dynamic> _$TermQuestionToJson(_TermQuestion instance) =>
    <String, dynamic>{
      'id': const IdJsonConverter().toJson(instance.id),
      'title': const TitleJsonConverter().toJson(instance.title),
      'type': const TypeJsonConverter().toJson(instance.type),
      'multi_selections': instance.multiSelections
          .map(const MultiSelectSelectionJsonConverter().toJson)
          .toList(),
      'answer': instance.answer,
    };
