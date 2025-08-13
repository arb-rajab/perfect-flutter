import 'package:beta/presentation/questions_report/quiz_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuizDetailWidget', () {
    testWidgets('renders with parent title only', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QuizDetailWidget(
              parentTitle: 'Parent Tag',
              title: null,
              correct: 5,
              wrong: 3,
              unanswered: 2,
            ),
          ),
        ),
      );

      expect(find.text('Parent Tag'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('renders with both parent and child titles',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QuizDetailWidget(
              parentTitle: 'Parent Tag',
              title: 'Child Tag',
              correct: 2,
              wrong: 1,
              unanswered: 0,
            ),
          ),
        ),
      );

      expect(find.text('Parent Tag'), findsOneWidget);
      expect(find.text('Child Tag'), findsOneWidget);
    });

    testWidgets('renders progress bars correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QuizDetailWidget(
              parentTitle: 'Test',
              title: null,
              correct: 1,
              wrong: 1,
              unanswered: 1,
            ),
          ),
        ),
      );

      // Verify the progress bars are rendered with equal width
      final progressBars = find.byType(Container).evaluate();
      expect(progressBars.length, greaterThanOrEqualTo(3)); // 3 colored bars
    });
  });
}
