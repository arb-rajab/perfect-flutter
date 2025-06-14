import 'package:beta/application/services/share_service.dart';
import 'package:beta/configs/app.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/presentation/dialogues/report_question_dialogue.dart';
import 'package:beta/presentation/questions/question_title.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/widgets/widget_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class QuestionTitleListTile extends StatelessWidget {
  final QuestionData questionData;
  final QuestionsController questionsController;
  const QuestionTitleListTile(
      {super.key,
      required this.questionData,
      required this.questionsController});

  @override
  Widget build(BuildContext context) {
    return WidgetWrapper(
        child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        radius: borderRadius,
        child: Text(
          (questionData.indexInTerm + 1).toString(),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
      title: QuestionTitle(
        questionData: questionData,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (questionData.question.imageUrl.isNotEmpty)
            IconButton(
                onPressed: () {
                  // ignore: invalid_use_of_protected_member
                  questionsController.state.setState(() {
                    questionData.imageVisible = !questionData.imageVisible;
                  });
                },
                icon: const Icon(Icons.image)),
          PopupMenuButton<int>(
            // icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                onTap: () => showReportQuestionDialogue(context, questionData),
                child: ListTile(
                  leading: const Icon(Icons.report),
                  title: Text(StringConstant.reportQuestion.tr()),
                ),
              ),
              PopupMenuItem(
                onTap: () => Get.find<ShareService>().share(
                    StringConstant.shareQuestionBody
                    .tr()
                    .replaceAll('(LINK)',
                        '$scheme://$host/q/${questionData.question.uuid}')),
                child: ListTile(
                  leading: const Icon(Icons.share),
                  title: Text(StringConstant.shareQuestion.tr()),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
