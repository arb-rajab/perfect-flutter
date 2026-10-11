import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/configs/locals.dart';
import 'package:beta/configs/colors.dart';
import 'package:beta/constants/route_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/home/browse_terms_tab_controller.dart';
import 'package:flash/flash_helper.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/infrastructure/firebase_repository.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import 'common/tests.dart';

// Renders the app screens with the real bundled font (jf_flat), RTL and shadows
// to PNG files, e.g. for the landing page gallery. Opt-in so regular test runs
// don't write files:
//   GEN_SCREENSHOTS=1 SHOT_DIR=out flutter test test/screenshots_test.dart
final generate = Platform.environment['GEN_SCREENSHOTS'] != null;
final outDir = Platform.environment['SHOT_DIR'] ?? 'build/screenshots';

class FakeFirebase extends FirebaseRepository {
  @override
  Future<String?> getToken() async => 'token';
  @override
  Future subscribeToTopic(String topic) async {}
  @override
  Future unSubscribeToTopic(String topic) async {}
  @override
  Stream<String> onTokenRefresh() => const Stream.empty();
}

Future<void> loadFonts() async {
  const base = 'build/unit_test_assets';
  final manifest = jsonDecode(File('$base/FontManifest.json').readAsStringSync()) as List;
  for (final family in manifest) {
    final loader = FontLoader(family['family'] as String);
    for (final font in family['fonts'] as List) {
      final bytes = File('$base/${font['asset']}').readAsBytesSync();
      loader.addFont(Future.value(ByteData.view(bytes.buffer)));
    }
    await loader.load();
  }
}

// Banner paints its label without a font family, so under flutter_test it falls
// back to the Ahem test font. Re-create its painter with the app font instead.
void fixBanners(WidgetTester t) {
  for (final w in t.widgetList<CustomPaint>(find.byType(CustomPaint))) {
    final painter = w.foregroundPainter;
    if (painter is! BannerPainter) continue;
    final ro = t.renderObject<RenderCustomPaint>(find.byWidget(w));
    ro.foregroundPainter = BannerPainter(
      message: painter.message,
      textDirection: painter.textDirection,
      location: painter.location,
      layoutDirection: painter.layoutDirection,
      color: painter.color,
      textStyle: painter.textStyle.copyWith(fontFamily: 'jf_flat'),
    );
  }
}

Future<void> shot(WidgetTester t, String name) async {
  fixBanners(t);
  await t.pump();
  await t.runAsync(() async {
    final boundary = t.renderObject<RenderRepaintBoundary>(find.byType(RepaintBoundary).first);
    final image = await boundary.toImage(pixelRatio: 3);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    await Directory(outDir).create(recursive: true);
    await File('$outDir/$name.png').writeAsBytes(bytes!.buffer.asUint8List());
  });
}

Term term(int id, String name, {int ordering = 1, int type = 0}) => Term(
    name: name, enabled: 1, id: id, uuid: 'u$id', type: type,
    creation: '2022-01-01 11:11:11', free: 1, ordering: ordering,
    needsUpdate: 0, captureable: 1, textCulumn: '', outerNote: '');

Future<void> pumpApp(WidgetTester t, String route) async {
  await t.pumpWidget(EasyLocalization(
    supportedLocales: supportedLocals,
    path: 'assets/translations',
    fallbackLocale: supportedLocals[0],
    child: Builder(
      builder: (context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router(route),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        builder: (context, child) =>
            Toast(navigatorKey: navigatorKey, child: child!),
        theme: FlexThemeData.light(
          primary: primaryColor,
          fontFamily: 'jf_flat',
          scheme: FlexScheme.greenM3,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 7,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 10,
            blendOnColors: false,
            useMaterial3Typography: true,
            useM2StyleDividerInM3: true,
            alignedDropdown: true,
            useInputDecoratorThemeInDialogs: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
        ),
      ),
    ),
  ));
  await settle(t);
}

Future<void> settle(WidgetTester t) async {
  for (var i = 0; i < 4; i++) {
    await t.runAsync(() => Future.delayed(const Duration(milliseconds: 300)));
    await t.pumpAndSettle();
  }
}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadFonts();
  setUp(() async {
    await initTests();
    await EasyLocalization.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('screen_protector'), (call) async => null);
  });

  Future seed() async {
    TermService termService = Get.find();
    TermsParentService tp = Get.find();
    QuestionService questionService = Get.find();
    AnswerService answerService = Get.find();
    FlashcardService flashcardService = Get.find();
    // id, name, type, parent
    final terms = <List<dynamic>>[
      [1, 'كلية طب الأسنان بدمشق', TermType.term, -1],
      [2, 'الفحص الوطني لطب الأسنان', TermType.term, -1],
      [10, 'الأطفال', TermType.questions, 1],
      [11, 'طب الفم', TermType.questions, 1],
      [12, 'التخدير والقلع', TermType.questions, 1],
      [13, 'المداواة المحافظة', TermType.questions, 1],
      [14, 'التعويضات الثابتة', TermType.questions, 1],
      [20, 'وطني 2024 دورة آذار', TermType.questions, 2],
      [21, 'وطني 2023 دورة كانون', TermType.questions, 2],
      [22, 'وطني 2023 دورة نيسان', TermType.questions, 2],
      [23, 'وطني 2022 دورة تشرين', TermType.questions, 2],
    ];
    await termService.addTerms([
      for (final t in terms)
        TermData(term(t[0], t[1], type: t[2], ordering: t[0]),
            deletedAt: const DeletedAt(null), visible: const Visible(1)),
    ]);
    await tp.addTermsParents([
      for (final t in terms)
        TermsParentData(
            TermsParent(termId: t[0], parentTermId: t[3], rootTermId: -1, creation: '2024-01-01 13:13:13'),
            deletedAt: const DeletedAt(null)),
    ]);
    final counts = {10: 48, 11: 36, 12: 52, 13: 41, 14: 27, 20: 30, 21: 30, 22: 30, 23: 30};
    final flash = {10: 19, 11: 22, 12: 14, 13: 17, 14: 9};
    var qid = 1;
    final qs = <Question>[];
    final fs = <Flashcard>[];
    // question, answers (first one is correct)
    final real = <List<String>>[
      ['المادة المستخدمة عادة كطبقة عازلة تحت الترميمات المعدنية العميقة هي:', 'إسمنت الزنك فوسفات', 'الأملغم', 'الراتنج المركب', 'الغلاس أيونومر المعدّل بالراتنج'],
      ['أي مما يلي يعدّ العلاج المفضّل للسن الحية ذات التسوّس العميق دون أعراض؟', 'التغطية اللبية غير المباشرة', 'سحب العصب الكامل', 'القلع', 'ترميم مباشر دون عازل'],
      ['ينصح بتطبيق مادة الفلورايد الموضعي للأطفال المعرّضين لخطر النخر بمعدل:', 'كل 3 إلى 6 أشهر', 'مرة واحدة في العمر', 'كل 5 سنوات', 'لا حاجة له'],
      ['يعتمد زمن تصلّب الراتنج المركب بالضوء بشكل رئيسي على:', 'شدة الضوء وسماكة الطبقة', 'لون الغرفة', 'حرارة الفم فقط', 'نوع المنشار'],
    ];
    var realIdx = 0;
    final answers = <Answer>[];
    counts.forEach((termId, n) {
      for (var i = 0; i < n; i++) {
        final useReal = termId == 13 && realIdx < real.length;
        qs.add(Question(
            id: qid, uuid: 'q$qid',
            title: useReal ? real[realIdx][0] : 'سؤال $qid', titleTranslation: '',
            labelId: 1, note: '', noteTranslation: '', parentTermId: termId,
            specialCharacter: 1, type: 1, edited: 0, imageUrl: '',
            creation: '2024-01-01 11:12:13', editionDate: ''));
        if (useReal) {
          for (var a = 1; a < real[realIdx].length; a++) {
            answers.add(Answer(
                id: qid * 10 + a, uuid: 'a$qid-$a', title: real[realIdx][a],
                titleTranslation: '', isCorrect: a == 1 ? 1 : 0,
                parentQuestionId: qid, specialCharacter: 1,
                creation: '2024-01-01 11:12:13', checkedCount: 10 * (6 - a)));
          }
          realIdx++;
        }
        qid++;
      }
    });
    flash.forEach((termId, n) {
      for (var i = 0; i < n; i++) {
        fs.add(Flashcard(id: termId * 100 + i, head: 'س', tail: 'ج', parentTermId: termId));
      }
    });
    await questionService.addQuestions(qs);
    await answerService.addAnswers(answers);
    await flashcardService.addFlashcards(fs);
  }

  testWidgets('landing page screenshots', skip: !generate, (t) async {
    debugDisableShadows = false;
    t.view.physicalSize = const Size(360 * 3, 640 * 3);
    t.view.devicePixelRatio = 3;
    addTearDown(t.view.reset);
    await seed();
    await pumpApp(t, HomeScreen.route);
    await shot(t, '1_home');

    await t.tap(find.text('كلية طب الأسنان بدمشق'));
    await settle(t);
    await shot(t, '2_topics');

    await t.tap(find.text('المداواة المحافظة'));
    await settle(t);
    await shot(t, '3_term');

    await t.tap(find.text('الأملغم').first);
    await settle(t);
    await t.tap(find.byIcon(Icons.check).first);
    await settle(t);
    await shot(t, '4_corrected');

    // back to the topics, then to the root and open the national exam
    await t.tap(find.byIcon(Icons.arrow_back).first);
    await settle(t);
    Get.find<BrowseTermsTabController>().onTabPopInvoked(false, null);
    await settle(t);
    await t.tap(find.text('الفحص الوطني لطب الأسنان'));
    await settle(t);
    await shot(t, '5_exams');

    await t.tap(find.byIcon(Icons.settings));
    await settle(t);
    await shot(t, '6_settings');

    debugDisableShadows = true;
  });
}
