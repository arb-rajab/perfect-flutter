import 'package:beta/application/services/database_service.dart';

class FlashcardService {
  final DatabaseService databaseService;

  FlashcardService({required this.databaseService});

  Future addFlashcards(List<Flashcard> flashcards) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.flashcards, flashcards));

  Future<List<Flashcard>> getFlashcardsFromQuery(String query) =>
      (databaseService
          .customSelect(query)
          .watch()
          .map((rows) => rows
              .map(
                (row) => databaseService.flashcards.map(row.data),
              )
              .toList())
          .first);
}
