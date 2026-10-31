import 'package:beta/abstract/device_repository_base.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/infrastructure/connection_repository.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/web/web_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class QuestionTagService {
  final DatabaseService databaseService;

  QuestionTagService({required this.databaseService});

  Future addQuestionTags(List<QuestionTag> questionTags) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.questionTags, questionTags));

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

  Future<int> getNumberOfAllQuestionsQuestionTag(
          QuestionTagData questionTagData, TermData termData) async =>
      (await databaseService
              .customSelect(
                  "select count(*) as numberOfAllQuestions from questions where id in (select questionId from questionsLinkedToTags where tagId =${questionTagData.questionTag.id}) "
                  "and parentTermId in (select termId from termTrees where parentTermId = ${termData.term.id}) ")
              .watch()
              .map((rows) => rows
                  .map((row) => row.read<int>('numberOfAllQuestions'))
                  .toList())
              .first)
          .first;

  Future<List<QuestionTagData>> getAllQuestionsTagChild(
          QuestionTagData questionTagData) =>
      databaseService
          .customSelect(
              "select qt.*, (select COUNT(*) from questionsLinkedToTags where tagId =qt.id and questionId in (select id from questions where parentTermId in (select id from terms where enabled=1) and parentTermId in (select id from terms where enabled=1))) as numberOfOccurrences,(select count(*) from (select * from questionTags where parentTagId=qt.id and id in (select tagId from questionsLinkedToTags where questionId in (select id from questions where parentTermId in (select id from terms where enabled=1))) group by id)) as numberOfChildTags  from questionTags qt where qt.parentTagId=${questionTagData.questionTag.id}  group by qt.id order by numberOfOccurrences desc ")
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

  Future<int> getNumberOfOtherQuestionsQuestionTag(
          QuestionTagData questionTagData, TermData termData) async =>
      (await databaseService
              .customSelect(
                  "select count(*) as numberOfAllQuestions from questions where id in (select questionId from questionsLinkedToTags where tagId =${questionTagData.questionTag.id}) and id not in (select questionId from questionsLinkedToTags where tagId in (select id from questionTags where parentTagId=${questionTagData.questionTag.id}))and parentTermId in (select termId from termTrees where parentTermId = ${termData.term.id}) ")
              .watch()
              .map((rows) => rows
                  .map((row) => row.read<int>('numberOfAllQuestions'))
                  .toList())
              .first)
          .first;

  Future<List<QuestionTag>> getQuestionTags(Id questionId) =>
      (databaseService.select(databaseService.questionTags)
            ..where((tbl) => tbl.id.isInQuery(databaseService
                .selectOnly(databaseService.questionsLinkedToTags)
              ..addColumns([databaseService.questionsLinkedToTags.tagId])
              ..where(databaseService.questionsLinkedToTags.questionId
                  .equals(questionId.value!)))))
          .get();

  Future openQuestionTagInformation(
      {required QuestionTag questionTag, required BuildContext context}) {
    ConnectionRepository connectionRepository = Get.find();
    return connectionRepository.isConnected().then((value) {
      if (!context.mounted) return;
      Get.delete<WebScreenArgument>();
      Get.put(WebScreenArgument(
          connected: value,
          uri: Uri.parse(ApiConstant.questionTagInformation
              .replaceFirst('(QUESTION_TAG_ID)', questionTag.id.toString())
              .replaceFirst('(IME1)', Get.find<DeviceRepositoryBase>().ime1)
              .replaceFirst('(LANGUAGE)',
                  MainController.testing ? 'en' : context.locale.languageCode)),
          // The server identifies the device by this header; the id in the
          // URL is kept for older servers.
          headers: NetworkService.deviceHeaders(),
          title: t.Title(questionTag.name)));
      context.push(WebScreen.route);
    });
  }
}
