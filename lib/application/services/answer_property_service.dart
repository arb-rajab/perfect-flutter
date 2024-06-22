import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/value/id.dart';

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

  //TODO add test
  Future<List<AnswerProperty>> getAnswerProperties(int answerId) =>
      (databaseService.select(databaseService.answerProperties)
            ..where((tbl) => tbl.answerId.equals(answerId)))
          .get();

  //TODO add test
  Future checkAnswer(int answerId) => databaseService
      .into(databaseService.answerProperties)
      .insertOnConflictUpdate(
          AnswerProperty(answerId: answerId, name: 'checked', value: 'true'));

  //TODO add test
  Future uncheckAnswer(int answerId) =>
      (databaseService.delete(databaseService.answerProperties)
            ..where((tbl) => tbl.answerId.equals(answerId))
            ..where((tbl) => tbl.name.equals('checked')))
          .go();
}
