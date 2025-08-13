import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/question_data.dart';
import 'package:get/instance_manager.dart';

class QuestionsReportController {
  QuestionsReportScreenArgument questionsReportScreenArgument = Get.find();
  bool questionsWithNoQuestionsTagsExists = false;

  List<QuestionTag> childQuestionTags = [];
  List<QuestionTag> parentQuestionTags = [];
  List<QuestionTag> allQuestionTags = [];

  QuestionsReportController() {
    questionsWithNoQuestionsTagsExists = questionsReportScreenArgument.questions
        .where((element) => element.questionTags.isEmpty)
        .isNotEmpty;
    _configureQuestionTagList();
  }

  _configureQuestionTagList() {
    for (QuestionData questionData in questionsReportScreenArgument.questions) {
      for (QuestionTag questionTag in questionData.questionTags) {
        bool alreadyAdded = false;
        if (questionTag.parentTagId != 0) {
          for (QuestionTag childTag in childQuestionTags) {
            if (childTag.id == questionTag.id) {
              alreadyAdded = true;
              break;
            }
          }
          if (!alreadyAdded) childQuestionTags.add(questionTag);
        } else {
          for (QuestionTag parentTag in parentQuestionTags) {
            if (parentTag.id == questionTag.id) {
              alreadyAdded = true;
              break;
            }
          }
          if (!alreadyAdded) parentQuestionTags.add(questionTag);
        }
      }
    }

    childQuestionTags.sort((a, b) => a.parentTagId.compareTo(b.parentTagId));

    for (QuestionTag parentTag in parentQuestionTags) {
      bool alreadyAdded = false;
      for (QuestionTag childTag in childQuestionTags) {
        if (childTag.parentTagId == parentTag.id ||
            childTag.id == parentTag.id) {
          alreadyAdded = true;
          break;
        }
      }
      if (!alreadyAdded) childQuestionTags.add(parentTag);
    }
    allQuestionTags = [...childQuestionTags];

    for (int c = 1; c < allQuestionTags.length; c++) {
      QuestionTag questionTag = allQuestionTags[c];
      QuestionTag previousQuestionTag = allQuestionTags[c - 1];
      if (getParentTag(previousQuestionTag.parentTagId) != null &&
          previousQuestionTag.parentTagId != questionTag.parentTagId &&
          previousQuestionTag.parentTagId != 0 &&
          questionTag.parentTagId != 0) {
        allQuestionTags.insert(
            c, getParentTag(previousQuestionTag.parentTagId)!);
      }
    }
    // append last question tag parent
    QuestionTag questionTag = allQuestionTags[allQuestionTags.length - 1];
    if (questionTag.parentTagId != 0 &&
        getParentTag(questionTag.parentTagId) != null) {
      allQuestionTags.add(getParentTag(questionTag.parentTagId)!);
    }
  }

  QuestionTag? getParentTag(int id) {
    for (int c = 0; c < parentQuestionTags.length; c++) {
      QuestionTag questionTag = parentQuestionTags[c];
      if (questionTag.id == id) return questionTag;
    }
    return null;
  }
}
