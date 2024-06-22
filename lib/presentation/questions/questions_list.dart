import 'package:beta/configs/style.dart';
import 'package:beta/domain/answer_data.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'question_body.dart';
import 'question_footer.dart';
import 'question_header.dart';

class QuestionsList extends StatelessWidget {
  const QuestionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestionsController questionsController = Get.find();
    List objects = questionsController.getAllObjects();

    return Padding(
      padding: const EdgeInsets.only(
          left: halfMargin, right: halfMargin, bottom: halfMargin),
      child: ScrollablePositionedList.builder(
          itemScrollController: questionsController.itemScrollController,
          itemPositionsListener: questionsController.itemPositionsListener,
          shrinkWrap: true,
          itemCount: objects.length,
          itemBuilder: (context, index) {
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
          }),
    );
  }
}

enum QuestionFragment { header, body, footer }
