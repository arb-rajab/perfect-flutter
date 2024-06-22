import 'package:beta/configs/style.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/questions/question_tags_chips.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'footer_icons.dart';

class QuestionFooter extends StatelessWidget {
  final QuestionData questionData;
  const QuestionFooter({super.key, required this.questionData});

  @override
  Widget build(BuildContext context) {
    QuestionsController questionsController = Get.find();
    bool isTemplate = questionsController.term != null &&
        questionsController.term!.type == TermType.template;
    return Padding(
      padding: const EdgeInsets.all(halfMargin),
      child: Column(
        children: [
          FooterIcons(questionData: questionData),
          if (!isTemplate) QuestionTagsChips(questionData: questionData),
          const Divider(height: halfMargin)
        ],
      ),
    );
  }
}
