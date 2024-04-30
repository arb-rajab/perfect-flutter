import 'package:beta/domain/value/description.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'frequent_question.freezed.dart';
part 'frequent_question.g.dart';

@freezed
@JsonSerializable()
class FrequentQuestion with _$FrequentQuestion {
  factory FrequentQuestion(
          {@IdJsonConverter() required Id id,
          @TitleJsonConverter() required Title title,
          @DescriptionJsonConverter() required Description description}) =
      _FrequentQuestion;

  static FrequentQuestion fromJson(Map<String, dynamic> json) =>
      _$FrequentQuestionFromJson(json);

  static Map<String, dynamic> toJson(FrequentQuestion instance) =>
      _$FrequentQuestionToJson(instance);
}
