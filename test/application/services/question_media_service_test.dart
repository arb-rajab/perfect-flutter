import 'package:flutter_test/flutter_test.dart';
import 'package:beta/application/services/question_media_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/question_data.dart';

import '../../common/tests.dart'; // for initTests

void main() {
  group('QuestionMediaService', () {
    late QuestionMediaService service;

    setUp(() async {
      await initTests();
      service = QuestionMediaService(databaseService: databaseService);
    });

    test('addQuestionMedias inserts media and can be fetched', () async {
      // Insert a question first
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
      await databaseService.into(databaseService.questions).insert(question);

      const media = QuestionMedia(
        id: 1,
        url: 'http://example.com/media1.png',
        parentQuestionId: 1,
        creation: '2025-01-01T00:00:00Z',
      );

      await service.addQuestionMedias([media]);

      final allMedias =
          await databaseService.select(databaseService.questionMedias).get();
      expect(allMedias, contains(media));
    });

    test('getAllQuestionMedias returns only medias for the given question',
        () async {
      // Insert two questions
      const question1 = Question(
        id: 2,
        uuid: 'uuid-2',
        title: 'Test Question 2',
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
      const question2 = Question(
        id: 3,
        uuid: 'uuid-3',
        title: 'Test Question 3',
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
      await databaseService.into(databaseService.questions).insert(question1);
      await databaseService.into(databaseService.questions).insert(question2);

      const media1 = QuestionMedia(
        id: 2,
        url: 'http://example.com/media2.png',
        parentQuestionId: 2,
        creation: '2025-01-01T00:00:00Z',
      );
      const media2 = QuestionMedia(
        id: 3,
        url: 'http://example.com/media3.png',
        parentQuestionId: 2,
        creation: '2025-01-01T00:00:00Z',
      );
      const media3 = QuestionMedia(
        id: 4,
        url: 'http://example.com/media4.png',
        parentQuestionId: 3,
        creation: '2025-01-01T00:00:00Z',
      );

      await service.addQuestionMedias([media1, media2, media3]);

      final questionData = QuestionData(
        question1,
        parentTermName: 'Term',
        numberOfMedias: 2,
        hasNote: false,
        indexInTerm: 0,
      );

      final medias = await service.getAllQuestionMedias(questionData);
      expect(medias, containsAll([media1, media2]));
      expect(medias, isNot(contains(media3)));
    });

    test('addQuestionMedias handles empty input gracefully', () async {
      await service.addQuestionMedias([]);
      final allMedias =
          await databaseService.select(databaseService.questionMedias).get();
      expect(allMedias, isList);
    });
    test('addQuestionMedias updates on conflict', () async {
      // Insert a question first
      const question = Question(
        id: 10,
        uuid: 'uuid-10',
        title: 'Conflict Question',
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

      const original = QuestionMedia(
        id: 100,
        url: 'http://example.com/original.png',
        parentQuestionId: 10,
        creation: '2025-01-01T00:00:00Z',
      );
      const updated = QuestionMedia(
        id: 100,
        url: 'http://example.com/updated.png',
        parentQuestionId: 10,
        creation: '2025-01-02T00:00:00Z',
      );

      await service.addQuestionMedias([original]);
      await service.addQuestionMedias([updated]);

      final allMedias =
          await databaseService.select(databaseService.questionMedias).get();
      // Only one record with the updated data should exist
      expect(
          allMedias
              .where((m) => m.id == 100 && m.parentQuestionId == 10)
              .length,
          1);
      expect(allMedias, contains(updated));
      expect(allMedias, isNot(contains(original)));
    });
  });
}
