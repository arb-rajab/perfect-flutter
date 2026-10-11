import 'dart:math';

import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/application/services/image_service.dart';
import 'package:beta/application/services/path/shared.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/related_term_service.dart';
import 'package:beta/application/services/term_property_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/related_term_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/home/browse_terms_tab_controller.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:beta/presentation/homework/homework_screen.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() {
  setUp(() async {
    await initTests();
  });

  Future createTermData({required int type, int needsUpdate = 0}) async {
    TermService termService = Get.find();
    await databaseService.seedTermsData();
    await termService.addTerms([
      TermData(
          Term(
            captureable: 1,
            id: 3,
            uuid: 'uuid',
            name: 'name',
            type: type,
            creation: '2022-01-01 11:13:15',
            enabled: 1,
            free: 1,
            ordering: 1,
            needsUpdate: needsUpdate,
            textCulumn: '',
            outerNote: '',
          ),
          deletedAt: const DeletedAt(null),
          visible: const Visible(1))
    ]);
  }

  group('delete icon tests', () {
    testWidgets('delete icon is not rendered for term type',
        (widgetTester) async {
      await createTermData(type: TermType.term);
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
          findsNothing);
    });

    group('questions term type', () {
      testWidgets(
          'delete icon is not rendered for questions term type that is not downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.questions);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets(
          'delete icon is rendered for questions term type that is downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.questions);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
      });

      testWidgets('delete icon tap shows a confirmation dialogue',
          (widgetTester) async {
        await createTermData(type: TermType.questions);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsOneWidget);
      });

      testWidgets(
          'delete icon tap shows a confirmation dialogue, then tapping cancel dismisses the dialogue',
          (widgetTester) async {
        await createTermData(type: TermType.questions);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        // tap cancel buuton
        await widgetTester.tap(find.text(StringConstant.cancel));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing);
      });

      testWidgets(
          'delete icon tap shows a confirmation dialogue, then tapping ok dismisses the dialogue and deletes data',
          (widgetTester) async {
        await createTermData(type: TermType.questions);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        // tap ok buuton
        await widgetTester.tap(find.text(StringConstant.ok));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
      });
    });

    group('ebooks term type', () {
      testWidgets(
          'delete icon is not rendered for ebooks term type that is not downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.ebook);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets(
          'delete icon is rendered for ebook term type that is downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.ebook);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
      });

      testWidgets('delete icon tap shows a confirmation dialogue',
          (widgetTester) async {
        await createTermData(type: TermType.ebook);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsOneWidget);
      });

      testWidgets(
          'delete icon tap shows a confirmation dialogue, then tapping cancel dismisses the dialogue',
          (widgetTester) async {
        await createTermData(type: TermType.ebook);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        // tap cancel buuton
        await widgetTester.tap(find.text(StringConstant.cancel));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing);
      });

      testWidgets(
          'delete icon tap shows a confirmation dialogue, then tapping ok dismisses the dialogue and deletes data',
          (widgetTester) async {
        await createTermData(type: TermType.ebook);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        // tap ok buuton
        await widgetTester.tap(find.text(StringConstant.ok));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
      });
    });

    group('template term type', () {
      testWidgets(
          'delete icon is not rendered for template term type that is not downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.template);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets(
          'delete icon is rendered for template term type that is downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.template);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
      });

      testWidgets('delete icon tap shows a confirmation dialogue',
          (widgetTester) async {
        await createTermData(type: TermType.template);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsOneWidget);
      });

      testWidgets(
          'delete icon tap shows a confirmation dialogue, then tapping cancel dismisses the dialogue',
          (widgetTester) async {
        await createTermData(type: TermType.template);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        // tap cancel buuton
        await widgetTester.tap(find.text(StringConstant.cancel));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing);
      });

      testWidgets(
          'delete icon tap shows a confirmation dialogue, then tapping ok dismisses the dialogue and deletes data',
          (widgetTester) async {
        await createTermData(type: TermType.template);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        // tap ok buuton
        await widgetTester.tap(find.text(StringConstant.ok));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
      });
    });

    testWidgets('delete icon is not rendered for youtube videos term type',
        (widgetTester) async {
      await createTermData(type: TermType.youtubeVideos);
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
          findsNothing);
    });

    group('flashcards term type', () {
      testWidgets(
          'delete icon is not rendered for flashcards term type that is not downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets(
          'delete icon is rendered for flashcards term type that is downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards);
        FlashcardService flashcardService = Get.find();
        await flashcardService.addFlashcards([
          const Flashcard(id: 1000, head: 'head', tail: 'tail', parentTermId: 3)
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
      });

      testWidgets('delete icon tap shows a confirmation dialogue',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards);
        FlashcardService flashcardService = Get.find();
        await flashcardService.addFlashcards([
          const Flashcard(id: 1000, head: 'head', tail: 'tail', parentTermId: 3)
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsOneWidget);
      });

      testWidgets(
          'delete icon tap shows a confirmation dialogue, then tapping cancel dismisses the dialogue',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards);
        FlashcardService flashcardService = Get.find();
        await flashcardService.addFlashcards([
          const Flashcard(id: 1000, head: 'head', tail: 'tail', parentTermId: 3)
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        // tap cancel buuton
        await widgetTester.tap(find.text(StringConstant.cancel));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing);
      });

      testWidgets(
          'delete icon tap shows a confirmation dialogue, then tapping ok dismisses the dialogue and deletes data',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards);
        FlashcardService flashcardService = Get.find();
        await flashcardService.addFlashcards([
          const Flashcard(id: 1000, head: 'head', tail: 'tail', parentTermId: 3)
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        // tap ok buuton
        await widgetTester.tap(find.text(StringConstant.ok));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
      });
    });

group('images term type', () {
      testWidgets(
        'delete icon is not rendered for images term type that is not downloaded',
        (widgetTester) async {
          await createTermData(type: TermType.images);
          await widgetTester.pumpWidget(
            const MyApp(defaultRoute: HomeScreen.route),
          );
          await widgetTester.pumpAndSettle();

          // tap the parent term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
          await widgetTester.pumpAndSettle();

          // tap the child term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
          await widgetTester.pumpAndSettle();

          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing,
          );
        },
      );

      testWidgets(
        'delete icon is rendered for images term type that is downloaded',
        (widgetTester) async {
          await createTermData(type: TermType.images);
          ImageService imageService = Get.find();
          await imageService.addImages([
            const Image(
              id: 1000,
              url: 'url',
              title: 'title',
              info: 'info',
              parentTermId: 3,
            ),
          ]);
          await widgetTester.pumpWidget(
            const MyApp(defaultRoute: HomeScreen.route),
          );
          await widgetTester.pumpAndSettle();

          // tap the parent term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
          await widgetTester.pumpAndSettle();

          // tap the child term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
          await widgetTester.pumpAndSettle();

          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget,
          );
        },
      );

      testWidgets('delete icon tap shows a confirmation dialogue', (
        widgetTester,
      ) async {
        await createTermData(type: TermType.images);
        ImageService imageService = Get.find();
        await imageService.addImages([
          const Image(
            id: 1000,
            url: 'url',
            title: 'title',
            info: 'info',
            parentTermId: 3,
          ),
        ]);

        await widgetTester.pumpWidget(
          const MyApp(defaultRoute: HomeScreen.route),
        );
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsOneWidget);
      });

      testWidgets(
        'delete icon tap shows a confirmation dialogue, then tapping cancel dismisses the dialogue',
        (widgetTester) async {
          await createTermData(type: TermType.images);
          ImageService imageService = Get.find();
          await imageService.addImages([
            const Image(
              id: 1000,
              url: 'url',
              title: 'title',
              info: 'info',
              parentTermId: 3,
            ),
          ]);

          await widgetTester.pumpWidget(
            const MyApp(defaultRoute: HomeScreen.route),
          );
          await widgetTester.pumpAndSettle();

          // tap the parent term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
          await widgetTester.pumpAndSettle();

          // tap the child term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
          await widgetTester.pumpAndSettle();

          // tap the delete icon
          await widgetTester.tap(find.byIcon(Icons.delete));
          await widgetTester.pumpAndSettle();

          // tap cancel buuton
          await widgetTester.tap(find.text(StringConstant.cancel));
          await widgetTester.pumpAndSettle();

          expect(find.byType(ConfirmDialogue), findsNothing);
          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget,
          );
          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing,
          );
        },
      );

      testWidgets(
        'delete icon tap shows a confirmation dialogue, then tapping ok dismisses the dialogue and deletes data',
        (widgetTester) async {
          await createTermData(type: TermType.images);
          ImageService imageService = Get.find();
          await imageService.addImages([
            const Image(
              id: 1000,
              url: 'url',
              title: 'title',
              info: 'info',
              parentTermId: 3,
            ),
          ]);

          await widgetTester.pumpWidget(
            const MyApp(defaultRoute: HomeScreen.route),
          );
          await widgetTester.pumpAndSettle();

          // tap the parent term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
          await widgetTester.pumpAndSettle();

          // tap the child term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
          await widgetTester.pumpAndSettle();

          // tap the delete icon
          await widgetTester.tap(find.byIcon(Icons.delete));
          await widgetTester.pumpAndSettle();

          // tap ok buuton
          await widgetTester.tap(find.text(StringConstant.ok));
          await widgetTester.pumpAndSettle();

          expect(find.byType(ConfirmDialogue), findsNothing);
          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing,
          );
          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget,
          );
        },
      );
    });

    group('voice notes term type', () {
      testWidgets(
          'delete icon is not rendered for voice notes term type that is not downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets(
          'delete icon is rendered for voice notes term type that is downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
      });

      testWidgets('delete icon tap shows a confirmation dialogue',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsOneWidget);
      });

      testWidgets(
          'delete icon tap shows a confirmation dialogue, then tapping cancel dismisses the dialogue',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        // tap cancel buuton
        await widgetTester.tap(find.text(StringConstant.cancel));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing);
      });

      testWidgets(
          'delete icon tap shows a confirmation dialogue, then tapping ok dismisses the dialogue and deletes data',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        // tap ok buuton
        await widgetTester.tap(find.text(StringConstant.ok));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
      });
    });
  
    group('video file term type', () {
      testWidgets(
          'delete icon is not rendered for video file term type that is not downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets(
          'delete icon is rendered for video file term type that is downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
      });

      testWidgets('delete icon tap shows a confirmation dialogue',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsOneWidget);
      });

      testWidgets(
          'delete icon tap shows a confirmation dialogue, then tapping cancel dismisses the dialogue',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        // tap cancel buuton
        await widgetTester.tap(find.text(StringConstant.cancel));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing);
      });

      testWidgets(
          'delete icon tap shows a confirmation dialogue, then tapping ok dismisses the dialogue and deletes data',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap the delete icon
        await widgetTester.tap(find.byIcon(Icons.delete));
        await widgetTester.pumpAndSettle();

        // tap ok buuton
        await widgetTester.tap(find.text(StringConstant.ok));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ConfirmDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
      });
    });
  
  });

  group('download icon tests', () {
    testWidgets('download icon is not rendered for term type',
        (widgetTester) async {
      await createTermData(type: TermType.term);
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
          findsNothing);
    });

    group('questions term type tests', () {
      testWidgets('download icon is rendered for questions term type',
          (widgetTester) async {
        await createTermData(type: TermType.questions);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
      });

      testWidgets('download icon tapping shows a loading',
          (widgetTester) async {
        await createTermData(type: TermType.questions);
        dioAdapter
            .onGet(ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(
              200,
              r'''
{
    "questions": [{
        "id": 1000,
        "uuid": "1746f77a31bd6da4a80fe09a5e77a479",
        "title": "في أي من كسور الفك السفلي يرجع اللسان إلى الخلف: إجابة صحيحة واحدة:",
        "titleTranslation": "",
        "specialCharacter": 1,
        "type": 1,
        "labelId": 1,
        "note": "",
        "noteTranslation": "",
        "edited": 0,
        "controversial": 0,
        "editionDate": "0000-00-00 00:00:00",
        "imageUrl": "",
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null,
        "parentTermId": 3,
        "ordering": 120
    }],
    "flashcards": [],
    "images": [],
    "answers": [{
        "id": 10466304,
        "uuid": "1e1de905de436dd1b4e2445968d5bcfa",
        "title": "نقصان الغلوبولينات المناعية في اللعاب",
        "titleTranslation": "aaaa",
        "specialCharacter": 1,
        "isCorrect": 1,
        "parentQuestionId": 1000,
        "checkedCount": 100,
        "creation": "2023-12-07 08:33:09",
        "onUpdate": "2025-02-21 08:28:37",
        "deleted_at": null,
        "deleted_by": null
    }],
    "media": [],
    "questionsLinkedToTags": [{
        "questionId": 1000,
        "tagId": 1000,
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null
    }],
    "questionTags": [{
        "id": 1000,
        "name": "الكم بوزيت وتحضيراتها",
        "parentTermId": 10,
        "parentTagId": 0,
        "color": 4216570,
        "creation": "2023-03-15 19:46:09",
        "hasInformation": 0
    }],
    "result": "success",
    "message": ""
}
''',
              delay: const Duration(seconds: 1));
        });
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pump();

        expect(
            widgetWithTextAndWidget(
                TermWidget, 'name', CircularProgressIndicator),
            findsOneWidget);
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'download icon tapping shows no connection when there is no connection',
          (widgetTester) async {
        await createTermData(type: TermType.questions);
        mockNoConnection(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets(
          'download icon tapping shows a message when a message is recieved',
          (widgetTester) async {
        await createTermData(type: TermType.questions);
        mockMessageRecieved(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets('download icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.questions);

        dioAdapter
            .onGet(ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(200, r'''
{
    "questions": [{
        "id": 1000,
        "uuid": "1746f77a31bd6da4a80fe09a5e77a479",
        "title": "في أي من كسور الفك السفلي يرجع اللسان إلى الخلف: إجابة صحيحة واحدة:",
        "titleTranslation": "",
        "specialCharacter": 1,
        "type": 1,
        "labelId": 1,
        "note": "",
        "noteTranslation": "",
        "edited": 0,
        "controversial": 0,
        "editionDate": "0000-00-00 00:00:00",
        "imageUrl": "",
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null,
        "parentTermId": 3,
        "ordering": 120
    }],
    "flashcards": [],
    "images": [],
    "answers": [{
        "id": 10466304,
        "uuid": "1e1de905de436dd1b4e2445968d5bcfa",
        "title": "نقصان الغلوبولينات المناعية في اللعاب",
        "titleTranslation": "aaaa",
        "specialCharacter": 1,
        "isCorrect": 1,
        "parentQuestionId": 1000,
        "checkedCount": 100,
        "creation": "2023-12-07 08:33:09",
        "onUpdate": "2025-02-21 08:28:37",
        "deleted_at": null,
        "deleted_by": null
    }],
    "media": [],
    "questionsLinkedToTags": [{
        "questionId": 1000,
        "tagId": 1000,
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null
    }],
    "questionTags": [{
        "id": 1000,
        "name": "الكم بوزيت وتحضيراتها",
        "parentTermId": 10,
        "parentTagId": 0,
        "color": 4216570,
        "creation": "2023-03-15 19:46:09",
        "hasInformation": 0
    }],
    "result": "success",
    "message": ""
}
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
      });
    });

    group('ebooks term type tests', () {
      testWidgets('download icon is rendered for ebooks term type',
          (widgetTester) async {
        await createTermData(type: TermType.ebook);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
      });

      testWidgets('download icon tapping shows a loading',
          (widgetTester) async {
        await createTermData(type: TermType.ebook);
        mockNoConnection(
            route: ApiConstant.getEbook.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pump();

        expect(
            widgetWithTextAndWidget(
                TermWidget, 'name', CircularProgressIndicator),
            findsOneWidget);
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'download icon tapping shows no connection when there is no connection',
          (widgetTester) async {
        await createTermData(type: TermType.ebook);
        mockNoConnection(
            route: ApiConstant.getEbook.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets(
          'download icon tapping shows a message when a message is recieved',
          (widgetTester) async {
        await createTermData(type: TermType.ebook);
        mockMessageRecieved(
            route: ApiConstant.getEbook.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets('download icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.ebook);

        dioAdapter.onGet(
            "http://perfect-app.atwebpages.com/files/terms/10003581", (server) {
          server.reply(200, 'file content');
        });

        dioAdapter.onGet(ApiConstant.getEbook.replaceFirst('(TERM_ID)', '3'),
            (server) {
          server.reply(200, r'''
{
    "ebook": {
        "parentTermId": 3,
        "url": "http:\/\/perfect-app.atwebpages.com\/files\/terms\/10003581",
        "encryptionKey": "",
        "creation": "2024-08-30T12:44:08.000000Z",
        "onUpdate": "2024-08-30T12:46:28.000000Z",
        "deleted_at": null,
        "deleted_by": null
    },
    "result": "success",
    "message": ""
}
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing);
      });
    });

    group('template term type tests', () {
      testWidgets('download icon is rendered for template term type',
          (widgetTester) async {
        await createTermData(type: TermType.template);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
      });

      testWidgets('download icon tapping shows a loading',
          (widgetTester) async {
        await createTermData(type: TermType.template);
        dioAdapter
            .onGet(ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(
              200,
              r'''
{
    "questions": [{
        "id": 1000,
        "uuid": "1746f77a31bd6da4a80fe09a5e77a479",
        "title": "في أي من كسور الفك السفلي يرجع اللسان إلى الخلف: إجابة صحيحة واحدة:",
        "titleTranslation": "",
        "specialCharacter": 1,
        "type": 1,
        "labelId": 1,
        "note": "",
        "noteTranslation": "",
        "edited": 0,
        "controversial": 0,
        "editionDate": "0000-00-00 00:00:00",
        "imageUrl": "",
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null,
        "parentTermId": 3,
        "ordering": 120
    }],
    "flashcards": [],
    "images": [],
    "answers": [{
        "id": 10466304,
        "uuid": "1e1de905de436dd1b4e2445968d5bcfa",
        "title": "نقصان الغلوبولينات المناعية في اللعاب",
        "titleTranslation": "aaaa",
        "specialCharacter": 1,
        "isCorrect": 1,
        "parentQuestionId": 1000,
        "checkedCount": 100,
        "creation": "2023-12-07 08:33:09",
        "onUpdate": "2025-02-21 08:28:37",
        "deleted_at": null,
        "deleted_by": null
    }],
    "media": [],
    "questionsLinkedToTags": [{
        "questionId": 1000,
        "tagId": 1000,
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null
    }],
    "questionTags": [{
        "id": 1000,
        "name": "الكم بوزيت وتحضيراتها",
        "parentTermId": 10,
        "parentTagId": 0,
        "color": 4216570,
        "creation": "2023-03-15 19:46:09",
        "hasInformation": 0
    }],
    "result": "success",
    "message": ""
}
''',
              delay: const Duration(seconds: 1));
        });
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pump();

        expect(
            widgetWithTextAndWidget(
                TermWidget, 'name', CircularProgressIndicator),
            findsOneWidget);
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'download icon tapping shows no connection when there is no connection',
          (widgetTester) async {
        await createTermData(type: TermType.template);
        mockNoConnection(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets(
          'download icon tapping shows a message when a message is recieved',
          (widgetTester) async {
        await createTermData(type: TermType.template);
        mockMessageRecieved(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets('download icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.template);

        dioAdapter
            .onGet(ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(200, r'''
{
    "questions": [{
        "id": 1000,
        "uuid": "1746f77a31bd6da4a80fe09a5e77a479",
        "title": "في أي من كسور الفك السفلي يرجع اللسان إلى الخلف: إجابة صحيحة واحدة:",
        "titleTranslation": "",
        "specialCharacter": 1,
        "type": 1,
        "labelId": 1,
        "note": "",
        "noteTranslation": "",
        "edited": 0,
        "controversial": 0,
        "editionDate": "0000-00-00 00:00:00",
        "imageUrl": "",
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null,
        "parentTermId": 3,
        "ordering": 120
    }],
    "flashcards": [],
    "images": [],
    "answers": [{
        "id": 10466304,
        "uuid": "1e1de905de436dd1b4e2445968d5bcfa",
        "title": "نقصان الغلوبولينات المناعية في اللعاب",
        "titleTranslation": "aaaa",
        "specialCharacter": 1,
        "isCorrect": 1,
        "parentQuestionId": 1000,
        "checkedCount": 100,
        "creation": "2023-12-07 08:33:09",
        "onUpdate": "2025-02-21 08:28:37",
        "deleted_at": null,
        "deleted_by": null
    }],
    "media": [],
    "questionsLinkedToTags": [{
        "questionId": 1000,
        "tagId": 1000,
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null
    }],
    "questionTags": [{
        "id": 1000,
        "name": "الكم بوزيت وتحضيراتها",
        "parentTermId": 10,
        "parentTagId": 0,
        "color": 4216570,
        "creation": "2023-03-15 19:46:09",
        "hasInformation": 0
    }],
    "result": "success",
    "message": ""
}
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
      });
    });

    testWidgets('download icon is not rendered for youtube videos term type',
        (widgetTester) async {
      await createTermData(type: TermType.youtubeVideos);
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
          findsNothing);
    });

    group('flashcards term type tests', () {
      testWidgets('download icon is rendered for flashcards term type',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
      });

      testWidgets('download icon tapping shows a loading',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards);
        dioAdapter
            .onGet(ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(
              200,
              r'''
{
    "questions": [],
    "images":[],
        "flashcards": [
            {
                "id": 20,
                "head": "تجريب",
                "tail": "🟢 نصائح لاجتياز الامتحان: ركز على الفقرات الأساسية بدلاً من حفظ كل شيء. الخرائط والدورات السابقة تدلك على المسار الأمثل.",
                "parentTermId": 67,
                "creation": "2024-10-12 04:50:39",
                "onUpdate": "2024-10-12 04:50:22",
                "deleted_at": null,
                "deleted_by": null
            }
        ],
            "answers": [],
                "media": [],
                    "questionsLinkedToTags": [],
                        "questionTags": [],
                            "result": "success",
                                "message": ""
  }
''',
              delay: const Duration(seconds: 1));
        });
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pump();

        expect(
            widgetWithTextAndWidget(
                TermWidget, 'name', CircularProgressIndicator),
            findsOneWidget);
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'download icon tapping shows no connection when there is no connection',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards);
        mockNoConnection(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets(
          'download icon tapping shows a message when a message is recieved',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards);
        mockMessageRecieved(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets('download icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.flashcards);

        dioAdapter
            .onGet(ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(200, r'''
{
    "questions": [],
    "images":[],
        "flashcards": [
            {
                "id": 20,
                "head": "تجريب",
                "tail": "🟢 نصائح لاجتياز الامتحان: ركز على الفقرات الأساسية بدلاً من حفظ كل شيء. الخرائط والدورات السابقة تدلك على المسار الأمثل.",
                "parentTermId": 67,
                "creation": "2024-10-12 04:50:39",
                "onUpdate": "2024-10-12 04:50:22",
                "deleted_at": null,
                "deleted_by": null
            }
        ],
            "answers": [],
                "media": [],
                    "questionsLinkedToTags": [],
                        "questionTags": [],
                            "result": "success",
                                "message": ""
  }
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsOneWidget);
      });
    });

group('images term type tests', () {
      testWidgets('download icon is rendered for images term type', (
        widgetTester,
      ) async {
        await createTermData(type: TermType.images);
        await widgetTester.pumpWidget(
          const MyApp(defaultRoute: HomeScreen.route),
        );
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(
          widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
          findsOneWidget,
        );
      });

      testWidgets('download icon tapping shows a loading', (
        widgetTester,
      ) async {
        await createTermData(type: TermType.images);
        dioAdapter.onGet(
          ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
          (server) {
            server.reply(200, r'''
{
    "questions": [],
    "flashcards":[],
        "images": [
            {
                "id": 20,
                "title": "تجريب",
                "info": "🟢 نصائح لاجتياز الامتحان: ركز على الفقرات الأساسية بدلاً من حفظ كل شيء. الخرائط والدورات السابقة تدلك على المسار الأمثل.",
                "parentTermId": 67,
                "url:"url"
                "creation": "2024-10-12 04:50:39",
                "onUpdate": "2024-10-12 04:50:22",
                "deleted_at": null,
                "deleted_by": null
            }
        ],
            "answers": [],
            "images":[],
                "media": [],
                    "questionsLinkedToTags": [],
                        "questionTags": [],
                            "result": "success",
                                "message": ""
  }
''', delay: const Duration(seconds: 1));
          },
        );
        await widgetTester.pumpWidget(
          const MyApp(defaultRoute: HomeScreen.route),
        );
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pump();

        expect(
          widgetWithTextAndWidget(
            TermWidget,
            'name',
            CircularProgressIndicator,
          ),
          findsOneWidget,
        );
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
        'download icon tapping shows no connection when there is no connection',
        (widgetTester) async {
          await createTermData(type: TermType.images);
          mockNoConnection(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
          );

          await widgetTester.pumpWidget(
            const MyApp(defaultRoute: HomeScreen.route),
          );
          await widgetTester.pumpAndSettle();

          // tap the parent term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
          await widgetTester.pumpAndSettle();

          // tap the child term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
          await widgetTester.pumpAndSettle();

          // tap download icon
          await widgetTester.tap(find.byIcon(Icons.cloud_download));
          await widgetTester.pumpAndSettle();

          expect(
            find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget,
          );
          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget,
          );
          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing,
          );
        },
      );

      testWidgets(
        'download icon tapping shows a message when a message is recieved',
        (widgetTester) async {
          await createTermData(type: TermType.images);
          mockMessageRecieved(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
          );

          await widgetTester.pumpWidget(
            const MyApp(defaultRoute: HomeScreen.route),
          );
          await widgetTester.pumpAndSettle();

          // tap the parent term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
          await widgetTester.pumpAndSettle();

          // tap the child term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
          await widgetTester.pumpAndSettle();

          // tap download icon
          await widgetTester.tap(find.byIcon(Icons.cloud_download));
          await widgetTester.pumpAndSettle();

          expect(
            find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget,
          );
          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget,
          );
          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing,
          );
        },
      );

      testWidgets('download icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.images);

        dioAdapter.onGet(
          ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
          (server) {
            server.reply(200, r'''
{
    "questions": [],
    "flashcards": [],
        "images": [
            {
                "id": 20,
                "url":"url",
                "title": "تجريب",
                "info": "🟢 نصائح لاجتياز الامتحان: ركز على الفقرات الأساسية بدلاً من حفظ كل شيء. الخرائط والدورات السابقة تدلك على المسار الأمثل.",
                "parentTermId": 67,
                "creation": "2024-10-12 04:50:39",
                "onUpdate": "2024-10-12 04:50:22",
                "deleted_at": null,
                "deleted_by": null
            }
        ],
            "answers": [],
                "media": [],
                    "questionsLinkedToTags": [],
                        "questionTags": [],
                            "result": "success",
                                "message": ""
  }
''');
          },
        );

        await widgetTester.pumpWidget(
          const MyApp(defaultRoute: HomeScreen.route),
        );
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(
          widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
          findsNothing,
        );
        expect(
          widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
          findsOneWidget,
        );
      });
    });

    group('voice notes term type tests', () {
      testWidgets('download icon is rendered for voice notes term type',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
      });

      testWidgets('download icon tapping shows a loading',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes);
        mockNoConnection(
            route: ApiConstant.getVoice.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pump();

        expect(
            widgetWithTextAndWidget(
                TermWidget, 'name', CircularProgressIndicator),
            findsOneWidget);
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'download icon tapping shows no connection when there is no connection',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes);
        mockNoConnection(
            route: ApiConstant.getVoice.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets(
          'download icon tapping shows a message when a message is recieved',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes);
        mockMessageRecieved(
            route: ApiConstant.getVoice.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets('download icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.voiceNotes);

        dioAdapter.onGet(
            "http://perfect-app.atwebpages.com/files/terms/10003581", (server) {
          server.reply(200, 'file content');
        });

        dioAdapter.onGet(ApiConstant.getVoice.replaceFirst('(TERM_ID)', '3'),
            (server) {
          server.reply(200, r'''
{
    "voice": {
        "parentTermId": 3,
        "url": "http:\/\/perfect-app.atwebpages.com\/files\/terms\/10003581",
        "encryptionKey": "",
        "creation": "2024-08-30T12:44:08.000000Z",
        "onUpdate": "2024-08-30T12:46:28.000000Z",
        "deleted_at": null,
        "deleted_by": null
    },
    "result": "success",
    "message": ""
}
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing);
      });
    });
  
    group('video file term type tests', () {
      testWidgets('download icon is rendered for video files term type',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
      });

      testWidgets('download icon tapping shows a loading',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile);
        mockNoConnection(
            route: ApiConstant.getVideoFile.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pump();

        expect(
            widgetWithTextAndWidget(
                TermWidget, 'name', CircularProgressIndicator),
            findsOneWidget);
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'download icon tapping shows no connection when there is no connection',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile);
        mockNoConnection(
            route: ApiConstant.getVideoFile.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets(
          'download icon tapping shows a message when a message is recieved',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile);
        mockMessageRecieved(
            route: ApiConstant.getVideoFile.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.delete),
            findsNothing);
      });

      testWidgets('download icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.videoFile);

        dioAdapter.onGet(
            "http://perfect-app.atwebpages.com/files/terms/10003581", (server) {
          server.reply(200, 'file content');
        });

        dioAdapter.onGet(
            ApiConstant.getVideoFile.replaceFirst('(TERM_ID)', '3'),
            (server) {
          server.reply(200, r'''
{
    "videoFile": {
        "parentTermId": 3,
        "url": "http:\/\/perfect-app.atwebpages.com\/files\/terms\/10003581",
        "encryptionKey": "",
        "creation": "2024-08-30T12:44:08.000000Z",
        "onUpdate": "2024-08-30T12:46:28.000000Z",
        "deleted_at": null,
        "deleted_by": null
    },
    "result": "success",
    "message": ""
}
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byIcon(Icons.cloud_download));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.cloud_download),
            findsNothing);
      });
    });
  
  });

  group('refresh icon tests', () {
    testWidgets('icon is not rendered for term type', (widgetTester) async {
      await createTermData(type: TermType.term, needsUpdate: 1);
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
          findsNothing);
    });

    group('questions term type tests', () {
      testWidgets(
          'icon is not rendered for questions term type that is not downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.questions);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });

      testWidgets(
          'icon is rendered for questions term type that is downloaded but does not need update',
          (widgetTester) async {
        await createTermData(type: TermType.questions);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });

      testWidgets(
          'icon is rendered for questions term type that is downloaded and needs update',
          (widgetTester) async {
        await createTermData(type: TermType.questions, needsUpdate: 1);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsOneWidget);
      });

      testWidgets('icon tapping shows a loading', (widgetTester) async {
        await createTermData(type: TermType.questions, needsUpdate: 1);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        dioAdapter
            .onGet(ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(
              200,
              r'''
{
    "questions": [{
        "id": 1000,
        "uuid": "1746f77a31bd6da4a80fe09a5e77a479",
        "title": "في أي من كسور الفك السفلي يرجع اللسان إلى الخلف: إجابة صحيحة واحدة:",
        "titleTranslation": "",
        "specialCharacter": 1,
        "type": 1,
        "labelId": 1,
        "note": "",
        "noteTranslation": "",
        "edited": 0,
        "controversial": 0,
        "editionDate": "0000-00-00 00:00:00",
        "imageUrl": "",
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null,
        "parentTermId": 3,
        "ordering": 120
    }],
    "flashcards": [],
    "images":[],
    "answers": [{
        "id": 10466304,
        "uuid": "1e1de905de436dd1b4e2445968d5bcfa",
        "title": "نقصان الغلوبولينات المناعية في اللعاب",
        "titleTranslation": "aaaa",
        "specialCharacter": 1,
        "isCorrect": 1,
        "parentQuestionId": 1000,
        "checkedCount": 100,
        "creation": "2023-12-07 08:33:09",
        "onUpdate": "2025-02-21 08:28:37",
        "deleted_at": null,
        "deleted_by": null
    }],
    "media": [],
    "questionsLinkedToTags": [{
        "questionId": 1000,
        "tagId": 1000,
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null
    }],
    "questionTags": [{
        "id": 1000,
        "name": "الكم بوزيت وتحضيراتها",
        "parentTermId": 10,
        "parentTagId": 0,
        "color": 4216570,
        "creation": "2023-03-15 19:46:09",
        "hasInformation": 0
    }],
    "result": "success",
    "message": ""
}
''',
              delay: const Duration(seconds: 1));
        });
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pump();

        expect(
            widgetWithTextAndWidget(
                TermWidget, 'name', CircularProgressIndicator),
            findsOneWidget);
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'icon tapping shows no connection when there is no connection',
          (widgetTester) async {
        await createTermData(type: TermType.questions, needsUpdate: 1);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        mockNoConnection(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
        expect(widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget);
      });

      testWidgets('icon tapping shows a message when a message is recieved',
          (widgetTester) async {
        await createTermData(type: TermType.questions, needsUpdate: 1);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        mockMessageRecieved(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
        expect(widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget);
      });

      testWidgets('refresh icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.questions, needsUpdate: 1);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);

        dioAdapter
            .onGet(ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(200, r'''
{
    "questions": [{
        "id": 1000,
        "uuid": "1746f77a31bd6da4a80fe09a5e77a479",
        "title": "في أي من كسور الفك السفلي يرجع اللسان إلى الخلف: إجابة صحيحة واحدة:",
        "titleTranslation": "",
        "specialCharacter": 1,
        "type": 1,
        "labelId": 1,
        "note": "",
        "noteTranslation": "",
        "edited": 0,
        "controversial": 0,
        "editionDate": "0000-00-00 00:00:00",
        "imageUrl": "",
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null,
        "parentTermId": 3,
        "ordering": 120
    }],
    "flashcards": [],
    "images":[],
    "answers": [{
        "id": 10466304,
        "uuid": "1e1de905de436dd1b4e2445968d5bcfa",
        "title": "نقصان الغلوبولينات المناعية في اللعاب",
        "titleTranslation": "aaaa",
        "specialCharacter": 1,
        "isCorrect": 1,
        "parentQuestionId": 1000,
        "checkedCount": 100,
        "creation": "2023-12-07 08:33:09",
        "onUpdate": "2025-02-21 08:28:37",
        "deleted_at": null,
        "deleted_by": null
    }],
    "media": [],
    "questionsLinkedToTags": [{
        "questionId": 1000,
        "tagId": 1000,
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null
    }],
    "questionTags": [{
        "id": 1000,
        "name": "الكم بوزيت وتحضيراتها",
        "parentTermId": 10,
        "parentTagId": 0,
        "color": 4216570,
        "creation": "2023-03-15 19:46:09",
        "hasInformation": 0
    }],
    "result": "success",
    "message": ""
}
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });
    });

    group('ebooks term type tests', () {
      testWidgets(
          'icon is not rendered for ebook term type that is not downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.ebook);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });

      testWidgets(
          'icon is rendered for ebook term type that is downloaded but does not need update',
          (widgetTester) async {
        await createTermData(type: TermType.ebook);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });

      testWidgets(
          'icon is rendered for ebook term type that is downloaded and needs update',
          (widgetTester) async {
        await createTermData(type: TermType.ebook, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsOneWidget);
      });

      testWidgets('icon tapping shows a loading', (widgetTester) async {
        await createTermData(type: TermType.ebook, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        dioAdapter.onGet(
            "http://perfect-app.atwebpages.com/files/terms/10003581", (server) {
          server.reply(200, 'file content');
        });

        dioAdapter.onGet(ApiConstant.getEbook.replaceFirst('(TERM_ID)', '3'),
            (server) {
          server.reply(200, r'''
{
    "ebook": {
        "parentTermId": 3,
        "url": "http:\/\/perfect-app.atwebpages.com\/files\/terms\/10003581",
        "encryptionKey": "",
        "creation": "2024-08-30T12:44:08.000000Z",
        "onUpdate": "2024-08-30T12:46:28.000000Z",
        "deleted_at": null,
        "deleted_by": null
    },
    "result": "success",
    "message": ""
}
''');
        });
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pump();

        expect(
            widgetWithTextAndWidget(
                TermWidget, 'name', CircularProgressIndicator),
            findsOneWidget);
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'icon tapping shows no connection when there is no connection',
          (widgetTester) async {
        await createTermData(type: TermType.ebook, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        mockNoConnection(
            route: ApiConstant.getEbook.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
        expect(widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget);
      });

      testWidgets('icon tapping shows a message when a message is recieved',
          (widgetTester) async {
        await createTermData(type: TermType.ebook, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        mockMessageRecieved(
            route: ApiConstant.getEbook.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
        expect(widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget);
      });

      testWidgets('refresh icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.ebook, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        dioAdapter.onGet(
            "http://perfect-app.atwebpages.com/files/terms/10003581", (server) {
          server.reply(200, 'file content');
        });

        dioAdapter.onGet(ApiConstant.getEbook.replaceFirst('(TERM_ID)', '3'),
            (server) {
          server.reply(200, r'''
{
    "ebook": {
        "parentTermId": 3,
        "url": "http:\/\/perfect-app.atwebpages.com\/files\/terms\/10003581",
        "encryptionKey": "",
        "creation": "2024-08-30T12:44:08.000000Z",
        "onUpdate": "2024-08-30T12:46:28.000000Z",
        "deleted_at": null,
        "deleted_by": null
    },
    "result": "success",
    "message": ""
}
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });
    });

    group('template term type tests', () {
      testWidgets(
          'icon is not rendered for template term type that is not downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.template);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });

      testWidgets(
          'icon is rendered for template term type that is downloaded but does not need update',
          (widgetTester) async {
        await createTermData(type: TermType.template);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });

      testWidgets(
          'icon is rendered for template term type that is downloaded and needs update',
          (widgetTester) async {
        await createTermData(type: TermType.template, needsUpdate: 1);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsOneWidget);
      });

      testWidgets('icon tapping shows a loading', (widgetTester) async {
        await createTermData(type: TermType.template, needsUpdate: 1);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        dioAdapter
            .onGet(ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(
              200,
              r'''
{
    "questions": [{
        "id": 1000,
        "uuid": "1746f77a31bd6da4a80fe09a5e77a479",
        "title": "في أي من كسور الفك السفلي يرجع اللسان إلى الخلف: إجابة صحيحة واحدة:",
        "titleTranslation": "",
        "specialCharacter": 1,
        "type": 1,
        "labelId": 1,
        "note": "",
        "noteTranslation": "",
        "edited": 0,
        "controversial": 0,
        "editionDate": "0000-00-00 00:00:00",
        "imageUrl": "",
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null,
        "parentTermId": 3,
        "ordering": 120
    }],
    "flashcards": [],
    "images":[],
    "answers": [{
        "id": 10466304,
        "uuid": "1e1de905de436dd1b4e2445968d5bcfa",
        "title": "نقصان الغلوبولينات المناعية في اللعاب",
        "titleTranslation": "aaaa",
        "specialCharacter": 1,
        "isCorrect": 1,
        "parentQuestionId": 1000,
        "checkedCount": 100,
        "creation": "2023-12-07 08:33:09",
        "onUpdate": "2025-02-21 08:28:37",
        "deleted_at": null,
        "deleted_by": null
    }],
    "media": [],
    "questionsLinkedToTags": [{
        "questionId": 1000,
        "tagId": 1000,
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null
    }],
    "questionTags": [{
        "id": 1000,
        "name": "الكم بوزيت وتحضيراتها",
        "parentTermId": 10,
        "parentTagId": 0,
        "color": 4216570,
        "creation": "2023-03-15 19:46:09",
        "hasInformation": 0
    }],
    "result": "success",
    "message": ""
}
''',
              delay: const Duration(seconds: 1));
        });
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pump();

        expect(
            widgetWithTextAndWidget(
                TermWidget, 'name', CircularProgressIndicator),
            findsOneWidget);
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'icon tapping shows no connection when there is no connection',
          (widgetTester) async {
        await createTermData(type: TermType.template, needsUpdate: 1);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        mockNoConnection(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
        expect(widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget);
      });

      testWidgets('icon tapping shows a message when a message is recieved',
          (widgetTester) async {
        await createTermData(type: TermType.template, needsUpdate: 1);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);
        mockMessageRecieved(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
        expect(widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget);
      });

      testWidgets('refresh icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.template, needsUpdate: 1);
        QuestionService questionService = Get.find();
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
              imageUrl: 'imageUrl',
              creation: '2022-01-01 11:12:13',
              editionDate: '2023-01-01 11:12:13')
        ]);

        dioAdapter
            .onGet(ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(200, r'''
{
    "questions": [{
        "id": 1000,
        "uuid": "1746f77a31bd6da4a80fe09a5e77a479",
        "title": "في أي من كسور الفك السفلي يرجع اللسان إلى الخلف: إجابة صحيحة واحدة:",
        "titleTranslation": "",
        "specialCharacter": 1,
        "type": 1,
        "labelId": 1,
        "note": "",
        "noteTranslation": "",
        "edited": 0,
        "controversial": 0,
        "editionDate": "0000-00-00 00:00:00",
        "imageUrl": "",
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null,
        "parentTermId": 3,
        "ordering": 120
    }],
    "flashcards": [],
    "images":[],
    "answers": [{
        "id": 10466304,
        "uuid": "1e1de905de436dd1b4e2445968d5bcfa",
        "title": "نقصان الغلوبولينات المناعية في اللعاب",
        "titleTranslation": "aaaa",
        "specialCharacter": 1,
        "isCorrect": 1,
        "parentQuestionId": 1000,
        "checkedCount": 100,
        "creation": "2023-12-07 08:33:09",
        "onUpdate": "2025-02-21 08:28:37",
        "deleted_at": null,
        "deleted_by": null
    }],
    "media": [],
    "questionsLinkedToTags": [{
        "questionId": 1000,
        "tagId": 1000,
        "creation": "2023-12-07 08:33:10",
        "onUpdate": "0000-00-00 00:00:00",
        "deleted_at": null,
        "deleted_by": null
    }],
    "questionTags": [{
        "id": 1000,
        "name": "الكم بوزيت وتحضيراتها",
        "parentTermId": 10,
        "parentTagId": 0,
        "color": 4216570,
        "creation": "2023-03-15 19:46:09",
        "hasInformation": 0
    }],
    "result": "success",
    "message": ""
}
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });
    });

    testWidgets('icon is not rendered for youtube video type',
        (widgetTester) async {
      await createTermData(type: TermType.youtubeVideos, needsUpdate: 1);
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
          findsNothing);
    });

    group('flashcards term type tests', () {
      testWidgets(
          'icon is not rendered for flashcards term type that is not downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });

      testWidgets(
          'icon is rendered for flashcards term type that is downloaded but does not need update',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards);
        FlashcardService flashcardService = Get.find();
        await flashcardService.addFlashcards([
          const Flashcard(id: 1000, head: 'head', tail: 'tail', parentTermId: 3)
        ]);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });

      testWidgets(
          'icon is rendered for flashcards term type that is downloaded and needs update',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards, needsUpdate: 1);
        FlashcardService flashcardService = Get.find();
        await flashcardService.addFlashcards([
          const Flashcard(id: 1000, head: 'head', tail: 'tail', parentTermId: 3)
        ]);

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsOneWidget);
      });

      testWidgets('icon tapping shows a loading', (widgetTester) async {
        await createTermData(type: TermType.flashcards, needsUpdate: 1);
        FlashcardService flashcardService = Get.find();
        await flashcardService.addFlashcards([
          const Flashcard(id: 1000, head: 'head', tail: 'tail', parentTermId: 3)
        ]);
        dioAdapter
            .onGet(ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(200, r'''
{
    "questions": [],
    "images":[],
        "flashcards": [
            {
                "id": 20,
                "head": "تجريب",
                "tail": "🟢 نصائح لاجتياز الامتحان: ركز على الفقرات الأساسية بدلاً من حفظ كل شيء. الخرائط والدورات السابقة تدلك على المسار الأمثل.",
                "parentTermId": 67,
                "creation": "2024-10-12 04:50:39",
                "onUpdate": "2024-10-12 04:50:22",
                "deleted_at": null,
                "deleted_by": null
            }
        ],
            "answers": [],
                "media": [],
                    "questionsLinkedToTags": [],
                        "questionTags": [],
                            "result": "success",
                                "message": ""
  }
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pump();

        expect(
            widgetWithTextAndWidget(
                TermWidget, 'name', CircularProgressIndicator),
            findsOneWidget);
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'icon tapping shows no connection when there is no connection',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards, needsUpdate: 1);
        FlashcardService flashcardService = Get.find();
        await flashcardService.addFlashcards([
          const Flashcard(id: 1000, head: 'head', tail: 'tail', parentTermId: 3)
        ]);
        mockNoConnection(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
        expect(widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget);
      });

      testWidgets('icon tapping shows a message when a message is recieved',
          (widgetTester) async {
        await createTermData(type: TermType.flashcards, needsUpdate: 1);
        FlashcardService flashcardService = Get.find();
        await flashcardService.addFlashcards([
          const Flashcard(id: 1000, head: 'head', tail: 'tail', parentTermId: 3)
        ]);
        mockMessageRecieved(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
        expect(widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget);
      });

      testWidgets('refresh icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.flashcards, needsUpdate: 1);
        FlashcardService flashcardService = Get.find();
        await flashcardService.addFlashcards([
          const Flashcard(id: 1000, head: 'head', tail: 'tail', parentTermId: 3)
        ]);

        dioAdapter
            .onGet(ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
                (server) {
          server.reply(200, r'''
{
    "questions": [],
    "images":[],
        "flashcards": [
            {
                "id": 20,
                "head": "تجريب",
                "tail": "🟢 نصائح لاجتياز الامتحان: ركز على الفقرات الأساسية بدلاً من حفظ كل شيء. الخرائط والدورات السابقة تدلك على المسار الأمثل.",
                "parentTermId": 67,
                "creation": "2024-10-12 04:50:39",
                "onUpdate": "2024-10-12 04:50:22",
                "deleted_at": null,
                "deleted_by": null
            }
        ],
            "answers": [],
                "media": [],
                    "questionsLinkedToTags": [],
                        "questionTags": [],
                            "result": "success",
                                "message": ""
  }
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });
    });

group('images term type tests', () {
      testWidgets(
        'icon is not rendered for images term type that is not downloaded',
        (widgetTester) async {
          await createTermData(type: TermType.images);
          await widgetTester.pumpWidget(
            const MyApp(defaultRoute: HomeScreen.route),
          );
          await widgetTester.pumpAndSettle();

          // tap the parent term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
          await widgetTester.pumpAndSettle();

          // tap the child term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
          await widgetTester.pumpAndSettle();

          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing,
          );
        },
      );

      testWidgets(
        'icon is rendered for images term type that is downloaded but does not need update',
        (widgetTester) async {
          await createTermData(type: TermType.images);
          ImageService imageService = Get.find();
          await imageService.addImages([
            const Image(
              id: 1000,
              url: 'url',
              title: 'head',
              info: 'tail',
              parentTermId: 3,
            ),
          ]);
          await widgetTester.pumpWidget(
            const MyApp(defaultRoute: HomeScreen.route),
          );
          await widgetTester.pumpAndSettle();

          // tap the parent term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
          await widgetTester.pumpAndSettle();

          // tap the child term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
          await widgetTester.pumpAndSettle();

          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing,
          );
        },
      );

      testWidgets(
        'icon is rendered for images term type that is downloaded and needs update',
        (widgetTester) async {
          await createTermData(type: TermType.images, needsUpdate: 1);
          ImageService imageService = Get.find();
          await imageService.addImages([
            const Image(
              id: 1000,
              url: 'url',
              title: 'head',
              info: 'tail',
              parentTermId: 3,
            ),
          ]);

          await widgetTester.pumpWidget(
            const MyApp(defaultRoute: HomeScreen.route),
          );
          await widgetTester.pumpAndSettle();

          // tap the parent term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
          await widgetTester.pumpAndSettle();

          // tap the child term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
          await widgetTester.pumpAndSettle();

          expect(
            widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsOneWidget,
          );
        },
      );

      testWidgets('icon tapping shows a loading', (widgetTester) async {
        await createTermData(type: TermType.images, needsUpdate: 1);
        ImageService imageService = Get.find();
        await imageService.addImages([
          const Image(
            id: 1000,
            url: 'url',
            title: 'head',
            info: 'tail',
            parentTermId: 3,
          ),
        ]);
        dioAdapter.onGet(
          ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
          (server) {
            server.reply(200, r'''
{
    "questions": [],
    "flashcards":[],
        "images": [
            {
                "id": 20,
                "url":"url",
                "title": "تجريب",
                "info": "🟢 نصائح لاجتياز الامتحان: ركز على الفقرات الأساسية بدلاً من حفظ كل شيء. الخرائط والدورات السابقة تدلك على المسار الأمثل.",
                "parentTermId": 67,
                "creation": "2024-10-12 04:50:39",
                "onUpdate": "2024-10-12 04:50:22",
                "deleted_at": null,
                "deleted_by": null
            }
        ],
            "answers": [],
                "media": [],
                    "questionsLinkedToTags": [],
                        "questionTags": [],
                            "result": "success",
                                "message": ""
  }
''');
          },
        );

        await widgetTester.pumpWidget(
          const MyApp(defaultRoute: HomeScreen.route),
        );
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pump();

        expect(
          widgetWithTextAndWidget(
            TermWidget,
            'name',
            CircularProgressIndicator,
          ),
          findsOneWidget,
        );
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
        'icon tapping shows no connection when there is no connection',
        (widgetTester) async {
          await createTermData(type: TermType.images, needsUpdate: 1);
          ImageService imageService = Get.find();
          await imageService.addImages([
            const Image(
              id: 1000,
              url: 'url',
              title: 'head',
              info: 'tail',
              parentTermId: 3,
            ),
          ]);
          mockNoConnection(
            route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
          );

          await widgetTester.pumpWidget(
            const MyApp(defaultRoute: HomeScreen.route),
          );
          await widgetTester.pumpAndSettle();

          // tap the parent term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
          await widgetTester.pumpAndSettle();

          // tap the child term
          await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
          await widgetTester.pumpAndSettle();

          // tap download icon
          await widgetTester.tap(find.byKey(const Key('refresh')));
          await widgetTester.pumpAndSettle();

          expect(
            find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget,
          );
          expect(
            widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget,
          );
        },
      );

      testWidgets('icon tapping shows a message when a message is recieved', (
        widgetTester,
      ) async {
        await createTermData(type: TermType.images, needsUpdate: 1);
        ImageService imageService = Get.find();
        await imageService.addImages([
          const Image(
            id: 1000,
            url: 'url',
            title: 'head',
            info: 'tail',
            parentTermId: 3,
          ),
        ]);
        mockMessageRecieved(
          route: ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
        );

        await widgetTester.pumpWidget(
          const MyApp(defaultRoute: HomeScreen.route),
        );
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(
          find.widgetWithText(OKDialogue, 'a message recieved'),
          findsOneWidget,
        );
        expect(
          widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
          findsOneWidget,
        );
      });

      testWidgets('refresh icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.images, needsUpdate: 1);
        ImageService imageService = Get.find();
        await imageService.addImages([
          const Image(
            id: 1000,
            url: 'url',
            title: 'head',
            info: 'tail',
            parentTermId: 3,
          ),
        ]);

        dioAdapter.onGet(
          ApiConstant.getTermContent.replaceFirst('(TERM_ID)', '3'),
          (server) {
            server.reply(200, r'''
{
    "questions": [],
    "flashcards":[],
        "images": [
            {
                "id": 20,
                "url":"url",
                "title": "تجريب",
                "info": "🟢 نصائح لاجتياز الامتحان: ركز على الفقرات الأساسية بدلاً من حفظ كل شيء. الخرائط والدورات السابقة تدلك على المسار الأمثل.",
                "parentTermId": 67,
                "creation": "2024-10-12 04:50:39",
                "onUpdate": "2024-10-12 04:50:22",
                "deleted_at": null,
                "deleted_by": null
            }
        ],
            "answers": [],
                "media": [],
                    "questionsLinkedToTags": [],
                        "questionTags": [],
                            "result": "success",
                                "message": ""
  }
''');
          },
        );

        await widgetTester.pumpWidget(
          const MyApp(defaultRoute: HomeScreen.route),
        );
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(
          widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
          findsNothing,
        );
      });
    });

    group('voice notes term type tests', () {
      testWidgets(
          'icon is not rendered for voice notes term type that is not downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });

      testWidgets(
          'icon is rendered for voice notes term type that is downloaded but does not need update',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });

      testWidgets(
          'icon is rendered for voice notes term type that is downloaded and needs update',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsOneWidget);
      });

      testWidgets('icon tapping shows a loading', (widgetTester) async {
        await createTermData(type: TermType.voiceNotes, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        dioAdapter.onGet(
            "http://perfect-app.atwebpages.com/files/terms/10003581", (server) {
          server.reply(200, 'file content');
        });

        dioAdapter.onGet(ApiConstant.getEbook.replaceFirst('(TERM_ID)', '3'),
            (server) {
          server.reply(200, r'''
{
    "voice": {
        "parentTermId": 3,
        "url": "http:\/\/perfect-app.atwebpages.com\/files\/terms\/10003581",
        "encryptionKey": "",
        "creation": "2024-08-30T12:44:08.000000Z",
        "onUpdate": "2024-08-30T12:46:28.000000Z",
        "deleted_at": null,
        "deleted_by": null
    },
    "result": "success",
    "message": ""
}
''');
        });
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pump();

        expect(
            widgetWithTextAndWidget(
                TermWidget, 'name', CircularProgressIndicator),
            findsOneWidget);
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'icon tapping shows no connection when there is no connection',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        mockNoConnection(
            route: ApiConstant.getVoice.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
        expect(widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget);
      });

      testWidgets('icon tapping shows a message when a message is recieved',
          (widgetTester) async {
        await createTermData(type: TermType.voiceNotes, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        mockMessageRecieved(
            route: ApiConstant.getVoice.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
        expect(widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget);
      });

      testWidgets('refresh icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.voiceNotes, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        dioAdapter.onGet(
            "http://perfect-app.atwebpages.com/files/terms/10003581", (server) {
          server.reply(200, 'file content');
        });

        dioAdapter.onGet(ApiConstant.getVoice.replaceFirst('(TERM_ID)', '3'),
            (server) {
          server.reply(200, r'''
{
    "voice": {
        "parentTermId": 3,
        "url": "http:\/\/perfect-app.atwebpages.com\/files\/terms\/10003581",
        "encryptionKey": "",
        "creation": "2024-08-30T12:44:08.000000Z",
        "onUpdate": "2024-08-30T12:46:28.000000Z",
        "deleted_at": null,
        "deleted_by": null
    },
    "result": "success",
    "message": ""
}
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });
    });

    group('video file term type tests', () {
      testWidgets(
          'icon is not rendered for video file term type that is not downloaded',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });

      testWidgets(
          'icon is rendered for video file term type that is downloaded but does not need update',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });

      testWidgets(
          'icon is rendered for video file term type that is downloaded and needs update',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsOneWidget);
      });

      testWidgets('icon tapping shows a loading', (widgetTester) async {
        await createTermData(type: TermType.videoFile, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        dioAdapter.onGet(
            "http://perfect-app.atwebpages.com/files/terms/10003581", (server) {
          server.reply(200, 'file content');
        });

        dioAdapter.onGet(
            ApiConstant.getVideoFile.replaceFirst('(TERM_ID)', '3'),
            (server) {
          server.reply(200, r'''
{
    "videoFile": {
        "parentTermId": 3,
        "url": "http:\/\/perfect-app.atwebpages.com\/files\/terms\/10003581",
        "encryptionKey": "",
        "creation": "2024-08-30T12:44:08.000000Z",
        "onUpdate": "2024-08-30T12:46:28.000000Z",
        "deleted_at": null,
        "deleted_by": null
    },
    "result": "success",
    "message": ""
}
''');
        });
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pump();

        expect(
            widgetWithTextAndWidget(
                TermWidget, 'name', CircularProgressIndicator),
            findsOneWidget);
        await widgetTester.pumpAndSettle();
      });

      testWidgets(
          'icon tapping shows no connection when there is no connection',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        mockNoConnection(
            route: ApiConstant.getVideoFile.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, StringConstant.noConnection),
            findsOneWidget);
        expect(widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget);
      });

      testWidgets('icon tapping shows a message when a message is recieved',
          (widgetTester) async {
        await createTermData(type: TermType.videoFile, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        mockMessageRecieved(
            route: ApiConstant.getVideoFile.replaceFirst('(TERM_ID)', '3'));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.widgetWithText(OKDialogue, 'a message recieved'),
            findsOneWidget);
        expect(widgetWithTextAndKey(TermWidget, 'name', const Key('refresh')),
            findsOneWidget);
      });

      testWidgets('refresh icon tapping downloads data', (widgetTester) async {
        await createTermData(type: TermType.videoFile, needsUpdate: 1);
        PathService pathService = Get.find();
        pathService.testFileInSupport = true;

        dioAdapter.onGet(
            "http://perfect-app.atwebpages.com/files/terms/10003581", (server) {
          server.reply(200, 'file content');
        });

        dioAdapter.onGet(
            ApiConstant.getVideoFile.replaceFirst('(TERM_ID)', '3'),
            (server) {
          server.reply(200, r'''
{
    "videoFile": {
        "parentTermId": 3,
        "url": "http:\/\/perfect-app.atwebpages.com\/files\/terms\/10003581",
        "encryptionKey": "",
        "creation": "2024-08-30T12:44:08.000000Z",
        "onUpdate": "2024-08-30T12:46:28.000000Z",
        "deleted_at": null,
        "deleted_by": null
    },
    "result": "success",
    "message": ""
}
''');
        });

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // tap download icon
        await widgetTester.tap(find.byKey(const Key('refresh')));
        await widgetTester.pumpAndSettle();

        expect(find.byType(OKDialogue), findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.system_update),
            findsNothing);
      });
    });

  });

  group('study icon tests', () {
    testWidgets('icon is not rendered for term type', (widgetTester) async {
      await createTermData(type: TermType.term);
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.fact_check),
          findsNothing);
      expect(
          widgetWithTextAndIcon(TermWidget, 'name', Icons.fact_check_outlined),
          findsNothing);
    });

    for (int c = 1; c <= 6; c++) {
      testWidgets('icon is not rendered for term type $c that is not studied',
          (widgetTester) async {
        await createTermData(type: c);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.fact_check),
            findsNothing);
        expect(
            widgetWithTextAndIcon(
                TermWidget, 'name', Icons.fact_check_outlined),
            findsOneWidget);
      });

      testWidgets('icon is rendered for term type $c that is studied',
          (widgetTester) async {
        await createTermData(type: c);
        TermPropertyService termPropertyService = Get.find();
        termPropertyService.addTermToStudied(const Id(3));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.fact_check),
            findsOneWidget);
        expect(
            widgetWithTextAndIcon(
                TermWidget, 'name', Icons.fact_check_outlined),
            findsNothing);
      });

      testWidgets('tapping studied icon, make the term studied',
          (widgetTester) async {
        await createTermData(type: c);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byKey(const Key('unstudied')));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.fact_check),
            findsOneWidget);
        expect(
            widgetWithTextAndIcon(
                TermWidget, 'name', Icons.fact_check_outlined),
            findsNothing);

        // go back
        BrowseTermsTabController browseTermsTabController = Get.find();
        browseTermsTabController.onTabPopInvoked(false, null);
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // recheck
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.fact_check),
            findsOneWidget);
        expect(
            widgetWithTextAndIcon(
                TermWidget, 'name', Icons.fact_check_outlined),
            findsNothing);
      });

      testWidgets('tapping un study icon, make the term unstudied',
          (widgetTester) async {
        await createTermData(type: c);
        TermPropertyService termPropertyService = Get.find();
        termPropertyService.addTermToStudied(const Id(3));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byKey(const Key('studied')));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.fact_check),
            findsNothing);
        expect(
            widgetWithTextAndIcon(
                TermWidget, 'name', Icons.fact_check_outlined),
            findsOneWidget);

        // go back
        BrowseTermsTabController browseTermsTabController = Get.find();
        browseTermsTabController.onTabPopInvoked(false, null);
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // recheck
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.fact_check),
            findsNothing);
        expect(
            widgetWithTextAndIcon(
                TermWidget, 'name', Icons.fact_check_outlined),
            findsOneWidget);
      });
    }
  });

  group('favorite icon tests', () {
    testWidgets('icon is not rendered for term type', (widgetTester) async {
      await createTermData(type: TermType.term);
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(
          widgetWithTextAndIcon(TermWidget, 'name', Icons.star), findsNothing);
      expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star_border),
          findsNothing);
    });

    for (int c = 1; c <= 6; c++) {
      testWidgets('icon is not rendered for term type $c that is not favorite',
          (widgetTester) async {
        await createTermData(type: c);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star),
            findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star_border),
            findsOneWidget);
      });

      testWidgets('icon is rendered for term type $c that is favorite',
          (widgetTester) async {
        await createTermData(type: c);
        TermPropertyService termPropertyService = Get.find();
        termPropertyService.addTermToFavorite(const Id(3));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star_border),
            findsNothing);
      });

      testWidgets('tapping favorite icon, make the term favorite',
          (widgetTester) async {
        await createTermData(type: c);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byKey(const Key('unfavorite')));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star_border),
            findsNothing);

        // go back
        BrowseTermsTabController browseTermsTabController = Get.find();
        browseTermsTabController.onTabPopInvoked(false, null);
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // recheck
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star),
            findsOneWidget);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star_border),
            findsNothing);
      });

      testWidgets('tapping un favorite icon, make the term unfavorite',
          (widgetTester) async {
        await createTermData(type: c);
        TermPropertyService termPropertyService = Get.find();
        termPropertyService.addTermToFavorite(const Id(3));

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byKey(const Key('favorite')));
        await widgetTester.pumpAndSettle();

        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star),
            findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star_border),
            findsOneWidget);

        // go back
        BrowseTermsTabController browseTermsTabController = Get.find();
        browseTermsTabController.onTabPopInvoked(false, null);
        await widgetTester.pumpAndSettle();

        // tap the child term
        await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
        await widgetTester.pumpAndSettle();

        // recheck
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star),
            findsNothing);
        expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.star_border),
            findsOneWidget);
      });
    }
  });

  group('related terms icon tests', () {
    testWidgets('icon is not rendered if there are no related terms',
        (widgetTester) async {
      await createTermData(type: Random().nextInt(TermType.maxTermType + 1));
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(
          widgetWithTextAndIcon(TermWidget, 'name', Icons.link), findsNothing);
    });

    testWidgets('icon is rendered if there are related terms',
        (widgetTester) async {
      await createTermData(type: Random().nextInt(TermType.maxTermType + 1));
      TermsParentService termsParentService = Get.find();
      TermService termService = Get.find();
      termService.addTerms([
        TermData(
            const Term(
                id: 1000,
                uuid: 'uuid',
                name: 'parent 2',
                type: TermType.term,
                creation: '2024-01-01 11:12:13',
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
                creation: '2024-01-01 11:12:13',
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
                name: 'grand child 2',
                type: TermType.term,
                creation: '2024-01-01 11:12:13',
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
      termsParentService.addTermsParents([
        TermsParentData(
            const TermsParent(
                termId: 1002,
                parentTermId: 1001,
                rootTermId: -1,
                creation: '2023-01-01 11:12:13'),
            deletedAt: const DeletedAt(null)),
        TermsParentData(
            const TermsParent(
                termId: 1001,
                parentTermId: 1000,
                rootTermId: -1,
                creation: '2023-01-01 11:12:13'),
            deletedAt: const DeletedAt(null))
      ]);
      RelatedTermService relatedTermService = Get.find();
      relatedTermService.addRelatedTerms([
        RelatedTermData(const RelatedTerm(anotherTermId: 1002, termId: 3),
            deletedAt: const DeletedAt(null))
      ]);
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.link),
          findsOneWidget);

      await widgetTester.tap(find.byIcon(Icons.link));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(TermWidget, 'grand child 2'), findsOneWidget);
    });
  });

  group('homework icon tests', () {
    Future mockEmptySubmissions() async {
      dioAdapter.onGet(
          ApiConstant.homework.replaceFirst('(TERM_ID)', '3'),
          (server) => server.reply(
              200, r'''{"submissions":[],"result":"success","message":""}'''));
    }

    testWidgets(
        'homework icon is not rendered for a homework-ineligible term type even when the term is enabled',
        (widgetTester) async {
      await createTermData(type: TermType.questions);
      await databaseService
          .into(databaseService.termsWithHomeworkEnabled)
          .insert(const TermsWithHomeworkEnabledData(termId: 3));

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.assignment),
          findsNothing);
    });

    testWidgets(
        'homework icon is not rendered for an eligible term type that is not enabled',
        (widgetTester) async {
      await createTermData(type: TermType.ebook);

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.assignment),
          findsNothing);
    });

    testWidgets(
        'homework icon is rendered for an eligible term type that is enabled',
        (widgetTester) async {
      await createTermData(type: TermType.ebook);
      await databaseService
          .into(databaseService.termsWithHomeworkEnabled)
          .insert(const TermsWithHomeworkEnabledData(termId: 3));

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      expect(widgetWithTextAndIcon(TermWidget, 'name', Icons.assignment),
          findsOneWidget);
    });

    testWidgets('tapping the homework icon opens the homework screen',
        (widgetTester) async {
      await createTermData(type: TermType.ebook);
      await databaseService
          .into(databaseService.termsWithHomeworkEnabled)
          .insert(const TermsWithHomeworkEnabledData(termId: 3));
      await mockEmptySubmissions();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'parent'));
      await widgetTester.pumpAndSettle();

      // tap the child term
      await widgetTester.tap(find.widgetWithText(TermWidget, 'child'));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.assignment));
      await widgetTester.pumpAndSettle();

      expect(find.byType(HomeworkScreen), findsOneWidget);
    });
  });
}
