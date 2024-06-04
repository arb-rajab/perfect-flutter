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

  //TODO add test
  Future addQuestionPropertiesFromJson(dynamic data) =>
      databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(databaseService.questionProperties,
            (data as List).map((e) => QuestionProperty.fromJson(e)).toList());
      });

  //TODO add test
  Future<List<QuestionProperty>> getAllQuestionProperties() =>
      databaseService.select(databaseService.questionProperties).get();
}
