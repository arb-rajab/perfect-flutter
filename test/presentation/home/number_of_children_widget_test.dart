import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/presentation/widgets/number_of_children_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TermData createTermData({required int type}) {
    return TermData(
      Term(
        captureable: 1,
        id: 1,
        uuid: 'uuid',
        name: 'name',
        type: type,
        creation: '2022-01-01 11:13:15',
        enabled: 1,
        free: 1,
        ordering: 1,
        needsUpdate: 1,
        textCulumn: '',
        outerNote: '',
      ),
    );
  }

  testWidgets('renders animated counter for term type', (tester) async {
    final termData = createTermData(type: TermType.term)
      ..numberOfSubTerms = const NumberOfSubTerms(7);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumberOfChildrenWidget(termData),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.description), findsOneWidget);
    expect(find.text('x'), findsOneWidget);
    expect(find.text('7'), findsOneWidget);
  });

  testWidgets('renders question icon with count for questions type',
      (tester) async {
    final termData = createTermData(type: TermType.questions)
      ..numberOfQuestions = const NumberOfSubTerms(5);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumberOfChildrenWidget(termData),
        ),
      ),
    );

    expect(find.byIcon(Icons.question_answer), findsOneWidget);
    expect(find.text('x'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('renders nothing for ebook type', (tester) async {
    final termData = createTermData(type: TermType.ebook);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumberOfChildrenWidget(termData),
        ),
      ),
    );

    expect(find.text('x'), findsNothing);
  });

  testWidgets('renders quiz icon with count for template type', (tester) async {
    final termData = createTermData(type: TermType.template)
      ..numberOfQuestions = const NumberOfSubTerms(3);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumberOfChildrenWidget(termData),
        ),
      ),
    );

    expect(find.byIcon(Icons.quiz), findsOneWidget);
    expect(find.text('x'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('renders nothing for youtubeVideos type', (tester) async {
    final termData = createTermData(type: TermType.youtubeVideos);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumberOfChildrenWidget(termData),
        ),
      ),
    );

    expect(find.text('x'), findsNothing);
  });

  testWidgets('renders style icon with count for flashcards type',
      (tester) async {
    final termData = createTermData(type: TermType.flashcards)
      ..numberOfFlashcards = const NumberOfSubTerms(10);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumberOfChildrenWidget(termData),
        ),
      ),
    );

    expect(find.byIcon(Icons.style), findsOneWidget);
    expect(find.text('x'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
  });

  testWidgets('renders image icon with count for images type', (tester) async {
    final termData = createTermData(type: TermType.images)
      ..numberOfImages = const NumberOfSubTerms(10);

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: NumberOfChildrenWidget(termData))),
    );

    expect(find.byIcon(Icons.image), findsOneWidget);
    expect(find.text('x'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
  });

  testWidgets('renders nothing for voiceNotes type', (tester) async {
    final termData = createTermData(type: TermType.voiceNotes);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumberOfChildrenWidget(termData),
        ),
      ),
    );

    expect(find.text('x'), findsNothing);
  });

  testWidgets('renders nothing for video file type', (tester) async {
    final termData = createTermData(type: TermType.videoFile);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumberOfChildrenWidget(termData),
        ),
      ),
    );

    expect(find.text('x'), findsNothing);
  });
}
