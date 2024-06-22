import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:drift/drift.dart';

class QuestionService {
  final DatabaseService databaseService;

  QuestionService({required this.databaseService});

  //TODO add test
  Future addQuestions(List<Question> questions) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.questions, questions));

  //TODO add test
  Future<int> getNumberOfEasyQuestions(TermData termData) async =>
      (await databaseService
              .customSelect(
                  "select count(*) as numberOfEasyQuestions from questions q where id in (select parentQuestionId from answers where  isCorrect=1 and parentQuestionId=q.id and checkedCount=(select max(checkedCount) from answers where parentQuestionId=q.id) ) and (select sum(checkedCount) from answers where parentQuestionId=q.id)>25 and parentTermId in (select termId from termTrees where parentTermId=${termData.term.id})")
              .watch()
              .map((rows) => rows
                  .map((row) => row.read<int>('numberOfEasyQuestions'))
                  .toList())
              .first)
          .first;

  //TODO add test
  Future<int> getNumberOfMediumQuestions(TermData termData) async =>
      (await databaseService
              .customSelect(
                  "select count(*) as numberOfMediumQuestions from questions q where id in (select parentQuestionId from answers where  isCorrect=1 and parentQuestionId=q.id and checkedCount<(select max(checkedCount) from answers where parentQuestionId=q.id) and checkedCount> (select min(checkedCount) from answers where parentQuestionId=q.id)) and (select sum(checkedCount) from answers where parentQuestionId=q.id)>25 and parentTermId in (select termId from termTrees where parentTermId=${termData.term.id})")
              .watch()
              .map((rows) => rows
                  .map((row) => row.read<int>('numberOfMediumQuestions'))
                  .toList())
              .first)
          .first;

  //TODO add test
  Future<int> getNumberOfDifficultQuestions(TermData termData) async =>
      (await databaseService
              .customSelect(
                  "select count(*) as numberOfDifficultQuestions from questions q where id in (select parentQuestionId from answers where  isCorrect=1 and parentQuestionId=q.id and checkedCount=(select min(checkedCount) from answers where parentQuestionId=q.id) ) and (select sum(checkedCount) from answers where parentQuestionId=q.id)>25 and parentTermId in (select termId from termTrees where parentTermId=${termData.term.id})")
              .watch()
              .map((rows) => rows
                  .map((row) => row.read<int>('numberOfDifficultQuestions'))
                  .toList())
              .first)
          .first;

  //TODO add test
  Future<int> getNumberOfEditedQuestions(TermData termData) async =>
      (await databaseService
              .customSelect(
                  "select count(*) as numberOfEditedQuestions from questions where edited=1 and parentTermId in "
                  "(select termId from termTrees where parentTermId=${termData.term.id})")
              .watch()
              .map((rows) => rows
                  .map((row) => row.read<int>('numberOfEditedQuestions'))
                  .toList())
              .first)
          .first;

  //TODO add test
  Future<int> getNumberOfWrongQuestions(TermData termData) async =>
      (await databaseService
              .customSelect(
                  "select count(*) as numberOfWrongQuestions from questions q where q.id in (select parentQuestionId from answers where isCorrect=0 and id in (select answerId from answerProperties where name='checked' and value='true'))and q.parentTermId in (select termId from termTrees where parentTermId =${termData.term.id} and depth>0)")
              .watch()
              .map((rows) => rows
                  .map((row) => row.read<int>('numberOfWrongQuestions'))
                  .toList())
              .first)
          .first;

  Future<List<QuestionData>> getQuestionsFromQuery(String query) =>
      (databaseService
          .customSelect(query)
          .watch()
          .map((rows) => rows
              .map(
                (row) => QuestionData.fromMap(row),
              )
              .toList())
          .first);
  
}
