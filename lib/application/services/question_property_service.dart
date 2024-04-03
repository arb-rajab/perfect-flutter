import 'package:beta/application/services/database_service.dart';

class QuestionPropertyService {
  DatabaseService databaseService;
  QuestionPropertyService({required this.databaseService});

  Future deleteAllUserNotes() =>
      (databaseService.delete(databaseService.questionProperties)
            ..where((tbl) => tbl.name.equals('userNote')))
          .go();

  Future deleteAllUserFavoriteQuestions() =>
      (databaseService.delete(databaseService.questionProperties)
            ..where((tbl) => tbl.name.equals('favorite')))
          .go();
}
