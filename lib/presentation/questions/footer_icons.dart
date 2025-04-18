import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_media_service.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/answer_data.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/dialogues/user_note_dialogue.dart';
import 'package:beta/presentation/media_slider/media_slider_screen.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class FooterIcons extends StatefulWidget {
  final QuestionData questionData;

  const FooterIcons({super.key, required this.questionData});
  @override
  State<StatefulWidget> createState() => _FooterIconsState();
}

class _FooterIconsState extends State<FooterIcons> {
  @override
  Widget build(BuildContext context) {
    QuestionData questionData = widget.questionData;
    QuestionsController questionsController = Get.find();
    bool isTemplate = questionsController.term != null &&
        questionsController.term!.type == TermType.template;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Visibility(
          visible: !isTemplate,
          child: IconButton.outlined(
              onPressed: () {
                questionsController.state.setState(
                    () => questionData.corrected = !questionData.corrected);
                if (!questionData.isInitiallyChecked) {
                  for (AnswerData answerData in questionData.answers) {
                    if (answerData.isChecked()) {
                      questionsController.checkedAnswers.add(answerData);
                    }
                  }
                }
              },
              icon: Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              )),
        ),
        IconButton.outlined(
            onPressed: () async {
              await questionData.setFavorite(!questionData.isFavorite());
              setState(() {});
            },
            icon: Icon(
              questionData.isFavorite() ? Icons.star : Icons.star_outline,
              color: Theme.of(context).primaryColor,
            )),
        IconButton.outlined(
            onPressed: () async {
              await showUserNoteDialogue(context, questionData);
              questionsController.state.setState(() {});
            },
            icon: Icon(
                questionData.hasUserNote() ? Icons.note : Icons.note_outlined)),
        Visibility(
            visible:
                questionData.hasNote && (!isTemplate || questionData.corrected),
            child: IconButton.outlined(
                onPressed: () {
                  showOkDialogue(context, 
                      contentWidget: questionData.question.specialCharacter ==
                              SpecialCharacter.none
                          ? Text(questionData.getTranslatableNote(),
                              style: const TextStyle(height: lineSpacing))
                          : questionData.question.specialCharacter ==
                                  SpecialCharacter.math
                              ? TeXView(
                                  child: TeXViewDocument(
                                      questionData.getMultiOrientationString(
                                          questionData.getTranslatableNote()),
                                      style: const TeXViewStyle.fromCSS(
                                          '"line-height":"$lineSpacing"')))
                              : const SizedBox.shrink());
                },
                icon: const Icon(Icons.info))),
        Visibility(
            visible: questionData.question.edited == 1,
            child: IconButton.outlined(
              onPressed: () => showOkDialogue(context, 
                  content: StringConstant.edittedOn.tr().replaceFirst(
                      '(DATE)',
                      questionData.question.editionDate
                          .toString()
                          .split(' ')[0])),
              icon: const Icon(Icons.rule),
            )),
        Visibility(
            visible: questionData.numberOfMedias > 0,
            child: IconButton.outlined(
                onPressed: () async {
                  QuestionMediaService questionMediaService = Get.find();
                  List<QuestionMedia> questionMedias =
                      await questionMediaService
                          .getAllQuestionMedias(questionData);
                  Get.delete<MediaSliderScreenArgument>();
                  Get.put(MediaSliderScreenArgument(
                      mediaUrls: questionMedias.map((qm) => qm.url).toList()));
                  if (context.mounted) context.push(MediaSliderScreen.route);
                },
                icon: const Icon(Icons.attachment))),
        Visibility(
            visible: questionData.translatable,
            child: IconButton.outlined(
                onPressed: () => questionsController.state.setState(
                    () => questionData.translated = !questionData.translated),
                icon: const Icon(Icons.translate)))
      ],
    );
  }
}
