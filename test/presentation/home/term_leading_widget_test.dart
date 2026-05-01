import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/term_leading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TermData termData = TermData(const Term(
      captureable: 1,
      id: 1,
      uuid: 'uuid',
      name: 'name',
      type: TermType.questions,
      creation: '2022-01-01 11:13:15',
      enabled: 1,
      free: 1,
      ordering: 1,
      needsUpdate: 1,
      textCulumn: '',
      outerNote: ''));

  testWidgets('displays question icon for questions term type', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.questions);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    expect(find.byIcon(Icons.question_mark), findsOneWidget);
  });

  testWidgets('displays question icon with correct size', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.questions);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.question_mark));
    expect(icon.size, 50);
  });

  testWidgets('displays book icon for ebook term type', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.ebook);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    expect(find.byIcon(Icons.book), findsOneWidget);
  });

  testWidgets('displays book icon with correct size', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.ebook);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.book));
    expect(icon.size, 50);
  });

  testWidgets('displays quiz icon for template term type', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.template);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    expect(find.byIcon(Icons.quiz), findsOneWidget);
  });

  testWidgets('displays quiz icon with correct size', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.template);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.quiz));
    expect(icon.size, 50);
  });

  testWidgets('displays video icon for youtubeVideos term type',
      (tester) async {
    termData.term = termData.term.copyWith(type: TermType.youtubeVideos);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    expect(find.byIcon(Icons.slow_motion_video), findsOneWidget);
  });

  testWidgets('displays video icon with correct size', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.youtubeVideos);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.slow_motion_video));
    expect(icon.size, 50);
  });

  testWidgets('displays style icon for flashcards term type', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.flashcards);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    expect(find.byIcon(Icons.style), findsOneWidget);
  });

  testWidgets('displays image icon for images term type', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.images);

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: TermLeadingWidget(termData))),
    );

    expect(find.byIcon(Icons.image), findsOneWidget);
  });

  testWidgets('displays ztyle icon with correct size', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.flashcards);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.style));
    expect(icon.size, 50);
  });

  testWidgets('displays images icon with correct size', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.images);

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: TermLeadingWidget(termData))),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.image));
    expect(icon.size, 50);
  });

  testWidgets('displays audio icon for voiceNotes term type', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.voiceNotes);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    expect(find.byIcon(Icons.audiotrack), findsOneWidget);
  });

  testWidgets('displays audio icon with correct size', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.voiceNotes);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.audiotrack));
    expect(icon.size, 50);
  });

  testWidgets('displays video icon for video file term type', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.videoFile);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    expect(find.byIcon(Icons.slow_motion_video), findsOneWidget);
  });

  testWidgets('displays video icon with correct size', (tester) async {
    termData.term = termData.term.copyWith(type: TermType.videoFile);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.slow_motion_video));
    expect(icon.size, 50);
  });

  testWidgets('displays default description icon for term type',
      (tester) async {
    termData.term = termData.term.copyWith(type: TermType.term);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    expect(find.byIcon(Icons.description), findsOneWidget);
  });

  testWidgets('displays default description icon with correct size',
      (tester) async {
    termData.term = termData.term.copyWith(type: TermType.term);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermLeadingWidget(termData),
        ),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.description));
    expect(icon.size, 50);
  });
}
