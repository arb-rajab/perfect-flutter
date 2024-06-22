// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/questions/question_tags_choice.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'level_group.dart';

class QuestionsHeader extends StatelessWidget {
  const QuestionsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: halfMargin),
      child: Column(
        children: [
          Text(
            Get.find<QuestionsController>()
                .questionsScreenArgument
                .title
                .value!,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const NumberOfQuestions(),
          const ShowFavoriteOnly(),
          const ShowEditedOnly(),
          const QuestionTagsChoice(),
          LevelGroup(),
          const TermName()
        ],
      ),
    );
  }
}

//TODO add test
class NumberOfQuestions extends StatelessWidget {
  const NumberOfQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionsController questionsController = Get.find();
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
  const ShowFavoriteOnly({super.key});
  @override
  Widget build(BuildContext context) {
    QuestionsController questionsController = Get.find();
    return CheckboxListTile(
        title: Text(
          StringConstant.showFavoriteOnly.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        value: questionsController.isFavoriteOnly(),
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
  const ShowEditedOnly({super.key});
  @override
  Widget build(BuildContext context) {
    QuestionsController questionsController = Get.find();
    return CheckboxListTile(
        title: Text(
          StringConstant.showEditedOnly.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        value: questionsController.isEditedOnly(),
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

class TermName extends StatelessWidget {
  const TermName({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionsController questionsController = Get.find();
    if (questionsController.term != null) {
      return Padding(
        padding: const EdgeInsets.only(
            top: margin, left: halfMargin, right: halfMargin),
        child: Text(
          questionsController.term!.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }
    return Container();
  }
}
