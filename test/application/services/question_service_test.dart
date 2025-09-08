import 'package:flutter_test/flutter_test.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart'; // for initTests

void main() {
  group('QuestionService', () {
    late QuestionService service;

    setUp(() async {
      await initTests();
      service = Get.find();
    });

    test('addQuestions inserts questions and can be fetched', () async {
      const question = Question(
        id: 1,
        uuid: 'uuid-1',
        title: 'Test Question',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 1,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );

      await service.addQuestions([question]);
      final allQuestions =
          await databaseService.select(databaseService.questions).get();
      expect(allQuestions, contains(question));
    });

    test('addQuestions updates on conflict', () async {
      const original = Question(
        id: 10,
        uuid: 'uuid-10',
        title: 'Original Question',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 1,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      const updated = Question(
        id: 10,
        uuid: 'uuid-10',
        title: 'Updated Question',
        titleTranslation: 'TR',
        labelId: 2,
        note: 'Updated note',
        noteTranslation: 'TR note',
        parentTermId: 1,
        specialCharacter: 1,
        type: 1,
        edited: 1,
        imageUrl: 'updated.png',
        creation: '2025-01-02T00:00:00Z',
        editionDate: '2025-01-02T00:00:00Z',
      );

      await service.addQuestions([original]);
      await service.addQuestions([updated]);

      final allQuestions =
          await databaseService.select(databaseService.questions).get();
      // Only one record with the updated data should exist
      expect(allQuestions.where((q) => q.id == 10).length, 1);
      expect(allQuestions, contains(updated));
      expect(allQuestions, isNot(contains(original)));
    });

    test(
        'getNumberOfEasyQuestions ignores questions with checkedCount sum < 25',
        () async {
      const term = Term(
        id: 100,
        uuid: 'term-uuid-100',
        name: 'Term 100',
        type: 0,
        creation: '2025-01-01T00:00:00Z',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
      );
      await databaseService.into(databaseService.terms).insert(term);

      const termTree = TermTree(
        termId: 100,
        parentTermId: 100,
        depth: 0,
      );
      await databaseService.into(databaseService.termTrees).insert(termTree);

      const question = Question(
        id: 100,
        uuid: 'uuid-q100',
        title: 'Should Not Count',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 100,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(question);

      // Answers: sum(checkedCount) = 10 + 5 = 15 (< 25)
      const answer1 = Answer(
        id: 100,
        uuid: 'a-uuid-100',
        title: 'Correct',
        titleTranslation: '',
        isCorrect: 1,
        parentQuestionId: 100,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 10,
      );
      const answer2 = Answer(
        id: 101,
        uuid: 'a-uuid-101',
        title: 'Incorrect',
        titleTranslation: '',
        isCorrect: 0,
        parentQuestionId: 100,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 5,
      );
      await databaseService.into(databaseService.answers).insert(answer1);
      await databaseService.into(databaseService.answers).insert(answer2);

      final termData = TermData(term);
      final count = await service.getNumberOfEasyQuestions(termData);
      expect(count, 0); // Should not count this question
    });
    test('getNumberOfEasyQuestions ignores questions of other terms', () async {
      const term = Term(
        id: 100,
        uuid: 'term-uuid-100',
        name: 'Term 100',
        type: 0,
        creation: '2025-01-01T00:00:00Z',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
      );
      await databaseService.into(databaseService.terms).insert(term);

      const termTree = TermTree(
        termId: 100,
        parentTermId: 100,
        depth: 0,
      );
      await databaseService.into(databaseService.termTrees).insert(termTree);

      const question = Question(
        id: 100,
        uuid: 'uuid-q100',
        title: 'Should Not Count',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 101,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(question);

      // Answers: sum(checkedCount) = 10 + 5 = 15 (< 25)
      const answer1 = Answer(
        id: 100,
        uuid: 'a-uuid-100',
        title: 'Correct',
        titleTranslation: '',
        isCorrect: 1,
        parentQuestionId: 100,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 40,
      );
      const answer2 = Answer(
        id: 101,
        uuid: 'a-uuid-101',
        title: 'Incorrect',
        titleTranslation: '',
        isCorrect: 0,
        parentQuestionId: 100,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 5,
      );
      await databaseService.into(databaseService.answers).insert(answer1);
      await databaseService.into(databaseService.answers).insert(answer2);

      final termData = TermData(term);
      final count = await service.getNumberOfEasyQuestions(termData);
      expect(count, 0); // Should not count this question
    });

    test('getNumberOfEasyQuestions counts only easy questions', () async {
      const term = Term(
        id: 200,
        uuid: 'term-uuid-200',
        name: 'Term 200',
        type: 0,
        creation: '2025-01-01T00:00:00Z',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
      );
      await databaseService.into(databaseService.terms).insert(term);

      const termTree = TermTree(
        termId: 200,
        parentTermId: 200,
        depth: 0,
      );
      await databaseService.into(databaseService.termTrees).insert(termTree);

      // Easy question: correct answer has max checkedCount, sum >= 25
      const easyQ = Question(
        id: 201,
        uuid: 'uuid-easy',
        title: 'Easy Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 200,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(easyQ);
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 201,
            uuid: 'a-easy',
            title: 'Correct',
            titleTranslation: '',
            isCorrect: 1,
            parentQuestionId: 201,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 30,
          ));

      // Medium question: correct answer checkedCount < max, > min, sum >= 25
      const mediumQ = Question(
        id: 202,
        uuid: 'uuid-medium',
        title: 'Medium Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 200,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(mediumQ);
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 202,
            uuid: 'a-medium-1',
            title: 'Correct',
            titleTranslation: '',
            isCorrect: 0,
            parentQuestionId: 202,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 20,
          ));
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 203,
            uuid: 'a-medium-2',
            title: 'Incorrect',
            titleTranslation: '',
            isCorrect: 0,
            parentQuestionId: 202,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 10,
          ));

      // Difficult question: correct answer has min checkedCount, sum >= 25
      const difficultQ = Question(
        id: 203,
        uuid: 'uuid-difficult',
        title: 'Difficult Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 200,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(difficultQ);
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 204,
            uuid: 'a-diff-1',
            title: 'Correct',
            titleTranslation: '',
            isCorrect: 1,
            parentQuestionId: 203,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 5,
          ));
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 205,
            uuid: 'a-diff-2',
            title: 'Incorrect',
            titleTranslation: '',
            isCorrect: 0,
            parentQuestionId: 203,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 30,
          ));

      final termData = TermData(term);
      final count = await service.getNumberOfEasyQuestions(termData);
      expect(count, 1); // Only the easy question should be counted
    });

    test(
        'getNumberOfMediumQuestions ignores questions with checkedCount sum < 25',
        () async {
      const term = Term(
        id: 300,
        uuid: 'term-uuid-300',
        name: 'Term 300',
        type: 0,
        creation: '2025-01-01T00:00:00Z',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
      );
      await databaseService.into(databaseService.terms).insert(term);

      const termTree = TermTree(
        termId: 300,
        parentTermId: 300,
        depth: 0,
      );
      await databaseService.into(databaseService.termTrees).insert(termTree);

      const question = Question(
        id: 300,
        uuid: 'uuid-q300',
        title: 'Should Not Count',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 300,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(question);

      // Answers: sum(checkedCount) = 10 + 5 = 15 (< 25)
      const answer1 = Answer(
        id: 300,
        uuid: 'a-uuid-300',
        title: 'Correct',
        titleTranslation: '',
        isCorrect: 1,
        parentQuestionId: 300,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 10,
      );
      const answer2 = Answer(
        id: 301,
        uuid: 'a-uuid-301',
        title: 'Incorrect',
        titleTranslation: '',
        isCorrect: 0,
        parentQuestionId: 300,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 5,
      );
      await databaseService.into(databaseService.answers).insert(answer1);
      await databaseService.into(databaseService.answers).insert(answer2);

      final termData = TermData(term);
      final count = await service.getNumberOfMediumQuestions(termData);
      expect(count, 0); // Should not count this question
    });

    test('getNumberOfMediumQuestions ignores questions of other terms',
        () async {
      const term = Term(
        id: 300,
        uuid: 'term-uuid-300',
        name: 'Term 300',
        type: 0,
        creation: '2025-01-01T00:00:00Z',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
      );
      await databaseService.into(databaseService.terms).insert(term);

      const termTree = TermTree(
        termId: 300,
        parentTermId: 300,
        depth: 0,
      );
      await databaseService.into(databaseService.termTrees).insert(termTree);

      const question = Question(
        id: 300,
        uuid: 'uuid-q300',
        title: 'Should Not Count',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 301,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(question);

      // Answers: sum(checkedCount) = 10 + 5 = 15 (< 25)
      const answer1 = Answer(
        id: 300,
        uuid: 'a-uuid-300',
        title: 'Correct',
        titleTranslation: '',
        isCorrect: 1,
        parentQuestionId: 300,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 40,
      );
      const answer2 = Answer(
        id: 301,
        uuid: 'a-uuid-301',
        title: 'Incorrect',
        titleTranslation: '',
        isCorrect: 0,
        parentQuestionId: 300,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 30,
      );
      await databaseService.into(databaseService.answers).insert(answer1);
      await databaseService.into(databaseService.answers).insert(answer2);

      final termData = TermData(term);
      final count = await service.getNumberOfMediumQuestions(termData);
      expect(count, 0); // Should not count this question
    });

    test('getNumberOfMediumQuestions counts only medium questions', () async {
      const term = Term(
        id: 400,
        uuid: 'term-uuid-400',
        name: 'Term 400',
        type: 0,
        creation: '2025-01-01T00:00:00Z',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
      );
      await databaseService.into(databaseService.terms).insert(term);

      const termTree = TermTree(
        termId: 400,
        parentTermId: 400,
        depth: 0,
      );
      await databaseService.into(databaseService.termTrees).insert(termTree);

      // Medium question: correct answer checkedCount < max, > min, sum >= 25
      const mediumQ = Question(
        id: 401,
        uuid: 'uuid-medium',
        title: 'Medium Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 400,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(mediumQ);
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 401,
            uuid: 'a-medium-1',
            title: 'Correct',
            titleTranslation: '',
            isCorrect: 1,
            parentQuestionId: 401,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 20,
          ));
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 402,
            uuid: 'a-medium-2',
            title: 'Incorrect',
            titleTranslation: '',
            isCorrect: 0,
            parentQuestionId: 401,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 30,
          ));
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 403,
            uuid: 'a-medium-3',
            title: 'Incorrect',
            titleTranslation: '',
            isCorrect: 0,
            parentQuestionId: 401,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 10,
          ));

      // Easy question: correct answer has max checkedCount, sum >= 25
      const easyQ = Question(
        id: 402,
        uuid: 'uuid-easy',
        title: 'Easy Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 400,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(easyQ);
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 404,
            uuid: 'a-easy',
            title: 'Correct',
            titleTranslation: '',
            isCorrect: 1,
            parentQuestionId: 402,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 40,
          ));

      // Difficult question: correct answer has min checkedCount, sum >= 25
      const difficultQ = Question(
        id: 403,
        uuid: 'uuid-difficult',
        title: 'Difficult Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 400,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(difficultQ);
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 405,
            uuid: 'a-diff-1',
            title: 'Correct',
            titleTranslation: '',
            isCorrect: 1,
            parentQuestionId: 403,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 5,
          ));
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 406,
            uuid: 'a-diff-2',
            title: 'Incorrect',
            titleTranslation: '',
            isCorrect: 0,
            parentQuestionId: 403,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 30,
          ));

      final termData = TermData(term);
      final count = await service.getNumberOfMediumQuestions(termData);
      expect(count, 1); // Only the medium question should be counted
    });

    test(
        'getNumberOfDifficultQuestions ignores questions with checkedCount sum < 25',
        () async {
      const term = Term(
        id: 500,
        uuid: 'term-uuid-500',
        name: 'Term 500',
        type: 0,
        creation: '2025-01-01T00:00:00Z',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
      );
      await databaseService.into(databaseService.terms).insert(term);

      const termTree = TermTree(
        termId: 500,
        parentTermId: 500,
        depth: 0,
      );
      await databaseService.into(databaseService.termTrees).insert(termTree);

      const question = Question(
        id: 500,
        uuid: 'uuid-q500',
        title: 'Should Not Count',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 500,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(question);

      // Answers: sum(checkedCount) = 10 + 5 = 15 (< 25)
      const answer1 = Answer(
        id: 500,
        uuid: 'a-uuid-500',
        title: 'Correct',
        titleTranslation: '',
        isCorrect: 1,
        parentQuestionId: 500,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 10,
      );
      const answer2 = Answer(
        id: 501,
        uuid: 'a-uuid-501',
        title: 'Incorrect',
        titleTranslation: '',
        isCorrect: 0,
        parentQuestionId: 500,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 5,
      );
      await databaseService.into(databaseService.answers).insert(answer1);
      await databaseService.into(databaseService.answers).insert(answer2);

      final termData = TermData(term);
      final count = await service.getNumberOfDifficultQuestions(termData);
      expect(count, 0); // Should not count this question
    });

    test('getNumberOfDifficultQuestions ignores questions of other terms',
        () async {
      const term = Term(
        id: 500,
        uuid: 'term-uuid-500',
        name: 'Term 500',
        type: 0,
        creation: '2025-01-01T00:00:00Z',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
      );
      await databaseService.into(databaseService.terms).insert(term);

      const termTree = TermTree(
        termId: 500,
        parentTermId: 500,
        depth: 0,
      );
      await databaseService.into(databaseService.termTrees).insert(termTree);

      const question = Question(
        id: 500,
        uuid: 'uuid-q500',
        title: 'Should Not Count',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 501,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(question);

      // Answers: sum(checkedCount) = 10 + 5 = 15 (< 25)
      const answer1 = Answer(
        id: 500,
        uuid: 'a-uuid-500',
        title: 'Correct',
        titleTranslation: '',
        isCorrect: 1,
        parentQuestionId: 500,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 40,
      );
      const answer2 = Answer(
        id: 501,
        uuid: 'a-uuid-501',
        title: 'Incorrect',
        titleTranslation: '',
        isCorrect: 0,
        parentQuestionId: 500,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 30,
      );
      await databaseService.into(databaseService.answers).insert(answer1);
      await databaseService.into(databaseService.answers).insert(answer2);

      final termData = TermData(term);
      final count = await service.getNumberOfDifficultQuestions(termData);
      expect(count, 0); // Should not count this question
    });

    test('getNumberOfDifficultQuestions counts only difficult questions',
        () async {
      const term = Term(
        id: 600,
        uuid: 'term-uuid-600',
        name: 'Term 600',
        type: 0,
        creation: '2025-01-01T00:00:00Z',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
      );
      await databaseService.into(databaseService.terms).insert(term);

      const termTree = TermTree(
        termId: 600,
        parentTermId: 600,
        depth: 0,
      );
      await databaseService.into(databaseService.termTrees).insert(termTree);

      // Difficult question: correct answer has min checkedCount, sum >= 25
      const difficultQ = Question(
        id: 601,
        uuid: 'uuid-difficult',
        title: 'Difficult Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 600,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(difficultQ);
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 601,
            uuid: 'a-diff-1',
            title: 'Correct',
            titleTranslation: '',
            isCorrect: 1,
            parentQuestionId: 601,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 5,
          ));
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 602,
            uuid: 'a-diff-2',
            title: 'Incorrect',
            titleTranslation: '',
            isCorrect: 0,
            parentQuestionId: 601,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 30,
          ));

      // Easy question: correct answer has max checkedCount, sum >= 25
      const easyQ = Question(
        id: 602,
        uuid: 'uuid-easy',
        title: 'Easy Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 600,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(easyQ);
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 603,
            uuid: 'a-easy',
            title: 'Correct',
            titleTranslation: '',
            isCorrect: 1,
            parentQuestionId: 602,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 40,
          ));
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 604,
            uuid: 'a-easy-2',
            title: 'inCorrect',
            titleTranslation: '',
            isCorrect: 0,
            parentQuestionId: 602,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 30,
          ));

      // Medium question: correct answer checkedCount < max, > min, sum >= 25
      const mediumQ = Question(
        id: 603,
        uuid: 'uuid-medium',
        title: 'Medium Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 600,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(mediumQ);
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 605,
            uuid: 'a-medium-1',
            title: 'Correct',
            titleTranslation: '',
            isCorrect: 1,
            parentQuestionId: 603,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 20,
          ));
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 606,
            uuid: 'a-medium-2',
            title: 'Incorrect',
            titleTranslation: '',
            isCorrect: 0,
            parentQuestionId: 603,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 30,
          ));
      await databaseService.into(databaseService.answers).insert(const Answer(
            id: 607,
            uuid: 'a-medium-3',
            title: 'Incorrect',
            titleTranslation: '',
            isCorrect: 0,
            parentQuestionId: 603,
            specialCharacter: 0,
            creation: '2025-01-01T00:00:00Z',
            checkedCount: 5,
          ));

      final termData = TermData(term);
      final count = await service.getNumberOfDifficultQuestions(termData);
      expect(count, 1); // Only the difficult question should be counted
    });

    test(
        'getNumberOfWrongQuestions counts only wrong questions with checked property and correct term tree',
        () async {
      const term = Term(
        id: 701,
        uuid: 'term-uuid-700',
        name: 'Term 700',
        type: 0,
        creation: '2025-01-01T00:00:00Z',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
      );
      await databaseService.into(databaseService.terms).insert(term);

      const termTree = TermTree(
        termId: 701,
        parentTermId: 701,
        depth: 1,
      );
      await databaseService.into(databaseService.termTrees).insert(termTree);

      // Wrong question setup
      const question = Question(
        id: 701,
        uuid: 'uuid-wrong',
        title: 'Wrong Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 701,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(question);

      const wrongAnswer = Answer(
        id: 801,
        uuid: 'a-wrong',
        title: 'Wrong',
        titleTranslation: '',
        isCorrect: 0,
        parentQuestionId: 701,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 1,
      );
      await databaseService.into(databaseService.answers).insert(wrongAnswer);

      // Mark answer as checked
      await databaseService
          .into(databaseService.answerProperties)
          .insert(const AnswerProperty(
            answerId: 801,
            name: 'checked',
            value: 'true',
          ));

// Wrong question setup
      const correctQuestion = Question(
        id: 702,
        uuid: 'uuid-correct',
        title: 'Correct Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 701,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService
          .into(databaseService.questions)
          .insert(correctQuestion);

      const correctAnswer = Answer(
        id: 802,
        uuid: 'a-correct',
        title: 'Correct',
        titleTranslation: '',
        isCorrect: 1,
        parentQuestionId: 702,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 1,
      );
      await databaseService.into(databaseService.answers).insert(correctAnswer);

      // Mark answer as checked
      await databaseService
          .into(databaseService.answerProperties)
          .insert(const AnswerProperty(
            answerId: 802,
            name: 'checked',
            value: 'true',
          ));

      final termData = TermData(term);
      final count = await service.getNumberOfWrongQuestions(termData);
      expect(count, 1); // Should count this question
    });

    test('getNumberOfWrongQuestions ignores questions of other terms',
        () async {
      const term = Term(
        id: 701,
        uuid: 'term-uuid-700',
        name: 'Term 700',
        type: 0,
        creation: '2025-01-01T00:00:00Z',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
      );
      await databaseService.into(databaseService.terms).insert(term);

      const termTree = TermTree(
        termId: 701,
        parentTermId: 701,
        depth: 1,
      );
      await databaseService.into(databaseService.termTrees).insert(termTree);

      // Wrong question setup
      const question = Question(
        id: 701,
        uuid: 'uuid-wrong',
        title: 'Wrong Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 702,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(question);

      const wrongAnswer = Answer(
        id: 801,
        uuid: 'a-wrong',
        title: 'Wrong',
        titleTranslation: '',
        isCorrect: 0,
        parentQuestionId: 701,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 1,
      );
      await databaseService.into(databaseService.answers).insert(wrongAnswer);

      // Mark answer as checked
      await databaseService
          .into(databaseService.answerProperties)
          .insert(const AnswerProperty(
            answerId: 801,
            name: 'checked',
            value: 'true',
          ));

// Wrong question setup
      const correctQuestion = Question(
        id: 702,
        uuid: 'uuid-correct',
        title: 'Correct Q',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 702,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService
          .into(databaseService.questions)
          .insert(correctQuestion);

      const correctAnswer = Answer(
        id: 802,
        uuid: 'a-correct',
        title: 'Correct',
        titleTranslation: '',
        isCorrect: 1,
        parentQuestionId: 702,
        specialCharacter: 0,
        creation: '2025-01-01T00:00:00Z',
        checkedCount: 1,
      );
      await databaseService.into(databaseService.answers).insert(correctAnswer);

      // Mark answer as checked
      await databaseService
          .into(databaseService.answerProperties)
          .insert(const AnswerProperty(
            answerId: 802,
            name: 'checked',
            value: 'true',
          ));

      final termData = TermData(term);
      final count = await service.getNumberOfWrongQuestions(termData);
      expect(count, 0); // Should count this question
    });

    test('getQuestionsFromQuery returns correct questions from custom query',
        () async {
      // Insert a question

      const question = Question(
        id: 900,
        uuid: 'uuid-900',
        title: 'Query Test Question',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 1,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(question);
      const question2 = Question(
        id: 901,
        uuid: 'uuid-901',
        title: 'Query Test Question 2',
        titleTranslation: '',
        labelId: 1,
        note: '',
        noteTranslation: '',
        parentTermId: 1,
        specialCharacter: 0,
        type: 0,
        edited: 0,
        imageUrl: '',
        creation: '2025-01-01T00:00:00Z',
        editionDate: '2025-01-01T00:00:00Z',
      );
      await databaseService.into(databaseService.questions).insert(question2);

      // Use a custom query to select the question
      const query =
          "SELECT *,'parentTermName' as parentTermName,0 as numberOfMedias,1 as hasNote,1 as indexInTerm FROM questions WHERE id = 900";
      final result = await service.getQuestionsFromQuery(query);

      expect(result.length, 1);
      expect(result.first.question.id, 900);
      expect(result.first.question.title, 'Query Test Question');
    });
  });
}
