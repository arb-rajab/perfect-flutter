import 'package:beta/application/services/database_service.dart';

class QuestionLinkedToTagService {
  final DatabaseService databaseService;

  QuestionLinkedToTagService({required this.databaseService});

  //TODO add test
  Future addQuestionsLinkdeToTags(
          List<QuestionsLinkedToTag> questionsLinkedToTags) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.questionsLinkedToTags, questionsLinkedToTags));
}
