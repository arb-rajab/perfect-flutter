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
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import 'common/tests.dart';

// Renders store screenshots (phone, 7" and 10" tablet) with the real bundled
// font (jf_flat), RTL and shadows. Opt-in so regular test runs don't write
// files:
//   for d in phone tablet_7 tablet_10; do
//     GEN_SCREENSHOTS=1 SHOT_DIR=out flutter test test/store_screenshots_test.dart --plain-name $d
//   done
// (one process per device: state left over from a previous test breaks the next)
final generate = Platform.environment['GEN_SCREENSHOTS'] != null;
final outDir = Platform.environment['SHOT_DIR'] ?? 'build/store_screenshots';

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
    final boundary = t.renderObject<RenderRepaintBoundary>(find.byKey(rootKey));
    final image = await boundary.toImage(pixelRatio: t.view.devicePixelRatio);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final file = File('$outDir/$name.png');
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes!.buffer.asUint8List());
  });
}

Term term(int id, String name, {int ordering = 1, int type = 0}) => Term(
    name: name, enabled: 1, id: id, uuid: 'u$id', type: type,
    creation: '2022-01-01 11:11:11', free: 1, ordering: ordering,
    needsUpdate: 0, captureable: 1, textCulumn: '', outerNote: '');

final themeMode = ValueNotifier(ThemeMode.light);
final rootKey = GlobalKey();

Future<void> pumpApp(WidgetTester t, String route) async {
  themeMode.value = ThemeMode.light;
  const subThemes = FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    useMaterial3Typography: true,
    useM2StyleDividerInM3: true,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
  );
  final routerConfig = router(route);
  await t.pumpWidget(RepaintBoundary(
      key: rootKey,
      child: EasyLocalization(
    supportedLocales: supportedLocals,
    path: 'assets/translations',
    fallbackLocale: supportedLocals[0],
    child: Builder(
      builder: (context) => ValueListenableBuilder<ThemeMode>(
        valueListenable: themeMode,
        builder: (context, mode, _) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfig,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          themeMode: mode,
          builder: (context, child) =>
              Toast(navigatorKey: navigatorKey, child: child!),
          theme: FlexThemeData.light(
            primary: primaryColor,
            fontFamily: 'jf_flat',
            scheme: FlexScheme.greenM3,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 7,
            subThemesData: subThemes,
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
            useMaterial3: true,
            swapLegacyOnMaterial3: true,
          ),
          darkTheme: FlexThemeData.dark(
            scheme: FlexScheme.greenM3,
            fontFamily: 'jf_flat',
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 13,
            subThemesData: subThemes,
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
            useMaterial3: true,
            swapLegacyOnMaterial3: true,
          ),
        ),
      ),
    ),
  )));
  await settle(t);
}

Future<void> tapText(WidgetTester t, String text) async {
  final finder = find.text(text).first;
  await t.ensureVisible(finder);
  await t.pumpAndSettle();
  await t.tap(finder);
}

Future<void> settle(WidgetTester t) async {
  for (var i = 0; i < 4; i++) {
    await t.runAsync(() => Future.delayed(const Duration(milliseconds: 300)));
    await t.pumpAndSettle();
  }
}

class Device {
  final String name;
  final Size logical;
  final double ratio;
  const Device(this.name, this.logical, this.ratio);
}

// Google Play sizes: phone 1080x1920, 7" tablet 1200x1920, 10" tablet 1600x2560.
const devices = [
  Device('phone', Size(360, 640), 3),
  Device('tablet_7', Size(600, 960), 2),
  Device('tablet_10', Size(800, 1280), 2),
];

const flashcardsData = <List<String>>[
  ['ما هي المادة المفضّلة لتطهير القناة الجذرية أثناء المعالجة اللبية؟', 'هيبوكلوريت الصوديوم بتركيز 2.5–5.25%'],
  ['كم تبلغ المدة الموصى بها للتصلّب الضوئي لطبقة راتنج مركب بسماكة 2 مم؟', '20–40 ثانية حسب شدة الضوء ولون الراتنج'],
  ['ما هو التسوّس الأولي القابل للعكس؟', 'بقعة بيضاء كلسية على الميناء دون تكهّف، تُعالج بالفلورايد الموضعي'],
  ['ما هي الجرعة العظمى لليدوكائين مع الأدرينالين؟', '7 ملغ/كغ من وزن الجسم، وبحد أقصى 500 ملغ'],
  ['ما هو الاستطباب الرئيسي للتاج الفولاذي في الأسنان اللبنية؟', 'الترميم بعد المعالجة اللبية أو التسوّس الواسع في الرحى اللبنية'],
  ['ما الفرق بين الأملغم والراتنج المركب من حيث الالتصاق؟', 'الأملغم لا يلتصق بالسن ويعتمد على الاحتباس الميكانيكي، بينما يلتصق الراتنج بالمادة اللاصقة'],
];

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
      [3, 'بطاقات المراجعة', TermType.flashcards, -1],
      [4, 'اختبارات تجريبية شاملة', TermType.questions, -1],
      [5, 'ملخصات الأمراض الفموية', TermType.flashcards, -1],
      [6, 'الأشعة السنية', TermType.questions, -1],
      [7, 'علم الأدوية السنية', TermType.questions, -1],
      [8, 'التشريح الفموي', TermType.questions, -1],
      [15, 'التقويم', TermType.questions, 1],
      [16, 'أمراض النسج الداعمة', TermType.questions, 1],
      [17, 'الجراحة الفموية', TermType.questions, 1],
      [18, 'الأشعة', TermType.questions, 1],
      [24, 'وطني 2022 دورة أيار', TermType.questions, 2],
      [25, 'وطني 2021 دورة تشرين', TermType.questions, 2],
      [26, 'وطني 2021 دورة أيار', TermType.questions, 2],
      [27, 'وطني 2020 دورة تشرين', TermType.questions, 2],
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
    final counts = {6: 24, 7: 33, 8: 29, 15: 31, 16: 38, 17: 44, 18: 22, 24: 30, 25: 30, 26: 30, 27: 30, 4: 60, 10: 48, 11: 36, 12: 52, 13: 41, 14: 27, 20: 30, 21: 30, 22: 30, 23: 30};
    // question, answers (first one is correct)
    final real = <List<String>>[
      ['المادة المستخدمة عادة كطبقة عازلة تحت الترميمات المعدنية العميقة هي:', 'إسمنت الزنك فوسفات', 'الأملغم', 'الراتنج المركب', 'الغلاس أيونومر المعدّل بالراتنج'],
      ['أي مما يلي يعدّ العلاج المفضّل للسن الحية ذات التسوّس العميق دون أعراض؟', 'التغطية اللبية غير المباشرة', 'سحب العصب الكامل', 'القلع', 'ترميم مباشر دون عازل'],
      ['ينصح بتطبيق مادة الفلورايد الموضعي للأطفال المعرّضين لخطر النخر بمعدل:', 'كل 3 إلى 6 أشهر', 'مرة واحدة في العمر', 'كل 5 سنوات', 'لا حاجة له'],
      ['يعتمد زمن تصلّب الراتنج المركب بالضوء بشكل رئيسي على:', 'شدة الضوء وسماكة الطبقة', 'لون الغرفة', 'حرارة الفم فقط', 'نوع المنشار'],
    ];
    var realIdx = 0;
    var qid = 1;
    final qs = <Question>[];
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
    final fs = <Flashcard>[
      for (var i = 0; i < 30; i++)
        Flashcard(
            id: i + 1,
            head: i < flashcardsData.length ? flashcardsData[i][0] : 'سؤال المراجعة ${i + 1}',
            tail: i < flashcardsData.length ? flashcardsData[i][1] : 'الجواب ${i + 1}',
            parentTermId: 3),
      for (var i = 0; i < 20; i++)
        Flashcard(id: 100 + i, head: 'مراجعة ${i + 1}', tail: 'ملخص ${i + 1}', parentTermId: 5),
    ];
    await questionService.addQuestions(qs);
    await answerService.addAnswers(answers);
    await flashcardService.addFlashcards(fs);
  }

  for (final device in devices) {
    testWidgets('store screenshots: ${device.name}', skip: !generate, (t) async {
      debugDisableShadows = false;
      t.view.physicalSize = device.logical * device.ratio;
      t.view.devicePixelRatio = device.ratio;
      addTearDown(t.view.reset);
      final n = device.name;
      await seed();
      await pumpApp(t, HomeScreen.route);
      await shot(t, '$n/01_browse');

      await tapText(t, 'كلية طب الأسنان بدمشق');
      await settle(t);
      await shot(t, '$n/02_topics');

      await tapText(t, 'المداواة المحافظة');
      await settle(t);
      await shot(t, '$n/03_quiz');

      await t.tap(find.text('الأملغم').first);
      await settle(t);
      await t.tap(find.byIcon(Icons.check).first);
      await settle(t);
      await shot(t, '$n/04_correction');

      themeMode.value = ThemeMode.dark;
      await settle(t);
      await shot(t, '$n/05_dark_mode');
      themeMode.value = ThemeMode.light;
      await settle(t);

      // back to the topics, then to the root
      await t.tap(find.byIcon(Icons.arrow_back).first);
      await settle(t);
      Get.find<BrowseTermsTabController>().onTabPopInvoked(false, null);
      await settle(t);

      await tapText(t, 'بطاقات المراجعة');
      await settle(t);
      await shot(t, '$n/06_flashcards');
      await t.tap(find.byIcon(Icons.arrow_back).first);
      await settle(t);

      await tapText(t, 'الفحص الوطني لطب الأسنان');
      await settle(t);
      await shot(t, '$n/07_exams');

      await t.tap(find.text('تصفح'));
      await settle(t);
      await shot(t, '$n/08_content_menu');
      debugDisableShadows = true;
    });
  }
}
