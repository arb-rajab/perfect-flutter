import 'package:beta/application/services/database_service.dart';

class AnswerPropertyService {
  DatabaseService databaseService;
  AnswerPropertyService({required this.databaseService});

  Future deleteAllUserCheckedAnswers() =>
      (databaseService.delete(databaseService.answerProperties)
            ..where((tbl) => tbl.name.equals('checked')))
          .go();
}
