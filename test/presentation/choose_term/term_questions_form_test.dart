import 'package:beta/configs/style.dart';
import 'package:beta/domain/multi_select_selection.dart';
import 'package:beta/domain/term_question.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/domain/value/type.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/choose_term/term_questions_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();

  testWidgets('term questions form displays term question title',
      (widgetTester) async {
    const String termQuestionTitle = 'random title';
    const String selectionTitle = 'selection title';
    await widgetTester.pumpWidget(MaterialApp(
        home: TermQuestionsForm(
      termQuestions: [
        TermQuestion(
            id: const Id(1),
            title: const t.Title(termQuestionTitle),
            type: const Type(1),
            multiSelections: [
              MultiSelectSelection(
                  id: const Id(1), title: const t.Title(selectionTitle))
            ])
      ],
    )));
    await widgetTester.pump(animationDuration);
    expect(find.text(termQuestionTitle), findsOneWidget);
    expect(find.text(selectionTitle), findsOneWidget);
  });
}
