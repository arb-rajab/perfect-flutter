import 'package:beta/application/services/database_service.dart';

class AnswerService {
  final DatabaseService databaseService;

  AnswerService({required this.databaseService});

  //TODO add test
  Future addAnswers(List<Answer> answers) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.answers, answers));
}
