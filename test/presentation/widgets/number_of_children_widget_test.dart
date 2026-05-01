import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/widgets/number_of_children_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  TermData originalTermData = TermData(const Term(
      id: 1,
      uuid: 'uuid',
      name: 'name',
      type: TermType.term,
      creation: '2024-01-01 11:12:13',
      enabled: 1,
      free: 1,
      ordering: 1,
      needsUpdate: 0,
      captureable: 1,
      textCulumn: 'textCulumn',
      outerNote: 'outerNote'));

  testWidgets('flashcards icon is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: NumberOfChildrenWidget(originalTermData
        ..term = originalTermData.term.copyWith(type: TermType.flashcards)
        ..numberOfFlashcards = const NumberOfSubTerms(10)),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.byIcon(Icons.style), findsOneWidget);
  });

  testWidgets('flashcards number of flashcards is rendered',
      (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: NumberOfChildrenWidget(originalTermData
        ..term = originalTermData.term.copyWith(type: TermType.flashcards)
        ..numberOfFlashcards = const NumberOfSubTerms(10)),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text('10'), findsOneWidget);
  });

  testWidgets('images icon is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(
      MyApp(
        child: NumberOfChildrenWidget(
          originalTermData
            ..term = originalTermData.term.copyWith(type: TermType.images)
            ..numberOfImages = const NumberOfSubTerms(10),
        ),
      ),
    );
    await widgetTester.pumpAndSettle();

    expect(find.byIcon(Icons.image), findsOneWidget);
  });

  testWidgets('images number of images is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(
      MyApp(
        child: NumberOfChildrenWidget(
          originalTermData
            ..term = originalTermData.term.copyWith(type: TermType.images)
            ..numberOfImages = const NumberOfSubTerms(10),
        ),
      ),
    );
    await widgetTester.pumpAndSettle();

    expect(find.text('10'), findsOneWidget);
  });

  testWidgets('questions icon is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: NumberOfChildrenWidget(originalTermData
        ..term = originalTermData.term.copyWith(type: TermType.questions)
        ..numberOfQuestions = const NumberOfSubTerms(10)),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.byIcon(Icons.question_answer), findsOneWidget);
  });

  testWidgets('questions number of questions is rendered',
      (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: NumberOfChildrenWidget(originalTermData
        ..term = originalTermData.term.copyWith(type: TermType.questions)
        ..numberOfQuestions = const NumberOfSubTerms(10)),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text('10'), findsOneWidget);
  });

  testWidgets('template icon is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: NumberOfChildrenWidget(originalTermData
        ..term = originalTermData.term.copyWith(type: TermType.template)
        ..numberOfQuestions = const NumberOfSubTerms(10)),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.byIcon(Icons.quiz), findsOneWidget);
  });

  testWidgets('template number of questions is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: NumberOfChildrenWidget(originalTermData
        ..term = originalTermData.term.copyWith(type: TermType.template)
        ..numberOfQuestions = const NumberOfSubTerms(10)),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text('10'), findsOneWidget);
  });

  testWidgets('term icon is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: NumberOfChildrenWidget(originalTermData
        ..term = originalTermData.term.copyWith(type: TermType.term)
        ..numberOfSubTerms = const NumberOfSubTerms(10)),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.byIcon(Icons.description), findsOneWidget);
  });

  testWidgets('term number of subterms is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: NumberOfChildrenWidget(originalTermData
        ..term = originalTermData.term.copyWith(type: TermType.term)
        ..numberOfSubTerms = const NumberOfSubTerms(10)),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text('10'), findsOneWidget);
  });
}
