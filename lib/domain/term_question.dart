import 'package:beta/domain/multi_select_selection.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart';
import 'package:beta/domain/value/type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_question.freezed.dart';
part 'term_question.g.dart';

@freezed
@JsonSerializable()
class TermQuestion with _$TermQuestion {
  factory TermQuestion(
      {@IdJsonConverter() required Id id,
      @TitleJsonConverter() required Title title,
      @TypeJsonConverter() required Type type,
      @JsonKey(name: 'multi_selections')
      required List<MultiSelectSelection> multiSelections,
      String? answer}) = _TermQuestion;

  static TermQuestion fromJson(Map<String, dynamic> json) =>
      _$TermQuestionFromJson(json);
}

class TermQuestionType {
  static const Type multiSelection = Type(1);
}
