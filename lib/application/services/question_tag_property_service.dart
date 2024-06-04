import 'package:beta/application/services/database_service.dart';

class QuestionTagPropertyService {
  DatabaseService databaseService;
  QuestionTagPropertyService({required this.databaseService});

  //TODO add test
  Future addQuestionTagPropertiesFromJson(dynamic data) =>
      databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(
            databaseService.questionTagProperties,
            (data as List)
                .map((e) => QuestionTagProperty.fromJson(e))
                .toList());
      });

  //TODO add test
  Future<List<QuestionTagProperty>> getAllQuestionTagProperties() =>
      databaseService.select(databaseService.questionTagProperties).get();
}
