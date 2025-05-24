import 'package:beta/configs/style.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/presentation/questions/math_widget.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:flutter/material.dart';

class QuestionTitle extends StatelessWidget {
  final QuestionData questionData;

  const QuestionTitle({super.key, required this.questionData});
  @override
  Widget build(BuildContext context) {
    if (questionData.question.specialCharacter == SpecialCharacter.none) {
      return Text(questionData.getTranslatableTitle(),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(height: lineSpacing));
    } else if (questionData.question.specialCharacter ==
        SpecialCharacter.math) {
      return MathWidget(
          data: questionData
              .getMultiOrientationString(questionData.getTranslatableTitle()));
      // return TeX2SVG(
      //     math: questionData
      //         .getMultiOrientationString(questionData.getTranslatableTitle()));
      // return TeXView(
      //     key: ValueKey('questions:${questionData.question.id}'),
      //     child: TeXViewDocument(
      //         questionData.getMultiOrientationString(
      //             questionData.getTranslatableTitle()),
      //         style:
      //             const TeXViewStyle.fromCSS('"line-height":"$lineSpacing"')));
    }
    return const SizedBox();
  }
}
