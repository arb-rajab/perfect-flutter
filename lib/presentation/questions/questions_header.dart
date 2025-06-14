// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/questions/question_tags_choice.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/widgets/custom_check_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'level_group.dart';

class QuestionsHeader extends StatelessWidget {
  final QuestionsController questionsController;
  const QuestionsHeader({super.key, required this.questionsController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: halfMargin),
      child: Column(
        children: [
          NumberOfQuestions(
            questionsController: questionsController,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ShowFavoriteOnly(
                    questionsController: questionsController,
                  ),
                  ShowEditedOnly(
                    questionsController: questionsController,
                  ),
                ],
              )),
          if (questionsController.deepLinked ||
              !(questionsController.questionsScreenArgument?.source ==
                      QuestionScreenSource.term &&
                  questionsController.term != null &&
                  questionsController.term!.type == TermType.template))
            QuestionTagsChoice(
              questionsController: questionsController,
            ),
          if (questionsController.questionsFilteringEnabled)
            LevelGroup(
              questionsController: questionsController,
            )
        ],
      ),
    );
  }
}

class NumberOfQuestions extends StatelessWidget {
  final QuestionsController questionsController;
  const NumberOfQuestions({super.key, required this.questionsController});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            top: margin, left: halfMargin, right: halfMargin),
        child: Text(
          StringConstant.numberOfQuestions.tr().replaceFirst(
              '(NUMBER)', questionsController.questions.length.toString()),
          style: Theme.of(context).textTheme.bodyLarge,
        ));
  }
}

class ShowFavoriteOnly extends StatelessWidget {
  final QuestionsController questionsController;
  const ShowFavoriteOnly({super.key, required this.questionsController});

  @override
  Widget build(BuildContext context) {
    return CustomCheckbox(
        label: StringConstant.showFavoriteOnly.tr(),
        checked: questionsController.isFavoriteOnly(),
        onChanged: (value) {
          questionsController.questionFilters
              .remove(questionsController.favoriteFilter);
          questionsController.state.setState(() {
            if (value!) {
              questionsController.questionFilters
                  .add(questionsController.favoriteFilter);
            }
          });
        });
  }
}

class ShowEditedOnly extends StatelessWidget {
  final QuestionsController questionsController;
  const ShowEditedOnly({super.key, required this.questionsController});

  @override
  Widget build(BuildContext context) {
    return CustomCheckbox(
        label: StringConstant.showEditedOnly.tr(),
        checked: questionsController.isEditedOnly(),
        onChanged: (value) {
          questionsController.questionFilters
              .remove(questionsController.editedFilter);
          questionsController.state.setState(() {
            if (value!) {
              questionsController.questionFilters
                  .add(questionsController.editedFilter);
            }
          });
        });
  }
}
