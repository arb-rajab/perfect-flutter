import 'package:beta/application/services/database_service.dart';

class QuestionMediaService {
  final DatabaseService databaseService;

  QuestionMediaService({required this.databaseService});

  //TODO add test
  Future addQuestionMedias(List<QuestionMedia> questionMedias) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.questionMedias, questionMedias));
}
