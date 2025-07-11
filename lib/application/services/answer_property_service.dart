import 'package:beta/application/services/database_service.dart';


class AnswerPropertyService {
  DatabaseService databaseService;
  AnswerPropertyService({required this.databaseService});

  Future deleteAllUserCheckedAnswers() =>
      (databaseService.delete(databaseService.answerProperties)
            ..where((tbl) => tbl.name.equals('checked')))
          .go();

  Future addAnswerPropertiesFromJson(dynamic data) =>
      databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(databaseService.answerProperties,
            (data as List).map((e) => AnswerProperty.fromJson(e)).toList());
      });

  Future<List<AnswerProperty>> getAllAnswerProperties() =>
      databaseService.select(databaseService.answerProperties).get();

  Future<List<AnswerProperty>> getAnswerProperties(int answerId) =>
      (databaseService.select(databaseService.answerProperties)
            ..where((tbl) => tbl.answerId.equals(answerId)))
          .get();

  Future checkAnswer(int answerId) => databaseService
      .into(databaseService.answerProperties)
      .insertOnConflictUpdate(
          AnswerProperty(answerId: answerId, name: 'checked', value: 'true'));

  Future uncheckAnswer(int answerId) =>
      (databaseService.delete(databaseService.answerProperties)
            ..where((tbl) => tbl.answerId.equals(answerId))
            ..where((tbl) => tbl.name.equals('checked')))
          .go();
}
