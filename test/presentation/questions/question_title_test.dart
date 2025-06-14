import 'package:beta/application/services/database_service.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/questions/math_widget.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:beta/presentation/questions/question_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  QuestionData createQuestionData(
      {int specialCharacter = SpecialCharacter.none}) {
    return QuestionData(
        Question(
            id: 1,
            uuid: 'uuid',
            title: 'title',
            titleTranslation: 'titleTranslation',
            labelId: 1,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 1,
            specialCharacter: specialCharacter,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2024-01-01 11:12:13',
            editionDate: ''),
        parentTermName: 'parentTermName',
        numberOfMedias: 0,
        hasNote: false,
        indexInTerm: 0);
  }

  testWidgets('renders Text widget for none special character', (tester) async {
    QuestionData questionData = createQuestionData();

    await tester.pumpWidget(MyApp(
      child: QuestionTitle(questionData: questionData),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(Text), findsOneWidget);
    expect(find.text(questionData.question.title), findsOneWidget);

    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.style?.height, lineSpacing);
  });

  testWidgets('renders Text widget translated for none special character',
      (tester) async {
    QuestionData questionData = createQuestionData();
    questionData.translatable = true;
    questionData.translated = true;

    await tester.pumpWidget(MyApp(
      child: QuestionTitle(questionData: questionData),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(Text), findsOneWidget);
    expect(find.text(questionData.question.titleTranslation), findsOneWidget);

    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.style?.height, lineSpacing);
  });

  testWidgets('renders MathWidget for math special character', (tester) async {
    QuestionData questionData =
        createQuestionData(specialCharacter: SpecialCharacter.math);

    await tester.pumpWidget(MyApp(
      child: QuestionTitle(questionData: questionData),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(MathWidget), findsOneWidget);
  });
}
