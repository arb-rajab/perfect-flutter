import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/value/id.dart';
import 'package:drift/drift.dart';

class QuestionTagPropertyService {
  DatabaseService databaseService;
  QuestionTagPropertyService({required this.databaseService});

  Future addQuestionTagPropertiesFromJson(dynamic data) =>
      databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(
            databaseService.questionTagProperties,
            (data as List)
                .map((e) => QuestionTagProperty.fromJson(e))
                .toList());
      });

  Future<List<QuestionTagProperty>> getAllQuestionTagProperties() =>
      databaseService.select(databaseService.questionTagProperties).get();

  Future addQuestionTagProperty(Id questionTagId, String name, String value) =>
      databaseService
          .into(databaseService.questionTagProperties)
          .insertOnConflictUpdate(QuestionTagProperty(
              questionTagId: questionTagId.value!, name: name, value: value));

  Future<QuestionTagProperty?> getQuestionTagProperty(
          int questionTagId, String name) =>
      (databaseService.select(databaseService.questionTagProperties)
            ..where((tbl) => Expression.and([
                  tbl.questionTagId.equals(questionTagId),
                  tbl.name.equals(name)
                ]))
            ..limit(1))
          .get()
          .then((value) {
        if (value.isEmpty) return null;
        return value.first;
      });
}
