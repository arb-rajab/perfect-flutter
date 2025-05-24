import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/answer_data.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/questions/questions_header.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'question_body.dart';
import 'question_footer.dart';
import 'question_header.dart';

class QuestionsList extends StatelessWidget {
  QuestionsList({super.key});
  final QuestionsController questionsController = Get.find();
  @override
  Widget build(BuildContext context) {
    List objects = questionsController.getAllObjects();
    int itemCount = objects.length +
        1 +
        (questionsController.term != null &&
                questionsController.term!.type == TermType.template
            ? 1
            : 0);
    return ScrollablePositionedList.builder(
        itemScrollController: questionsController.itemScrollController,
        itemPositionsListener: questionsController.itemPositionsListener,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index == 0) return QuestionsHeader();
          if (questionsController.term != null &&
              questionsController.term!.type == TermType.template &&
              index == itemCount - 1) {
            return SubmitButton(
                text: StringConstant.correctQuestions.tr(),
                onSubmit: questionsController.moveToQuestionsReportScreen);
          }
          index--;
          switch (questionsController.getQuestionFragment(index)) {
            case QuestionFragment.header:
              QuestionData questionData = objects[index];
              return QuestionHeader(questionData: questionData);
            case QuestionFragment.body:
              AnswerData answerData = objects[index];
              return QuestionBody(
                answerData: answerData,
              );
            case QuestionFragment.footer:
              QuestionData questionData = objects[index];
              return QuestionFooter(questionData: questionData);
          }
        });
  }
}

enum QuestionFragment { header, body, footer }
