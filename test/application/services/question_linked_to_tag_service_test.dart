import 'package:flutter_test/flutter_test.dart';
import 'package:beta/application/services/question_linked_to_tag_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart'; // This import provides QuestionsLinkedToTag

void main() {
  group('QuestionLinkedToTagService', () {
    late QuestionLinkedToTagService service;

    setUp(() async {
      await initTests();
      service = Get.find();
    });
    test('inserts a QuestionsLinkedToTag and verifies it is in the database',
        () async {
      const link = QuestionsLinkedToTag(questionId: 1, tagId: 1);
      await service.addQuestionsLinkdeToTags([link]);
      final allLinks = await databaseService
          .select(databaseService.questionsLinkedToTags)
          .get();
      expect(allLinks, contains(link));
    });

    test('inserts multiple QuestionsLinkedToTag records', () async {
      const links = [
        QuestionsLinkedToTag(questionId: 2, tagId: 1),
        QuestionsLinkedToTag(questionId: 2, tagId: 2),
        QuestionsLinkedToTag(questionId: 2, tagId: 3),
      ];
      await service.addQuestionsLinkdeToTags(links);
      final allLinks = await databaseService
          .select(databaseService.questionsLinkedToTags)
          .get();
      for (final link in links) {
        expect(allLinks, contains(link));
      }
    });

    test('updates on conflict', () async {
      const link = QuestionsLinkedToTag(questionId: 3, tagId: 1);
      await service.addQuestionsLinkdeToTags([link]);
      // Insert again with same PK, should not throw and should still exist
      await service.addQuestionsLinkdeToTags([link]);
      final allLinks = await databaseService
          .select(databaseService.questionsLinkedToTags)
          .get();
      expect(
          allLinks.where((l) => l.questionId == 3 && l.tagId == 1).length, 1);
    });

    test('handles empty input gracefully', () async {
      await service.addQuestionsLinkdeToTags([]);
      final allLinks = await databaseService
          .select(databaseService.questionsLinkedToTags)
          .get();
      // Should not throw, and DB remains unchanged (empty or as before)
      expect(allLinks, isList);
    });
  });
}
