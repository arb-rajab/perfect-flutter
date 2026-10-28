import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/domain/value/visible.dart';
import 'package:beta/infrastructure/screenshot/shared.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

import '../../common/tests.dart';

class RecordingScreenshotRepository extends ScreenshotRepository {
  final List<bool> calls = [];

  bool? get platformPrevented => calls.isEmpty ? null : calls.last;

  @override
  Future preventScreenshot() async => calls.add(true);

  @override
  Future allowScreenshot() async => calls.add(false);
}

Future main() async {
  late RecordingScreenshotRepository screenshotRepository;

  setUp(() async {
    await initTests();
    Get.delete<ScreenshotRepository>(force: true);
    screenshotRepository = RecordingScreenshotRepository();
    Get.put<ScreenshotRepository>(screenshotRepository);
  });

  Future seedTerm({required int captureable}) async {
    TermService termService = Get.find();
    await termService.addTerms([
      TermData(
        Term(
          id: 1,
          uuid: 'uuid',
          name: 'name',
          type: TermType.questions,
          creation: '2024-01-01 11:12:13',
          enabled: 1,
          free: 1,
          ordering: 1,
          needsUpdate: 0,
          captureable: captureable,
          textCulumn: 'textCulumn',
          outerNote: 'outerNote',
        ),
        deletedAt: const DeletedAt(null),
        visible: const Visible(1),
      ),
    ]);
    TermsParentService termsParentService = Get.find();
    await termsParentService.addTermsParents([
      TermsParentData(
        const TermsParent(
          termId: 1,
          parentTermId: -1,
          rootTermId: -1,
          creation: '2024-01-01 11:12:13',
        ),
        deletedAt: const DeletedAt(null),
      ),
    ]);
    QuestionService questionService = Get.find();
    await questionService.addQuestions([
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
        editionDate: '',
      ),
    ]);
  }

  Future pushQuestions(
    WidgetTester widgetTester, {
    required QuestionScreenSource source,
    required String query,
  }) async {
    Get.delete<QuestionsScreenArgument>();
    Get.put(
      QuestionsScreenArgument(
        query: query,
        source: source,
        sourceId: const Id(1),
        resourceTermId: const Id(1),
        title: const t.Title('name'),
      ),
    );
    navigatorKey.currentContext!.push(QuestionsScreen.route);
    await widgetTester.pumpAndSettle();
  }

  Future pushQuestionTagScreen(WidgetTester widgetTester, String query) =>
      pushQuestions(
        widgetTester,
        source: QuestionScreenSource.questionTag,
        query: query,
      );

  Future pushTermScreen(WidgetTester widgetTester) => pushQuestions(
    widgetTester,
    source: QuestionScreenSource.term,
    query: "q.parentTermId= '1' ORDER BY q.id asc",
  );

  Future pageBack(WidgetTester widgetTester) async {
    await widgetTester.pageBack();
    await widgetTester.pumpAndSettle();
  }

  testWidgets('protected question tag screens stay protected after popping a '
      'capturable term screen', (widgetTester) async {
    await seedTerm(captureable: 1);
    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await pushQuestionTagScreen(widgetTester, "q.parentTermId= '1'");
    expect(screenshotRepository.platformPrevented, true);

    await pushQuestionTagScreen(widgetTester, "q.parentTermId= '1' and 1=1");
    expect(screenshotRepository.platformPrevented, true);

    await pushTermScreen(widgetTester);
    expect(find.byType(QuestionsScreen), findsOneWidget);
    expect(screenshotRepository.platformPrevented, false);

    await pageBack(widgetTester);
    expect(screenshotRepository.platformPrevented, true);

    await pageBack(widgetTester);
    expect(screenshotRepository.platformPrevented, true);

    await pageBack(widgetTester);
    expect(find.byType(QuestionsScreen), findsNothing);
    expect(screenshotRepository.platformPrevented, false);
  });

  testWidgets('a non capturable term screen is protected', (
    widgetTester,
  ) async {
    await seedTerm(captureable: 0);
    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await pushTermScreen(widgetTester);
    expect(screenshotRepository.platformPrevented, true);

    await pageBack(widgetTester);
    expect(screenshotRepository.platformPrevented, false);
  });
}
