import 'package:beta/configs/style.dart';
import 'package:beta/domain/answer_data.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/instance_manager.dart';

class QuestionBody extends StatelessWidget {
  final AnswerData answerData;

  const QuestionBody({super.key, required this.answerData});

  @override
  Widget build(BuildContext context) {
    QuestionsController questionsController = Get.find();
    QuestionData questionData =
        questionsController.getAnswerParentQuestion(answerData)!;

    Color? getColorAfterCorrection() {
      if (questionData.corrected) {
        if (answerData.answer.isCorrect == 1) {
          return Theme.of(context).primaryColor;
        }
        if (answerData.isChecked()) return Theme.of(context).colorScheme.error;
        return Theme.of(context).disabledColor;
      }
      return null;
    }

    return Padding(
      padding: const EdgeInsets.all(margin),
      child: RadioListTile<AnswerData>(
        selected: answerData.isChecked(),
        title: answerData.answer.specialCharacter == SpecialCharacter.none
            ? Text(
                answerData.getTranslatableTitle(questionData.translated),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    height: lineSpacing, color: getColorAfterCorrection()),
              )
            : answerData.answer.specialCharacter == SpecialCharacter.math
                ? TeXView(
                    child: TeXViewDocument(
                        questionData.getMultiOrientationString(answerData
                            .getTranslatableTitle(questionData.translated)),
                        style: TeXViewStyle(
                          contentColor: getColorAfterCorrection(),
                        )))
                : null,
        value: answerData,
        groupValue: null,
        onChanged: (AnswerData? value) async {
          for (AnswerData answerData in questionData.answers) {
            await answerData.setChecked(false);
          }
          value!.setChecked(true);
        },
        secondary: questionData.corrected
            ? answerData.answer.isCorrect == 1
                ? Icon(
                    Icons.check,
                    color: Theme.of(context).primaryColor,
                  )
                : answerData.isChecked()
                    ? Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.error,
                      )
                    : null
            : null,
      ),
    );
  }
}
