import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/user_note_dialogue.dart';
import 'package:beta/presentation/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  QuestionData questionData = QuestionData(
      const Question(
          id: 1,
          uuid: 'uuid',
          title: 'title',
          titleTranslation: 'titleTranslation',
          labelId: 1,
          note: 'note',
          noteTranslation: 'noteTranslation',
          parentTermId: 1,
          specialCharacter: 1,
          type: 1,
          edited: 0,
          imageUrl: '',
          creation: '2024-01-01 11:12:13',
          editionDate: ''),
      parentTermName: 'parentTermName',
      numberOfMedias: 0,
      hasNote: false,
      indexInTerm: 12)
    ..questionProperties = [
      const QuestionProperty(
          questionId: 1, name: 'userNote', value: 'user note')
    ];

  testWidgets('enter note input is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: UserNoteDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(InputWidget, StringConstant.enterNote),
        findsOneWidget);
  });

  testWidgets('enter note note is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: UserNoteDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(InputWidget, 'user note'), findsOneWidget);
  });

  testWidgets('save note button is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: UserNoteDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    expect(
        find.widgetWithText(TextButton, StringConstant.save), findsOneWidget);
  });

  testWidgets('delete note button is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: UserNoteDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    expect(
        find.widgetWithText(TextButton, StringConstant.delete), findsOneWidget);
  });
}
