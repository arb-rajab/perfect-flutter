import 'dart:ffi';

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

  //TODO add test
  Future addQuestionPropertiesFromJson(dynamic data) =>
      databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(databaseService.questionProperties,
            (data as List).map((e) => QuestionProperty.fromJson(e)).toList());
      });

  //TODO add test
  Future<List<QuestionProperty>> getAllQuestionProperties() =>
      databaseService.select(databaseService.questionProperties).get();

  //TODO add test
  Future<List<QuestionProperty>> getQuestionProperties(Id questionId) =>
      (databaseService.select(databaseService.questionProperties)
            ..where((tbl) => tbl.questionId.equals(questionId.value!)))
          .get();

  //TODO add test
  Future addQuestionToFavorite(int questionId) => databaseService
      .into(databaseService.questionProperties)
      .insert(QuestionProperty(
          questionId: questionId, name: 'favorite', value: 'true'));

  //TODO add test
  Future removeQuestionFromFavorite(int questionId) => (databaseService
          .delete(databaseService.questionProperties)
        ..where((tbl) => Expression.and(
            [tbl.questionId.equals(questionId), tbl.name.equals('favorite')])))
      .go();

  //TODO add test
  Future setUserNote(int questionId, String value) async {
    await deleteUserNote(questionId);
    return databaseService.into(databaseService.questionProperties).insert(
        QuestionProperty(
            questionId: questionId, name: 'userNote', value: value));
  }

  //TODO add test
  Future deleteUserNote(int questionId) => (databaseService
          .delete(databaseService.questionProperties)
        ..where((tbl) => Expression.and(
            [tbl.questionId.equals(questionId), tbl.name.equals('userNote')])))
      .go();
}
