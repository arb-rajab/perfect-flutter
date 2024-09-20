import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class QuestionTagsChips extends StatelessWidget {
  final QuestionData questionData;
  const QuestionTagsChips({super.key, required this.questionData});

  @override
  Widget build(BuildContext context) {
    QuestionsController questionsController = Get.find();
    return Wrap(
      spacing: margin,
      children: questionData.questionTags
          .map((questionTag) => GestureDetector(
              onTap: () {
                QuestionsScreenArgument questionsScreenArgument =
                    questionsController.questionsScreenArgument!;
                if (questionsScreenArgument.source ==
                        QuestionScreenSource.questionTag &&
                    questionsScreenArgument.sourceId!.value == questionTag.id) {
                  return;
                }
                showConfirmationDialog(context, () {
                  Get.delete<QuestionsScreenArgument>();
                  Get.put(QuestionsScreenArgument(
                      query:
                          'q.id in (select questionId from questionsLinkedToTags where tagId =\'${questionTag.id}\') and q.parentTermId in (select termId from termTrees where parentTermId = \'${questionsScreenArgument.resourceTermId.value}\' and depth>0) order by q.id asc ',
                      source: QuestionScreenSource.questionTag,
                      sourceId: Id(questionTag.id),
                      resourceTermId: questionsScreenArgument.resourceTermId,
                      title: t.Title(questionTag.name)));
                  context.pushReplacement(QuestionsScreen.route);
                }, content: Text(StringConstant.aboutToMoveToQuestionTag.tr()));
              },
              child: Chip(
                label: Text(questionTag.name),
                deleteIcon: const Icon(Icons.article),
                onDeleted: () {
                  QuestionTagService questionTagService = Get.find();
                  questionTagService.openQuestionTagInformation(
                      questionTag: questionTag, context: context);
                },
              )))
          .toList(),
    );
  }
}
