import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/value/id.dart';
import 'package:drift/drift.dart';

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

  Future addQuestionPropertiesFromJson(dynamic data) =>
      databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(databaseService.questionProperties,
            (data as List).map((e) => QuestionProperty.fromJson(e)).toList());
      });

  Future<List<QuestionProperty>> getAllQuestionProperties() =>
      databaseService.select(databaseService.questionProperties).get();

  Future<List<QuestionProperty>> getQuestionProperties(Id questionId) =>
      (databaseService.select(databaseService.questionProperties)
            ..where((tbl) => tbl.questionId.equals(questionId.value!)))
          .get();

  Future addQuestionToFavorite(int questionId) => databaseService
      .into(databaseService.questionProperties)
      .insert(QuestionProperty(
          questionId: questionId, name: 'favorite', value: 'true'));

  Future removeQuestionFromFavorite(int questionId) => (databaseService
          .delete(databaseService.questionProperties)
        ..where((tbl) => Expression.and(
            [tbl.questionId.equals(questionId), tbl.name.equals('favorite')])))
      .go();

  Future setUserNote(int questionId, String value) async {
    await deleteUserNote(questionId);
    return databaseService.into(databaseService.questionProperties).insert(
        QuestionProperty(
            questionId: questionId, name: 'userNote', value: value));
  }

  Future deleteUserNote(int questionId) => (databaseService
          .delete(databaseService.questionProperties)
        ..where((tbl) => Expression.and(
            [tbl.questionId.equals(questionId), tbl.name.equals('userNote')])))
      .go();
}
