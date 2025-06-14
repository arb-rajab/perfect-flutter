// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LevelGroup extends StatelessWidget {
  const LevelGroup({super.key, required this.questionsController});
  final QuestionsController questionsController;

  void clearLevelFilters() {
    questionsController.questionFilters
        .remove(questionsController.easyQuestionsFilter);
    questionsController.questionFilters
        .remove(questionsController.mediumQuestionsFilter);
    questionsController.questionFilters
        .remove(questionsController.difficultQuestionsFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: margin,
      children: [
        FilterChip(
          label: Text(StringConstant.easyQuestions.tr()),
          selected: questionsController.questionFilters
              .contains(questionsController.easyQuestionsFilter),
          onSelected: (bool value) {
            clearLevelFilters();
            if (value) {
              questionsController.questionFilters
                  .add(questionsController.easyQuestionsFilter);
            }
            questionsController.state.setState(() {});
          },
        ),
        FilterChip(
          label: Text(StringConstant.mediumQuestions.tr()),
          selected: questionsController.questionFilters
              .contains(questionsController.mediumQuestionsFilter),
          onSelected: (bool value) {
            clearLevelFilters();
            if (value) {
              questionsController.questionFilters
                  .add(questionsController.mediumQuestionsFilter);
            }
            questionsController.state.setState(() {});
          },
        ),
        FilterChip(
          label: Text(StringConstant.difficultQuestions.tr()),
          selected: questionsController.questionFilters
              .contains(questionsController.difficultQuestionsFilter),
          onSelected: (bool value) {
            clearLevelFilters();
            if (value) {
              questionsController.questionFilters
                  .add(questionsController.difficultQuestionsFilter);
            }
            questionsController.state.setState(() {});
          },
        ),
      ],
    );
  }
}
