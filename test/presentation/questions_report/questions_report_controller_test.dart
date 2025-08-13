import 'dart:async';

import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:beta/presentation/questions_report/questions_report_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../common/tests.dart';

void main() {
  late QuestionsReportController controller;
  late QuestionsReportScreenArgument testArguments;

  // Helper function to create test questions with tags
  List<QuestionData> createTestQuestions() {
    return [
      QuestionData(
        const Question(
            id: 1,
            uuid: 'uuid',
            title: 'title',
            titleTranslation: 'titleTranslation',
            labelId: 1,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 1,
            specialCharacter: SpecialCharacter.none,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2024-01-01 11:15:19',
            editionDate: ''),
        parentTermName: '',
        numberOfMedias: 0,
        hasNote: false,
        indexInTerm: 1,
      )..questionTags = [
          const QuestionTag(
              id: 1,
              name: 'Parent Tag 1',
              parentTagId: 0,
              hasInformation: 0,
              creation: '2024-01-01 11:13:15'),
          const QuestionTag(
              id: 2,
              name: 'Child Tag 1',
              parentTagId: 1,
              hasInformation: 0,
              creation: '2024-01-01 11:13:15'),
        ],
      QuestionData(
        const Question(
            id: 2,
            uuid: 'uuid',
            title: 'title',
            titleTranslation: 'titleTranslation',
            labelId: 1,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 1,
            specialCharacter: SpecialCharacter.none,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2024-01-01 11:15:19',
            editionDate: ''),
        parentTermName: '',
        numberOfMedias: 0,
        hasNote: false,
        indexInTerm: 1,
      )..questionTags = [
          const QuestionTag(
              id: 3,
              name: 'Parent Tag 2',
              parentTagId: 0,
              hasInformation: 0,
              creation: '2024-01-01 11:13:15'),
          const QuestionTag(
              id: 4,
              name: 'Child Tag 2',
              parentTagId: 3,
              hasInformation: 0,
              creation: '2024-01-01 11:13:15'),
        ],
      QuestionData(
        const Question(
            id: 3,
            uuid: 'uuid',
            title: 'title',
            titleTranslation: 'titleTranslation',
            labelId: 1,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 1,
            specialCharacter: SpecialCharacter.none,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2024-01-01 11:15:19',
            editionDate: ''),
        parentTermName: '',
        numberOfMedias: 0,
        hasNote: false,
        indexInTerm: 1,
      )..questionTags = [],
    ];
  }

  setUp(() async {
    await initTests();
    testArguments = QuestionsReportScreenArgument(
      questions: createTestQuestions(),
      timer: Timer(const Duration(seconds: 60), () {}),
    );
    Get.put(testArguments);
    controller = QuestionsReportController();
  });

  group('QuestionsReportController Initialization', () {
    test('should detect questions with no tags', () {
      expect(controller.questionsWithNoQuestionsTagsExists, isTrue);
    });
  });

  group('Tag Configuration', () {
    test('should correctly separate parent and child tags', () {
      expect(controller.parentQuestionTags.length, 2);
      expect(controller.childQuestionTags.length, 2);

      // Verify parent tags have parentTagId = 0
      for (final tag in controller.parentQuestionTags) {
        expect(tag.parentTagId, 0);
      }

      // Verify child tags have parentTagId != 0
      for (final tag in controller.childQuestionTags) {
        expect(tag.parentTagId, isNot(0));
      }
    });

    test('should not add duplicate tags', () {
      // Add a question with duplicate tags
      final questions = createTestQuestions();
      questions.add(
        QuestionData(
          const Question(
              id: 10,
              uuid: 'uuid',
              title: 'title',
              titleTranslation: 'titleTranslation',
              labelId: 1,
              note: 'note',
              noteTranslation: 'noteTranslation',
              parentTermId: 1,
              specialCharacter: SpecialCharacter.none,
              type: 1,
              edited: 0,
              imageUrl: '',
              creation: '2024-01-01 11:15:19',
              editionDate: ''),
          parentTermName: '',
          numberOfMedias: 0,
          hasNote: false,
          indexInTerm: 1,
        )..questionTags = [
            const QuestionTag(
                id: 1,
                name: 'Parent Tag 1',
                parentTagId: 0,
                hasInformation: 0,
                creation: '2024-01-01 11:13:15'),
            const QuestionTag(
                id: 2,
                name: 'Child Tag 1',
                parentTagId: 1,
                hasInformation: 0,
                creation: '2024-01-01 11:13:15'),
          ],
      );

      Get.reset();
      Get.put(QuestionsReportScreenArgument(
        questions: questions,
        timer: Timer(const Duration(seconds: 60), () {}),
      ));
      final dupController = QuestionsReportController();

      expect(dupController.parentQuestionTags.length, 2);
      expect(dupController.childQuestionTags.length, 2);
    });

    test('should sort child tags by parentTagId', () {
      // The child tags should be sorted by their parentTagId
      for (int i = 1; i < controller.childQuestionTags.length; i++) {
        expect(
          controller.childQuestionTags[i - 1].parentTagId,
          lessThanOrEqualTo(controller.childQuestionTags[i].parentTagId),
        );
      }
    });

    test('should include all tags in allQuestionTags', () {
      expect(
          controller.allQuestionTags.length,
          controller.parentQuestionTags.length +
              controller.childQuestionTags.length);
    });
  });

  group('Parent Tag Lookup', () {
    test('getParentTag should return correct parent tag', () {
      final parentTag = controller.getParentTag(1);
      expect(parentTag, isNotNull);
      expect(parentTag!.name, 'Parent Tag 1');
    });

    test('getParentTag should return null for non-existent parent', () {
      expect(controller.getParentTag(999), isNull);
    });

    test('getParentTag should return null for child tag ID', () {
      expect(controller.getParentTag(2), isNull);
    });
  });

  group('Edge Cases', () {
    test(
        'should handle questions with only parent tags, should be considered a child tag, too',
        () {
      final questions = [
        QuestionData(
          const Question(
              id: 10,
              uuid: 'uuid',
              title: 'title',
              titleTranslation: 'titleTranslation',
              labelId: 1,
              note: 'note',
              noteTranslation: 'noteTranslation',
              parentTermId: 1,
              specialCharacter: SpecialCharacter.none,
              type: 1,
              edited: 0,
              imageUrl: '',
              creation: '2024-01-01 11:15:19',
              editionDate: ''),
          parentTermName: '',
          numberOfMedias: 0,
          hasNote: false,
          indexInTerm: 1,
        )..questionTags = [
            const QuestionTag(
                id: 1,
                name: 'Parent Only',
                parentTagId: 0,
                hasInformation: 0,
                creation: '2024-01-01 11:13:15'),
          ],
      ];

      Get.reset();
      Get.put(QuestionsReportScreenArgument(
        questions: questions,
        timer: Timer(const Duration(seconds: 60), () {}),
      ));
      final controller = QuestionsReportController();

      expect(controller.parentQuestionTags.length, 1);
      expect(controller.childQuestionTags.length, 1);
      expect(controller.allQuestionTags.length, 1);
    });

    test('should handle questions with only child tags', () {
      final questions = [
        QuestionData(
          const Question(
              id: 10,
              uuid: 'uuid',
              title: 'title',
              titleTranslation: 'titleTranslation',
              labelId: 1,
              note: 'note',
              noteTranslation: 'noteTranslation',
              parentTermId: 1,
              specialCharacter: SpecialCharacter.none,
              type: 1,
              edited: 0,
              imageUrl: '',
              creation: '2024-01-01 11:15:19',
              editionDate: ''),
          parentTermName: '',
          numberOfMedias: 0,
          hasNote: false,
          indexInTerm: 1,
        )..questionTags = [
            const QuestionTag(
                id: 2,
                name: 'Child Only',
                parentTagId: 1,
                hasInformation: 0,
                creation: '2024-01-01 11:13:15'),
          ],
      ];

      Get.reset();
      Get.put(QuestionsReportScreenArgument(
        questions: questions,
        timer: Timer(const Duration(seconds: 0), () {}),
      ));
      final controller = QuestionsReportController();

      expect(controller.parentQuestionTags, isEmpty);
      expect(controller.childQuestionTags.length, 1);
      expect(controller.allQuestionTags.length, 1);
    });

    test('should handle orphan child tags (parent not in any question)', () {
      final questions = [
        QuestionData(
          const Question(
              id: 10,
              uuid: 'uuid',
              title: 'title',
              titleTranslation: 'titleTranslation',
              labelId: 1,
              note: 'note',
              noteTranslation: 'noteTranslation',
              parentTermId: 1,
              specialCharacter: SpecialCharacter.none,
              type: 1,
              edited: 0,
              imageUrl: '',
              creation: '2024-01-01 11:15:19',
              editionDate: ''),
          parentTermName: '',
          numberOfMedias: 0,
          hasNote: false,
          indexInTerm: 1,
        )..questionTags = [
            const QuestionTag(
                id: 2,
                name: 'Orphan Child',
                parentTagId: 99,
                hasInformation: 0,
                creation: '2024-01-01 11:13:15'), // Parent 99 doesn't exist
          ],
      ];

      Get.reset();
      Get.put(QuestionsReportScreenArgument(
        questions: questions,
        timer: Timer(const Duration(seconds: 60), () {}),
      ));
      final controller = QuestionsReportController();

      expect(controller.parentQuestionTags, isEmpty);
      expect(controller.childQuestionTags.length, 1);
      expect(controller.getParentTag(99), isNull);
    });
  });
}
