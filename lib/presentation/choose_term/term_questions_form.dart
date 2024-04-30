import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_question.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/choose_term/drop_down_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TermQuestionsForm extends StatefulWidget {
  final List<TermQuestion> termQuestions;
  const TermQuestionsForm({super.key, required this.termQuestions});

  @override
  State<TermQuestionsForm> createState() => _TermQuestionsFormState();
}

class _TermQuestionsFormState extends State<TermQuestionsForm> {
  late List<TermQuestion> termQuestions;
  @override
  void initState() {
    termQuestions = widget.termQuestions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> termQuestionsWidgets = [];
    for (int c = 0; c < termQuestions.length; c++) {
      TermQuestion termQuestion = termQuestions[c];
      switch (termQuestion.type) {
        case TermQuestionType.multiSelection:
          termQuestionsWidgets.add(DropDownButton(
              label: termQuestion.title.value!,
              selectionId: termQuestion.answer != null
                  ? int.parse(termQuestion.answer!)
                  : termQuestion.multiSelections[0].id.value,
              selections: termQuestion.multiSelections, //.toList(),
              onChanged: (value) {
                setState(() {
                  termQuestion =
                      termQuestion.copyWith(answer: value.toString());
                  termQuestions[c] = termQuestion;
                });
              }));
          break;
      }
    }
    return OpacityAnimation(
        child: AlertDialog(
      title: Text(StringConstant.pleaseFillTheQuestionary.tr()),
      content:
          SingleChildScrollView(child: Column(children: termQuestionsWidgets)),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, termQuestions),
            child: Text(StringConstant.ok.tr()))
      ],
    ));
  }
}
