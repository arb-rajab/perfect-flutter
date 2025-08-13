import 'dart:async';

import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/questions_report/questions_report_screen.dart';
import 'package:beta/presentation/questions_report/quiz_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../common/tests.dart';
import 'test_helpers.dart';

void main() {
  late QuestionsReportScreenArgument testArguments;

  setUp(() async {
    await initTests();
    testArguments = QuestionsReportScreenArgument(
        questions: createTestQuestions(),
        timer: Timer(const Duration(seconds: 60), () {}));
    Get.put(testArguments);
  });

  tearDown(() {
    Get.reset();
  });

  group('QuestionsReportScreen', () {
    testWidgets('renders correctly with questions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: QuestionsReportScreen()),
      );

      expect(find.text(StringConstant.quizReport), findsOneWidget);
      expect(find.byType(QuizDetailWidget),
          findsNWidgets(4)); // Header + 3 questions
      await tester.pumpAndSettle();
    });

    testWidgets('shows tag hierarchy correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: QuestionsReportScreen(),
        ),
      );

      expect(find.text('Parent Tag'), findsOneWidget);
      expect(find.text('Child Tag'), findsOneWidget);
      expect(find.text(StringConstant.noTagsQuestions), findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
