import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:beta/presentation/questions/question_title_list_tile.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class QuestionHeader extends StatelessWidget {
  final QuestionData questionData;
  const QuestionHeader({super.key, required this.questionData});

  String getLabelText() {
    switch (questionData.question.labelId) {
      case 1:
        return StringConstant.chooseRightAnswer.tr();
      case 2:
        return StringConstant.chooseCorrectAnswer.tr();
      case 3:
        return StringConstant.chooseWrongAnswer.tr();
      case 4:
        return StringConstant.chooseDifferentAnswer.tr();
      case 5:
        return StringConstant.chooseKeyAnswer.tr();
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    QuestionsController questionsController = Get.find();
    return Column(
      children: [
        if (questionsController.questions.indexOf(questionData) == 0 ||
            (questionsController.questions.indexOf(questionData) > 0 &&
                questionsController
                        .questions[questionsController.questions
                                .indexOf(questionData) +
                            1]
                        .question
                        .parentTermId !=
                    questionData.question.parentTermId))
          GestureDetector(
            onTap: () {
              showConfirmationDialog(context, () {
                Get.delete<QuestionsScreenArgument>();
                Get.put(QuestionsScreenArgument(
                    query:
                        'q.parentTermId= ${questionData.question.parentTermId}  ORDER BY q.id asc',
                    source: QuestionScreenSource.term,
                    sourceId: Id(questionData.question.parentTermId),
                    resourceTermId: questionsController
                        .questionsScreenArgument.resourceTermId,
                    title: t.Title(questionData.parentTermName)));
                context.go(QuestionsScreen.route);
              }, content: Text(StringConstant.aboutToMoveToTerm.tr()));
            },
            child: WidgetWrapperWithBorder(
                child: Row(
              children: [
                const Icon(Icons.description),
                Text(
                  questionData.parentTermName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            )),
          ),
        if (questionsController.questions.indexOf(questionData) == 0 ||
            (questionsController.questions.indexOf(questionData) > 0 &&
                questionsController
                        .questions[questionsController.questions
                                .indexOf(questionData) +
                            1]
                        .question
                        .labelId !=
                    questionData.question.labelId))
          WidgetWrapperWithBorder(
              child: Row(
            children: [
              const Icon(Icons.info),
              Text(
                getLabelText(),
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          )),
        QuestionTitleListTile(questionData: questionData),
        if (questionData.imageVisible)
          CachedNetworkImage(
            imageUrl: questionData.question.imageUrl,
          )
      ],
    );
  }
}

class SpecialCharacter {
  static const int none = 1;
  static const int math = 2;
}
