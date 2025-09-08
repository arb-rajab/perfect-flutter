import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/question_data.dart';

class QuestionMediaService {
  final DatabaseService databaseService;

  QuestionMediaService({required this.databaseService});

  Future addQuestionMedias(List<QuestionMedia> questionMedias) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.questionMedias, questionMedias));

  Future<List<QuestionMedia>> getAllQuestionMedias(QuestionData questionData) =>
      (databaseService.select(databaseService.questionMedias)
            ..where(
                (tbl) => tbl.parentQuestionId.equals(questionData.question.id)))
          .get();
}
