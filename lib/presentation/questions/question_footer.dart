import 'package:beta/configs/style.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/questions/question_tags_chips.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:flutter/material.dart';

import 'footer_icons.dart';

class QuestionFooter extends StatelessWidget {
  final QuestionData questionData;
  final QuestionsController questionsController;
  const QuestionFooter(
      {super.key,
      required this.questionData,
      required this.questionsController});

  @override
  Widget build(BuildContext context) {
    bool isTemplate = questionsController.term != null &&
        questionsController.term!.type == TermType.template;
    return Padding(
      padding: const EdgeInsets.all(halfMargin),
      child: Column(
        children: [
          FooterIcons(
            questionData: questionData,
            questionsController: questionsController,
          ),
          if (!isTemplate)
            QuestionTagsChips(
              questionData: questionData,
              questionsController: questionsController,
            ),
          const Divider(height: halfMargin)
        ],
      ),
    );
  }
}
