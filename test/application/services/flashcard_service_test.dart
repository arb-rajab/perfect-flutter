import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';

void main() async {
  late FlashcardService flashcardService = Get.find();
  setUp(() async {
    await initTests();
    flashcardService = Get.find();
  });

  group('FlashcardService', () {
    test('addFlashcards adds flashcards', () async {
      const flashcard = Flashcard(
        id: 1,
        head: 'head1',
        tail: 'tail1',
        parentTermId: 10,
      );

      // Ensure no flashcards exist
      final before = await (databaseService.select(databaseService.flashcards)
            ..where((tbl) => tbl.id.equals(flashcard.id)))
          .get();
      expect(before.length, 0);

      await flashcardService.addFlashcards([flashcard]);

      final after = await (databaseService.select(databaseService.flashcards)
            ..where((tbl) => tbl.id.equals(flashcard.id)))
          .get();
      expect(after.length, 1);
      expect(after.first.head, 'head1');
      expect(after.first.tail, 'tail1');
      expect(after.first.parentTermId, 10);
    });

    test('addFlashcards adds flashcards overrides current flashcard', () async {
      const flashcard = Flashcard(
        id: 1,
        head: 'head1',
        tail: 'tail1',
        parentTermId: 10,
      );

      // Ensure no flashcards exist
      final before = await (databaseService.select(databaseService.flashcards)
            ..where((tbl) => tbl.id.equals(flashcard.id)))
          .get();
      expect(before.length, 0);

      await flashcardService.addFlashcards([flashcard]);

      var after = await (databaseService.select(databaseService.flashcards)
            ..where((tbl) => tbl.id.equals(flashcard.id)))
          .get();
      expect(after.length, 1);

      await flashcardService.addFlashcards([flashcard.copyWith(head: 'head2')]);
      after = await (databaseService.select(databaseService.flashcards)
            ..where((tbl) => tbl.id.equals(flashcard.id)))
          .get();

      expect(after.length, 1);
      expect(after.first.head, 'head2');
      expect(after.first.tail, 'tail1');
      expect(after.first.parentTermId, 10);
    });

    test('getFlashcardsFromQuery returns correct flashcards', () async {
      const flashcard = Flashcard(
        id: 2,
        head: 'head2',
        tail: 'tail2',
        parentTermId: 20,
      );

      const flashcard2 = Flashcard(
        id: 3,
        head: 'head3',
        tail: 'tail3',
        parentTermId: 30,
      );
      await flashcardService.addFlashcards([flashcard, flashcard2]);

      final result = await flashcardService
          .getFlashcardsFromQuery('SELECT * FROM flashcards WHERE id = 2');
      expect(result.length, 1);
      expect(result.first.id, 2);
      expect(result.first.head, 'head2');
      expect(result.first.tail, 'tail2');
      expect(result.first.parentTermId, 20);
    });
  });
}
