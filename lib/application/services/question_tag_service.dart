import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';

class QuestionTagService {
  final DatabaseService databaseService;

  QuestionTagService({required this.databaseService});

  //TODO add test
  Future addQuestionTags(List<QuestionTag> questionTags) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.questionTags, questionTags));

  //TODO add test
  Future<List<QuestionTagData>> getTermQuestionsTags(TermData termData) =>
      databaseService
          .customSelect(
              "select qt.*, (select COUNT(*) from questionsLinkedToTags where tagId=qt.id and questionId in (select id from questions where parentTermId in (select id from terms where enabled=1) and parentTermId in (select termId from termTrees where parentTermId=${termData.term.id}))) as numberOfOccurrences,(select count(*) from (select * from questionTags where parentTagId=qt.id and id in (select tagId from questionsLinkedToTags where questionId in (select id from questions where parentTermId in (select id from terms where enabled=1))) group by id)) as numberOfChildTags  from questionTags qt where qt.id in (select tagId from questionsLinkedToTags where questionId in (select id from questions where parentTermId in (select id from terms where id in(select termId from termTrees where parentTermId =${termData.term.id} and depth>0)) and parentTermId in (select id from terms where enabled=1))) and qt.parentTagId=0  group by qt.id order by numberOfOccurrences desc ")
          .watch()
          .map((rows) => rows
              .map((row) => QuestionTagData(
                  databaseService.questionTags.map(row.data),
                  numberOfChildTags:
                      NumberOfSubTerms(row.read<int?>('numberOfChildTags')),
                  numberOfOccurrences:
                      NumberOfSubTerms(row.read<int?>('numberOfOccurrences'))))
              .toList())
          .first;
}
