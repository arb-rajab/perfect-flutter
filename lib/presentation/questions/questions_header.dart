// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/questions/question_tags_choice.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/widgets/custom_check_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'level_group.dart';

class QuestionsHeader extends StatelessWidget {
  QuestionsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: halfMargin),
      child: Column(
        children: [
          NumberOfQuestions(),
          Row(
            children: [
              ShowFavoriteOnly(),
              ShowEditedOnly(),
            ],
          ),
          QuestionTagsChoice(),
          LevelGroup()
        ],
      ),
    );
  }
}

//TODO add test
class NumberOfQuestions extends StatelessWidget {
  NumberOfQuestions({super.key});
  final QuestionsController questionsController = Get.find();
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

//TODO add test
class ShowFavoriteOnly extends StatelessWidget {
  ShowFavoriteOnly({super.key});
  final QuestionsController questionsController = Get.find();
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

//TODO add test
class ShowEditedOnly extends StatelessWidget {
  ShowEditedOnly({super.key});
  final QuestionsController questionsController = Get.find();
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
