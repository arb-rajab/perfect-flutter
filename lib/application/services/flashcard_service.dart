import 'package:beta/application/services/database_service.dart';

class FlashcardService {
  final DatabaseService databaseService;

  FlashcardService({required this.databaseService});

  //TODO add test
  Future addFlashcards(List<Flashcard> flashcards) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.flashcards, flashcards));
}
