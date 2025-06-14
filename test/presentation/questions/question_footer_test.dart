import 'package:beta/application/services/database_service.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/presentation/questions/footer_icons.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:beta/presentation/questions/question_tags_chips.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/questions/question_footer.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();
  Widget createWidgetUnderTest({int? termType}) {
    QuestionsController questionsController =
        QuestionsController(QuestionsScreenState());
    if (termType != null) {
      questionsController.term = Term(
          id: 1,
          uuid: 'uuid',
          name: 'name',
          type: termType,
          creation: '2024-11-30 11:12:13',
          enabled: 1,
          free: 1,
          ordering: 1,
          needsUpdate: 0,
          captureable: 1,
          textCulumn: 'textCulumn',
          outerNote: 'outerNote');
    }
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
            specialCharacter: SpecialCharacter.none,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2024-01-01 11:12:13',
            editionDate: ''),
        parentTermName: 'parentTermName',
        numberOfMedias: 0,
        hasNote: false,
        indexInTerm: 0)
      ..questionTags = []
      ..questionProperties = [];

    return MaterialApp(
      home: Scaffold(
        body: QuestionFooter(
          questionData: questionData,
          questionsController: questionsController,
        ),
      ),
    );
  }

  testWidgets('QuestionFooter shows all children when not a template term',
      (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(FooterIcons), findsOneWidget);
    expect(find.byType(QuestionTagsChips), findsOneWidget);
    expect(find.byType(Divider), findsOneWidget);
  });

  testWidgets('QuestionFooter hides QuestionTagsChips when term is template',
      (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(termType: TermType.template));

    expect(find.byType(FooterIcons), findsOneWidget);
    expect(find.byType(QuestionTagsChips), findsNothing);
    expect(find.byType(Divider), findsOneWidget);
  });

  testWidgets('QuestionFooter shows Divider', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final dividerFinder = find.byType(Divider);
    expect(dividerFinder, findsOneWidget);

    final divider = tester.widget<Divider>(dividerFinder);
    expect(divider.height, equals(halfMargin));
  });

  testWidgets('QuestionFooter shows FooterIcons in all cases', (tester) async {
    // Test with null term
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(FooterIcons), findsOneWidget);

    // Test with template term
    await tester.pumpWidget(createWidgetUnderTest(termType: TermType.template));
    expect(find.byType(FooterIcons), findsOneWidget);

    // Test with non-template term
    await tester
        .pumpWidget(createWidgetUnderTest(termType: TermType.questions));
    expect(find.byType(FooterIcons), findsOneWidget);
  });
}
