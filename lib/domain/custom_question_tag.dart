import 'package:beta/application/services/database_service.dart';

class CustomQuestionTag {
  final QuestionTag questionTag;
  CustomQuestionTag(this.questionTag);

  @override
  String toString() {
    return questionTag.name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomQuestionTag && other.questionTag.id == questionTag.id);

  @override
  int get hashCode => Object.hash(questionTag.id, null);
}
