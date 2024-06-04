import 'package:beta/application/services/database_service.dart';

class AnswerPropertyService {
  DatabaseService databaseService;
  AnswerPropertyService({required this.databaseService});

  Future deleteAllUserCheckedAnswers() =>
      (databaseService.delete(databaseService.answerProperties)
            ..where((tbl) => tbl.name.equals('checked')))
          .go();

  //TODO add test
  Future addAnswerPropertiesFromJson(dynamic data) =>
      databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(databaseService.answerProperties,
            (data as List).map((e) => AnswerProperty.fromJson(e)).toList());
      });

  //TODO add test
  Future<List<AnswerProperty>> getAllAnswerProperties() =>
      databaseService.select(databaseService.answerProperties).get();
}
