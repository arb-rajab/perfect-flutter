import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/ebook_service.dart';
import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/application/services/path/shared.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/term_label_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/application/services/term_linked_to_label_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/application/services/voice_note_service.dart';
import 'package:beta/configs/links.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/ebook_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_label_data.dart';
import 'package:beta/domain/term_linked_to_label_data.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/domain/voice_note_data.dart';
import 'package:beta/infrastructure/url_launcher_repository.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/ebook/ebook_screen.dart';
import 'package:beta/presentation/flashcards/flashcards_screen.dart';
import 'package:beta/presentation/home/actions_widget.dart';
import 'package:beta/presentation/home/browse_terms_tab_controller.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/term_leading_widget.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/voice_note/voice_note_screen.dart';
import 'package:beta/presentation/widgets/number_of_children_widget.dart';
import 'package:beta/presentation/youtube_video/youtube_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  setUp(() async {
    await initTests();
  });

  tearDown(() async {
    await databaseService.deleteAllTables();
  });

  Future seedDisabledTerm() async {
    TermService termService = Get.find();
    await termService.addTerms([
      TermData(
          const Term(
              name: 'parent',
              //change this parameter to -
              enabled: 0,
              id: 1,
              uuid: 'a',
              type: 0,
              creation: '2022-01-01 11:11:11',
              free: 1,
              ordering: 1,
              needsUpdate: 0,
              captureable: 1,
              textCulumn: '',
              outerNote: 'outer note'),
          deletedAt: const DeletedAt(null),
          visible: const Visible(1))
    ]);
  }

  group('tapping term widget tests', () {
    group('disabled terms tests', () {
      testWidgets('tapping disabled terms shows a message',
          (widgetTester) async {
        TermService termService = Get.find();
        await databaseService.seedTermsData();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'parent',
                  enabled: 0,
                  id: 1,
                  uuid: 'a',
                  type: 0,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1)),
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.contentLocked),
            findsOneWidget);
        expect(find.widgetWithText(TermWidget, 'child'), findsNothing);
      });

      testWidgets('tapping disabled terms shows a message with telegram link',
          (widgetTester) async {
        TermService termService = Get.find();
        await databaseService.seedTermsData();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'parent',
                  enabled: 0,
                  id: 1,
                  uuid: 'a',
                  type: 0,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1)),
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the link
        await widgetTester.tap(find.byKey(const Key('ok')));
        await widgetTester.pumpAndSettle();

        UrlLauncherRepository urlLauncherRepository = Get.find();
        expect(urlLauncherRepository.openedUrl, telegramChannelLink);
      });
    });

    testWidgets('new term banner is not shown when term is accessed',
        (widgetTester) async {
      await databaseService.seedTermsData();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      BrowseTermsTabController browseTermsTabController = Get.find();
      browseTermsTabController.onTabPopInvoked(false, null);
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(Banner, 'parent'), findsNothing);
    });

    testWidgets('tapping a term, shows child terms', (widgetTester) async {
      await databaseService.seedTermsData();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(TermWidget, 'child'), findsNothing);
      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(TermWidget, 'parent'), findsNothing);
      expect(find.widgetWithText(TermWidget, 'child'), findsOneWidget);
    });

    group('tapping questions term', () {
      testWidgets(
          'tapping questions term that is not downloaded, shows a download term dialogue',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: 1,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(QuestionsScreen), findsNothing);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsOneWidget);
      });

      testWidgets(
          'tapping questions term that is not downloaded, shows a download term dialogue, then tapping ok dismisses the dialogue',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: 1,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(QuestionsScreen), findsNothing);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsOneWidget);

        await widgetTester.tap(find.byKey(const Key('ok')));
        await widgetTester.pumpAndSettle();
        expect(find.byType(OKDialogue), findsNothing);
      });

      testWidgets(
          'tapping questions term that is downloaded, shows questions screen',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        QuestionService questionService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: 1,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);
        await questionService.addQuestions([
          const Question(
              id: 1000,
              uuid: 'uuid',
              title: 'title',
              titleTranslation: 'titleTranslation',
              labelId: 1,
              note: 'note',
              noteTranslation: 'noteTranslation',
              parentTermId: 3,
              specialCharacter: 1,
              type: 1,
              edited: 1,
              imageUrl: '',
              creation: '2023-01-14 11:14:17',
              editionDate: '')
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(QuestionsScreen), findsOneWidget);
        expect(find.widgetWithText(AppBar, 'grand child'), findsOneWidget);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsNothing);
      });
    });

    group('tapping template term', () {
      testWidgets(
          'tapping template term that is not downloaded, shows a download term dialogue',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: 3,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(QuestionsScreen), findsNothing);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsOneWidget);
      });

      testWidgets(
          'tapping template term that is not downloaded, shows a download term dialogue, then tapping ok dismisses the dialogue',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: 3,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(QuestionsScreen), findsNothing);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsOneWidget);

        await widgetTester.tap(find.byKey(const Key('ok')));
        await widgetTester.pumpAndSettle();
        expect(find.byType(OKDialogue), findsNothing);
      });

      testWidgets(
          'tapping template term that is downloaded, shows questions screen',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        QuestionService questionService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: 3,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);
        await questionService.addQuestions([
          const Question(
              id: 1000,
              uuid: 'uuid',
              title: 'title',
              titleTranslation: 'titleTranslation',
              labelId: 1,
              note: 'note',
              noteTranslation: 'noteTranslation',
              parentTermId: 3,
              specialCharacter: 1,
              type: 1,
              edited: 1,
              imageUrl: '',
              creation: '2023-01-14 11:14:17',
              editionDate: '')
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(QuestionsScreen), findsOneWidget);
        expect(find.widgetWithText(AppBar, 'grand child'), findsOneWidget);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsNothing);
      });
    });

    group('tapping ebook term', () {
      testWidgets(
          'tapping term that is not downloaded, shows a download term dialogue',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: 2,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(EbookScreen), findsNothing);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsOneWidget);
      });

      testWidgets(
          'tapping term that is not downloaded, shows a download term dialogue, then tapping ok dismisses the dialogue',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: 2,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(EbookScreen), findsNothing);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsOneWidget);

        await widgetTester.tap(find.byKey(const Key('ok')));
        await widgetTester.pumpAndSettle();
        expect(find.byType(OKDialogue), findsNothing);
      });

      testWidgets('tapping expired term, shows a message',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  // changed this variable to 2
                  type: 2,
                  creation: '2022-01-01 11:11:11',
                  // changed this variable to 0
                  free: 0,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(EbookScreen), findsNothing);
        expect(find.widgetWithText(OKDialogue, StringConstant.termIsExpired),
            findsOneWidget);
      });

      testWidgets(
          'tapping expired term, shows a message, then tapping ok, dismisses the message',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  // changed this variable to 2
                  type: 2,
                  creation: '2022-01-01 11:11:11',
                  // changed this variable to 0
                  free: 0,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(EbookScreen), findsNothing);
        expect(find.widgetWithText(OKDialogue, StringConstant.termIsExpired),
            findsOneWidget);

        await widgetTester.tap(find.byKey(const Key('ok')));
        await widgetTester.pumpAndSettle();
        expect(find.byType(OKDialogue), findsNothing);
      });

      testWidgets('tapping unexpired term, opens ebook screen',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        EbookService ebookService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  // changed this variable to 2
                  type: 2,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);
        await ebookService.addEbook(EbookData(const Ebook(
            encryptionKey: 'encryptionKey',
            parentTermId: 3,
            creation: '2022-01-01 11:12:13',
            lastUpdated: '2024-01-01 11:12:13')));
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(EbookScreen), findsOneWidget);
        expect(find.widgetWithText(OKDialogue, StringConstant.termIsExpired),
            findsNothing);
      });
    });

    group('tapping youtube videos term', () {
      testWidgets('tapping expired term, shows a message',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  // changed this variable to 4
                  type: 4,
                  creation: '2022-01-01 11:11:11',
                  // changed this variable to 0
                  free: 0,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(YoutubeVideoScreen), findsNothing);
        expect(find.widgetWithText(OKDialogue, StringConstant.termIsExpired),
            findsOneWidget);
      });

      testWidgets(
          'tapping expired term, shows a message, then tapping ok, dismisses the message',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  // changed this variable to 4
                  type: 4,
                  creation: '2022-01-01 11:11:11',
                  // changed this variable to 0
                  free: 0,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(YoutubeVideoScreen), findsNothing);
        expect(find.widgetWithText(OKDialogue, StringConstant.termIsExpired),
            findsOneWidget);

        await widgetTester.tap(find.byKey(const Key('ok')));
        await widgetTester.pumpAndSettle();
        expect(find.byType(OKDialogue), findsNothing);
      });

      testWidgets('tapping unexpired term, shows a loading widget',
          (widgetTester) async {
        await databaseService.seedTermsData();
        mockNoConnection(
            route: ApiConstant.getYoutubeVideo.replaceFirst('(TERM_ID)', '3'));
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  // changed this variable to 4
                  type: 4,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(YoutubeVideoScreen), findsNothing);

        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'tapping unexpired term, shows no connection message when there is no connection',
          (widgetTester) async {
        await databaseService.seedTermsData();
        mockNoConnection(
            route: ApiConstant.getYoutubeVideo.replaceFirst('(TERM_ID)', '3'));
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  // changed this variable to 4
                  type: 4,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
      });

      testWidgets(
          'tapping unexpired term, shows a message when a message is recieved',
          (widgetTester) async {
        await databaseService.seedTermsData();
        dioAdapter
            .onGet(ApiConstant.getYoutubeVideo.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(
              200, r'''{"result":"failed","message":"a message recieved"}''');
        });
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  // changed this variable to 4
                  type: 4,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
      });

      testWidgets('tapping unexpired term, shows youtube video screen',
          (widgetTester) async {
        await databaseService.seedTermsData();
        dioAdapter
            .onGet(ApiConstant.getYoutubeVideo.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(200,
              r'''{"youtubeVideo":{"parentTermId":14,"videoId":"ybVkn2e4GmY","creation":"2023-03-06 20:30:34","onUpdate":"2023-11-03 18:38:08"},"result":"success","message":""}''');
        });
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  // changed this variable to 4
                  type: 4,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(YoutubeVideoScreen), findsOneWidget);
        expect(find.widgetWithText(AppBar, 'grand child'), findsOneWidget);
      });
    });

    group('tapping flashcards term', () {
      testWidgets(
          'tapping term that is not downloaded, shows a download term dialogue',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: TermType.flashcards,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(FlashcardsScreen), findsNothing);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsOneWidget);
      });

      testWidgets(
          'tapping term that is not downloaded, shows a download term dialogue, then tapping ok dismisses the dialogue',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: TermType.flashcards,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(FlashcardsScreen), findsNothing);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsOneWidget);

        await widgetTester.tap(find.byKey(const Key('ok')));
        await widgetTester.pumpAndSettle();
        expect(find.byType(OKDialogue), findsNothing);
      });

      testWidgets('tapping term that is downloaded, shows flashcards screen',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        FlashcardService flashcardService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: TermType.flashcards,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);
        await flashcardService.addFlashcards([
          const Flashcard(
            id: 1000,
            head: 'head',
            tail: 'tail',
            parentTermId: 3,
          )
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(FlashcardsScreen), findsOneWidget);
        expect(find.widgetWithText(AppBar, 'grand child'), findsOneWidget);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsNothing);
      });
    });

    group('tapping voice note term', () {
      testWidgets(
          'tapping term that is not downloaded, shows a download term dialogue',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: TermType.voiceNotes,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(VoiceNoteScreen), findsNothing);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsOneWidget);
      });

      testWidgets(
          'tapping term that is not downloaded, shows a download term dialogue, then tapping ok dismisses the dialogue',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: TermType.voiceNotes,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(VoiceNoteScreen), findsNothing);
        expect(
            find.widgetWithText(
                OKDialogue, StringConstant.youHaveToDownloadFirst),
            findsOneWidget);

        await widgetTester.tap(find.byKey(const Key('ok')));
        await widgetTester.pumpAndSettle();
        expect(find.byType(OKDialogue), findsNothing);
      });

      testWidgets('tapping expired term, shows a message',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: TermType.voiceNotes,
                  creation: '2022-01-01 11:11:11',
                  // changed this variable to 0
                  free: 0,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(VoiceNoteScreen), findsNothing);
        expect(find.widgetWithText(OKDialogue, StringConstant.termIsExpired),
            findsOneWidget);
      });

      testWidgets(
          'tapping expired term, shows a message, then tapping ok, dismisses the message',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: TermType.voiceNotes,
                  creation: '2022-01-01 11:11:11',
                  // changed this variable to 0
                  free: 0,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(VoiceNoteScreen), findsNothing);
        expect(find.widgetWithText(OKDialogue, StringConstant.termIsExpired),
            findsOneWidget);

        await widgetTester.tap(find.byKey(const Key('ok')));
        await widgetTester.pumpAndSettle();
        expect(find.byType(OKDialogue), findsNothing);
      });

      testWidgets('tapping unexpired term, opens voice notes screen',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        VoiceNoteService voiceNoteService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  name: 'grand child',
                  enabled: 1,
                  id: 3,
                  uuid: 'a',
                  type: TermType.voiceNotes,
                  creation: '2022-01-01 11:11:11',
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: '',
                  outerNote: ''),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);
        await voiceNoteService.addVoiceNote(VoiceNoteData(const VoiceNote(
            encryptionKey: '',
            parentTermId: 3,
            creation: '2022-01-01 11:12:13',
            lastUpdated: '2024-01-01 11:12:13')));
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        //tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        //tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        //tap the grand child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'grand child'));
        await widgetTester.pumpAndSettle();

        expect(find.byType(VoiceNoteScreen), findsOneWidget);
        expect(find.text('grand child'), findsOneWidget);
        expect(find.widgetWithText(OKDialogue, StringConstant.termIsExpired),
            findsNothing);
      });
    });
  });

  group('rendering tests', () {
    testWidgets('term leadign widget is rendered', (widgetTester) async {
      await databaseService.seedTermsData();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      expect(find.byType(TermLeadingWidget), findsAny);
    });

    testWidgets('term name is rendered', (widgetTester) async {
      await databaseService.seedTermsData();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(TermWidget, 'parent'), findsOneWidget);
    });

    testWidgets('term outer note is rendered', (widgetTester) async {
      await databaseService.seedTermsData();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(TermWidget, 'outer note'), findsOneWidget);
    });

    testWidgets('next arrow icon is rendered for enabled terms',
        (widgetTester) async {
      await databaseService.seedTermsData();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'parent', Icons.navigate_next),
          findsOneWidget);
    });

    testWidgets('lock icon is rendered for disabled terms',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await seedDisabledTerm();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'parent', Icons.lock),
          findsOneWidget);
    });

    testWidgets('number of children widget is rendered for enabled terms',
        (widgetTester) async {
      await databaseService.seedTermsData();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      expect(
          widgetWithTextAndWidget(TermWidget, 'parent', NumberOfChildrenWidget),
          findsOneWidget);
    });

    testWidgets('number of children widget is not rendered for disabled terms',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await seedDisabledTerm();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      expect(
          widgetWithTextAndWidget(TermWidget, 'parent', NumberOfChildrenWidget),
          findsNothing);
    });

    testWidgets('actions widget is rendered for enabled terms',
        (widgetTester) async {
      await databaseService.seedTermsData();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndWidget(TermWidget, 'parent', ActionsWidget),
          findsOneWidget);
    });

    testWidgets('actions widget is not rendered for disabled terms',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await seedDisabledTerm();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndWidget(TermWidget, 'parent', ActionsWidget),
          findsNothing);
    });

    group('term label tests', () {
      testWidgets(
          'term label is not rendered if there is no label for the term',
          (widgetTester) async {
        await databaseService.seedTermsData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndWidget(TermWidget, 'parent', LabelWidget),
            findsNothing);
      });

      testWidgets('term label is rendered if there is a label for the term',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermLabelService termLabelService = Get.find();
        TermLinkedToLabelService termLinkedToLabelService = Get.find();
        await termLabelService.addTermLabels([
          TermLabelData(const TermLabel(id: 1, name: 'label'),
              deletedAt: const DeletedAt(null))
        ]);
        await termLinkedToLabelService.addTermsLinkedToLabels([
          TermLinkedToLabelData(const TermsLinkedToLabel(termId: 1, labelId: 1),
              deletedAt: const DeletedAt(null))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndWidget(TermWidget, 'parent', LabelWidget),
            findsOneWidget);
        expect(find.widgetWithText(LabelWidget, 'label'), findsOneWidget);
      });

      testWidgets(
          'term label is rendered with text "others" if there is a label for the term and another term with no label',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        TermsParentService termsParentService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  id: 1000,
                  uuid: 'uuid',
                  name: 'parent 2',
                  type: TermType.term,
                  creation: '2024-01-01 11:13:17',
                  enabled: 1,
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: 'textCulumn',
                  outerNote: 'outerNote'),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1)),
          TermData(
              const Term(
                  id: 1001,
                  uuid: 'uuid',
                  name: 'child 2',
                  type: TermType.term,
                  creation: '2024-01-01 11:13:17',
                  enabled: 1,
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: 'textCulumn',
                  outerNote: 'outerNote'),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);
        await termsParentService.addTermsParents([
          TermsParentData(
              const TermsParent(
                  termId: 1000,
                  parentTermId: -1,
                  rootTermId: -1,
                  creation: '2024-01-01 11:12:13'),
              deletedAt: const DeletedAt(null)),
          TermsParentData(
              const TermsParent(
                  termId: 1001,
                  parentTermId: 1000,
                  rootTermId: -1,
                  creation: '2024-01-01 11:12:13'),
              deletedAt: const DeletedAt(null))
        ]);
        TermLabelService termLabelService = Get.find();
        TermLinkedToLabelService termLinkedToLabelService = Get.find();
        await termLabelService.addTermLabels([
          TermLabelData(const TermLabel(id: 1, name: 'label'),
              deletedAt: const DeletedAt(null))
        ]);
        await termLinkedToLabelService.addTermsLinkedToLabels([
          TermLinkedToLabelData(const TermsLinkedToLabel(termId: 1, labelId: 1),
              deletedAt: const DeletedAt(null))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndWidget(TermWidget, 'parent', LabelWidget),
            findsOneWidget);
        expect(find.widgetWithText(LabelWidget, 'label'), findsOneWidget);

        expect(widgetWithTextAndWidget(TermWidget, 'parent 2', LabelWidget),
            findsOneWidget);
        expect(find.widgetWithText(LabelWidget, StringConstant.others),
            findsOneWidget);
      });

      testWidgets(
          'term label is not rendered twice if there are more than one term with the same label',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        TermsParentService termsParentService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  id: 1000,
                  uuid: 'uuid',
                  name: 'parent 2',
                  type: TermType.term,
                  creation: '2010-01-01 11:13:17',
                  enabled: 1,
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: 'textCulumn',
                  outerNote: 'outerNote'),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1)),
          TermData(
              const Term(
                  id: 1001,
                  uuid: 'uuid',
                  name: 'child 2',
                  type: TermType.term,
                  creation: '2024-01-01 11:13:17',
                  enabled: 1,
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: 'textCulumn',
                  outerNote: 'outerNote'),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);
        await termsParentService.addTermsParents([
          TermsParentData(
              const TermsParent(
                  termId: 1000,
                  parentTermId: -1,
                  rootTermId: -1,
                  creation: '2024-01-01 11:12:13'),
              deletedAt: const DeletedAt(null)),
          TermsParentData(
              const TermsParent(
                  termId: 1001,
                  parentTermId: 1000,
                  rootTermId: -1,
                  creation: '2024-01-01 11:12:13'),
              deletedAt: const DeletedAt(null))
        ]);
        TermLabelService termLabelService = Get.find();
        TermLinkedToLabelService termLinkedToLabelService = Get.find();
        await termLabelService.addTermLabels([
          TermLabelData(const TermLabel(id: 1, name: 'label'),
              deletedAt: const DeletedAt(null))
        ]);
        await termLinkedToLabelService.addTermsLinkedToLabels([
          TermLinkedToLabelData(const TermsLinkedToLabel(termId: 1, labelId: 1),
              deletedAt: const DeletedAt(null))
        ]);
        await termLinkedToLabelService.addTermsLinkedToLabels([
          TermLinkedToLabelData(
              const TermsLinkedToLabel(termId: 1000, labelId: 1),
              deletedAt: const DeletedAt(null))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndWidget(TermWidget, 'parent', LabelWidget),
            findsOneWidget);
        expect(find.widgetWithText(LabelWidget, 'label'), findsOneWidget);

        expect(widgetWithTextAndWidget(TermWidget, 'parent 2', LabelWidget),
            findsNothing);
      });

      testWidgets('two different term labels are rendered',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermService termService = Get.find();
        TermsParentService termsParentService = Get.find();
        await termService.addTerms([
          TermData(
              const Term(
                  id: 1000,
                  uuid: 'uuid',
                  name: 'parent 2',
                  type: TermType.term,
                  creation: '2010-01-01 11:13:17',
                  enabled: 1,
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: 'textCulumn',
                  outerNote: 'outerNote'),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1)),
          TermData(
              const Term(
                  id: 1001,
                  uuid: 'uuid',
                  name: 'child 2',
                  type: TermType.term,
                  creation: '2024-01-01 11:13:17',
                  enabled: 1,
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: 'textCulumn',
                  outerNote: 'outerNote'),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1)),
          TermData(
              const Term(
                  id: 1002,
                  uuid: 'uuid',
                  name: 'parent 3',
                  type: TermType.term,
                  creation: '2018-01-01 11:13:17',
                  enabled: 1,
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: 'textCulumn',
                  outerNote: 'outerNote'),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1)),
          TermData(
              const Term(
                  id: 1003,
                  uuid: 'uuid',
                  name: 'child 3',
                  type: TermType.term,
                  creation: '2024-01-01 11:13:17',
                  enabled: 1,
                  free: 1,
                  ordering: 1,
                  needsUpdate: 0,
                  captureable: 1,
                  textCulumn: 'textCulumn',
                  outerNote: 'outerNote'),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1))
        ]);
        await termsParentService.addTermsParents([
          TermsParentData(
              const TermsParent(
                  termId: 1000,
                  parentTermId: -1,
                  rootTermId: -1,
                  creation: '2024-01-01 11:12:13'),
              deletedAt: const DeletedAt(null)),
          TermsParentData(
              const TermsParent(
                  termId: 1001,
                  parentTermId: 1000,
                  rootTermId: -1,
                  creation: '2024-01-01 11:12:13'),
              deletedAt: const DeletedAt(null)),
          TermsParentData(
              const TermsParent(
                  termId: 1002,
                  parentTermId: -1,
                  rootTermId: -1,
                  creation: '2024-01-01 11:12:13'),
              deletedAt: const DeletedAt(null)),
          TermsParentData(
              const TermsParent(
                  termId: 1003,
                  parentTermId: 1002,
                  rootTermId: -1,
                  creation: '2024-01-01 11:12:13'),
              deletedAt: const DeletedAt(null))
        ]);
        TermLabelService termLabelService = Get.find();
        TermLinkedToLabelService termLinkedToLabelService = Get.find();
        await termLabelService.addTermLabels([
          TermLabelData(const TermLabel(id: 1, name: 'label'),
              deletedAt: const DeletedAt(null))
        ]);
        await termLabelService.addTermLabels([
          TermLabelData(const TermLabel(id: 2, name: 'label 2'),
              deletedAt: const DeletedAt(null))
        ]);
        await termLinkedToLabelService.addTermsLinkedToLabels([
          TermLinkedToLabelData(const TermsLinkedToLabel(termId: 1, labelId: 1),
              deletedAt: const DeletedAt(null)),
          TermLinkedToLabelData(
              const TermsLinkedToLabel(termId: 1000, labelId: 1),
              deletedAt: const DeletedAt(null)),
          TermLinkedToLabelData(
              const TermsLinkedToLabel(termId: 1002, labelId: 2),
              deletedAt: const DeletedAt(null))
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndWidget(TermWidget, 'parent', LabelWidget),
            findsOneWidget);
        expect(find.widgetWithText(LabelWidget, 'label'), findsOneWidget);

        expect(widgetWithTextAndWidget(TermWidget, 'parent 2', LabelWidget),
            findsNothing);
        expect(widgetWithTextAndWidget(TermWidget, 'parent 3', LabelWidget),
            findsOneWidget);
        expect(find.widgetWithText(LabelWidget, 'label 2'), findsOneWidget);
      });
    });

    group('new label tests', () {
      testWidgets('new term banner is shown when term is not accessed',
          (widgetTester) async {
        await databaseService.seedTermsData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(Banner, 'parent'), findsOneWidget);
      });

      testWidgets('new term banner is not shown when term is accessed',
          (widgetTester) async {
        await databaseService.seedTermsData();
        TermLastAccessService termLastAccessService = Get.find();
        await termLastAccessService.addTermLastAccessed(
            const Id(1), const Id(1));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(Banner, 'parent'), findsNothing);
      });
    });

    testWidgets('unsupported content widget', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(child: UnsupportedContentWidget()));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.unsupportedContent), findsOneWidget);
      expect(find.text(StringConstant.unsupportedContentExplanation),
          findsOneWidget);
    });
  });
}
