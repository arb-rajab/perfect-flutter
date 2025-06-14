import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/report_question_dialogue.dart';
import 'package:beta/presentation/questions/question_title.dart';
import 'package:beta/presentation/widgets/input_widget.dart';
import 'package:dio/dio.dart';
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
      indexInTerm: 12);

  testWidgets('repport question number id is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: ReportQuestionDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.reportQuestionNumber), findsOneWidget);
  });

  testWidgets('send button is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: ReportQuestionDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.send), findsOneWidget);
  });

  testWidgets('send icon is rendered if not sending', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: ReportQuestionDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.byIcon(Icons.send), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('a message is shown if suggestion is empty',
      (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: ReportQuestionDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    // tap the send button
    await widgetTester.tap(find.text(StringConstant.send));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.pleaseFillThisField), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('loading widget is rendered if sending', (widgetTester) async {
    mockNoConnection(
        route: ApiConstant.reportQuestion
            .replaceFirst('(QUESTION_ID)', questionData.question.id.toString()),
        method: 'post');
    await widgetTester.pumpWidget(MyApp(
      child: ReportQuestionDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    await widgetTester.enterText(find.byType(InputWidget), 'random text');
    await widgetTester.pumpAndSettle();

    // tap the send button
    await widgetTester.tap(find.text(StringConstant.send));
    await widgetTester.pump();

    expect(find.byIcon(Icons.send), findsNothing);
    expect(find.text(StringConstant.pleaseFillThisField), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await widgetTester.pumpAndSettle();
  });

  testWidgets('no connection message is shown if there is no connections',
      (widgetTester) async {
    mockNoConnection(
        route: ApiConstant.reportQuestion
            .replaceFirst('(QUESTION_ID)', questionData.question.id.toString()),
        data: FormData.fromMap({'suggestion': 'random text'}),
        method: 'post');
    await widgetTester.pumpWidget(MyApp(
      child: ReportQuestionDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    await widgetTester.enterText(find.byType(InputWidget), 'random text');
    await widgetTester.pumpAndSettle();

    // tap the send button
    await widgetTester.tap(find.text(StringConstant.send));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.noConnection), findsOneWidget);
    expect(find.byIcon(Icons.send), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('message is shown if recieving message', (widgetTester) async {
    mockMessageRecieved(
        route: ApiConstant.reportQuestion
            .replaceFirst('(QUESTION_ID)', questionData.question.id.toString()),
        data: FormData.fromMap({'suggestion': 'random text'}),
        method: 'post');
    await widgetTester.pumpWidget(MyApp(
      child: ReportQuestionDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    await widgetTester.enterText(find.byType(InputWidget), 'random text');
    await widgetTester.pumpAndSettle();

    // tap the send button
    await widgetTester.tap(find.text(StringConstant.send));
    await widgetTester.pumpAndSettle();

    expect(find.text('a message recieved'), findsOneWidget);
    expect(find.byIcon(Icons.send), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('question title is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: ReportQuestionDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.questionTitle), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, questionData.question.title),
        findsOneWidget);
  });

  testWidgets('input suggestion is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: ReportQuestionDialogue(questionData),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(InputWidget, StringConstant.enterSuggestion),
        findsOneWidget);
  });
}
