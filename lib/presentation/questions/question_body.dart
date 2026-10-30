import 'package:beta/configs/style.dart';
import 'package:beta/domain/answer_data.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/presentation/questions/math_widget.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/widgets/custom_check_box.dart';
import 'package:flutter/material.dart';

class QuestionBody extends StatelessWidget {
  final AnswerData answerData;
  final QuestionsController questionsController;
  const QuestionBody({
    super.key,
    required this.answerData,
    required this.questionsController,
  });

  @override
  Widget build(BuildContext context) {
    QuestionData questionData = questionsController.getAnswerParentQuestion(
      answerData,
    )!;

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

    Future<void> onChanged(bool? value) async {
      for (AnswerData answerData in questionData.answers) {
        await answerData.setChecked(false);
      }
      await answerData.setChecked(value!);
      // ignore: invalid_use_of_protected_member
      questionsController.state.setState(() {});
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Semantics(
            label: answerData.getTranslatableTitle(questionData.translated),
            checked: answerData.isChecked(),
            inMutuallyExclusiveGroup: true,
            onTap: () => onChanged(!answerData.isChecked()),
            excludeSemantics: true,
            child: CustomCheckbox(
              checked: answerData.isChecked(),
              labelWidget:
                  answerData.answer.specialCharacter == SpecialCharacter.none
                  ? Text(
                      answerData.getTranslatableTitle(questionData.translated),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        height: lineSpacing,
                        color: getColorAfterCorrection(),
                      ),
                    )
                  : answerData.answer.specialCharacter == SpecialCharacter.math
                  ? MathWidget(
                      data: questionData.getMultiOrientationString(
                        answerData.getTranslatableTitle(
                          questionData.translated,
                        ),
                      ),
                    )
                  // TeX2SVG(
                  //     math: questionData.getMultiOrientationString(answerData
                  //             .getTranslatableTitle(questionData.translated)),
                  //   )
                  // TeXView(
                  //     loadingWidgetBuilder: (context) {
                  //       return const CircularProgressIndicator();
                  //     },
                  //     child: TeXViewDocument(
                  //         questionData.getMultiOrientationString(answerData
                  //             .getTranslatableTitle(questionData.translated)),
                  //         style: TeXViewStyle(
                  //           contentColor: getColorAfterCorrection(),
                  //         )))
                  : null,
              onChanged: onChanged,
            ),
          ),
        ),
        if (questionData.corrected)
          if (answerData.answer.isCorrect == 1)
            Icon(Icons.check, color: Theme.of(context).primaryColor)
          else if (answerData.isChecked())
            Icon(Icons.close, color: Theme.of(context).colorScheme.error),
      ],
    );
  }
}
