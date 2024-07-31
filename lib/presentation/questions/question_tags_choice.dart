import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/custom_question_tag.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:choice/choice.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class QuestionTagsChoice extends StatelessWidget {
  QuestionTagsChoice({super.key});
  final QuestionsController questionsController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (!questionsController.deepLinked &&
        questionsController.questionsScreenArgument?.source ==
            QuestionScreenSource.term &&
        questionsController.term != null &&
        questionsController.term!.type == TermType.template) {
      return const SizedBox();
    }
    return PromptedChoice<CustomQuestionTag>.multiple(
      searchable: true,
      title: StringConstant.filterByQuestionTag.tr(),
      itemCount: questionsController.getQuestionTags().length,
      clearable: true,
      value: questionsController.selectedTags,
      onChanged: questionsController.setSelectedTags,
      itemBuilder: (state, i) {
        return ChoiceChip(
          avatar: const Icon(Icons.style),
          selected: questionsController.selectedTags
              .contains(questionsController.getQuestionTags()[i]),
          onSelected: (value) {
            state.onSelected(questionsController.getQuestionTags()[i]);
            questionsController.selectedTags
                .remove(questionsController.getQuestionTags()[i]);
            if (value) {
              questionsController.selectedTags
                  .add(questionsController.getQuestionTags()[i]);
            }
            if (!questionsController.questionFilters
                .contains(questionsController.tagsQuestionFilter)) {
              questionsController.questionFilters
                  .add(questionsController.tagsQuestionFilter);
            }
            // ignore: invalid_use_of_protected_member
            questionsController.state.setState(() {});
          },
          label:
              Text(questionsController.getQuestionTags()[i].questionTag.name),
        );
      },
      listBuilder: ChoiceList.createWrapped(
        spacing: margin,
        runSpacing: margin,
        padding: const EdgeInsets.symmetric(
          horizontal: doubleMargin,
          vertical: doubleMargin,
        ),
      ),
    );
  }
}
