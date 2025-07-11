import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/value/id.dart';

class AnswerService {
  final DatabaseService databaseService;

  AnswerService({required this.databaseService});

  Future addAnswers(List<Answer> answers) => databaseService.batch((batch) =>
      batch.insertAllOnConflictUpdate(databaseService.answers, answers));

  Future<List<Answer>> getQuestionAnswers(Id questionId) =>
      (databaseService.select(databaseService.answers)
            ..where((tbl) => tbl.parentQuestionId.equals(questionId.value!)))
          .get();
}
