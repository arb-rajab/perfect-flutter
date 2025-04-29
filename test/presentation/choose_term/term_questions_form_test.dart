import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/multi_select_selection.dart';
import 'package:beta/domain/term_question.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/main.dart';
import 'package:beta/presentation/choose_term/drop_down_button.dart';
import 'package:beta/presentation/choose_term/term_questions_form.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();
  List<MultiSelectSelection> randomSelections = [
    MultiSelectSelection(
        id: const Id(1), title: const t.Title('selection title 1')),
    MultiSelectSelection(
        id: const Id(2), title: const t.Title('selection title 2'))
  ];
  List<TermQuestion> defaultTermQuestions = [
    TermQuestion(
        id: const Id(1),
        title: const t.Title('title 1'),
        type: TermQuestionType.multiSelection,
        multiSelections: randomSelections)
  ];
  late List<TermQuestion> termQuestions;

  setUp(
    () {
      termQuestions = [...defaultTermQuestions];
    },
  );

  testWidgets('dialogue title is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
        child: TermQuestionsForm(
      termQuestions: termQuestions,
    )));
    await widgetTester.pumpAndSettle();
    expect(find.text(StringConstant.pleaseFillTheQuestionary), findsOneWidget);
  });

  testWidgets('drop down buttons count equals multi select questions count',
      (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
        child: TermQuestionsForm(
      termQuestions: termQuestions,
    )));
    await widgetTester.pumpAndSettle();
    expect(
        find.byType(DropDownButton),
        findsNWidgets(termQuestions
            .where(
                (question) => question.type == TermQuestionType.multiSelection)
            .length));
  });

  group('drop down tests', () {
    testWidgets('label is visible', (widgetTester) async {
      await widgetTester.pumpWidget(MyApp(
        child: TermQuestionsForm(
          termQuestions: termQuestions,
        ),
      ));
      await widgetTester.pumpAndSettle();
      for (TermQuestion termQuestion in termQuestions.where(
          (question) => question.type == TermQuestionType.multiSelection)) {
        expect(find.text(termQuestion.title.value!), findsOneWidget);
      }
    });

    testWidgets('first selection is visible by default', (widgetTester) async {
      await widgetTester.pumpWidget(MyApp(
        child: TermQuestionsForm(
          termQuestions: termQuestions,
        ),
      ));
      await widgetTester.pumpAndSettle();
      for (TermQuestion termQuestion in termQuestions.where(
          (question) => question.type == TermQuestionType.multiSelection)) {
        expect(find.text(termQuestion.multiSelections[0].title.value!),
            findsOneWidget);
        expect(find.text(termQuestion.multiSelections[1].title.value!),
            findsNothing);
      }
    });

    testWidgets('first selection is not visible once changed',
        (widgetTester) async {
      await widgetTester.pumpWidget(MyApp(
        child: TermQuestionsForm(
          termQuestions: termQuestions,
        ),
      ));
      await widgetTester.pumpAndSettle();
      for (TermQuestion termQuestion in termQuestions.where(
          (question) => question.type == TermQuestionType.multiSelection)) {
        await widgetTester
            .tap(find.text(termQuestion.multiSelections[0].title.value!));
        await widgetTester.pumpAndSettle();
        await widgetTester
            .tap(find.text(termQuestion.multiSelections[1].title.value!));
        await widgetTester.pumpAndSettle();
        expect(find.text(termQuestion.multiSelections[1].title.value!),
            findsOneWidget);
        expect(find.text(termQuestion.multiSelections[0].title.value!),
            findsNothing);
      }
    });

    testWidgets('first selection becomes visible once changed back',
        (widgetTester) async {
      await widgetTester.pumpWidget(MyApp(
        child: TermQuestionsForm(
          termQuestions: termQuestions,
        ),
      ));
      await widgetTester.pumpAndSettle();
      for (TermQuestion termQuestion in termQuestions.where(
          (question) => question.type == TermQuestionType.multiSelection)) {
        await widgetTester
            .tap(find.text(termQuestion.multiSelections[0].title.value!));
        await widgetTester.pumpAndSettle();
        await widgetTester
            .tap(find.text(termQuestion.multiSelections[1].title.value!));
        await widgetTester.pumpAndSettle();

        await widgetTester.pumpAndSettle();
        await widgetTester
            .tap(find.text(termQuestion.multiSelections[1].title.value!));
        await widgetTester.pumpAndSettle();
        await widgetTester
            .tap(find.text(termQuestion.multiSelections[0].title.value!));
        await widgetTester.pumpAndSettle();
        expect(find.text(termQuestion.multiSelections[0].title.value!),
            findsOneWidget);
        expect(find.text(termQuestion.multiSelections[1].title.value!),
            findsNothing);
      }
    });
  });
  testWidgets('ok button is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: TermQuestionsForm(
        termQuestions: termQuestions,
      ),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(StringConstant.ok), findsOneWidget);
  });
}
