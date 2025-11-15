import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/fcm_topic_service.dart';
import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/application/services/question_linked_to_tag_service.dart';
import 'package:beta/application/services/question_media_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/infrastructure/firebase_repository.dart';
import 'package:drift/drift.dart';
import 'package:get/instance_manager.dart';

class TermService {
  final DatabaseService databaseService;
  final FirebaseRepository firebaseRepository;

  final String _termsSelectClause =
      "select t.*,tt.id as tagId,tl.id as labelId,(SElECT COUNT(*) FROM termsParents WHERE parentTermId=t.id) as numberOfSubTerms, (SElECT COUNT(*) FROM questions WHERE parentTermId=t.id ) as numberOfQuestions ,(SElECT COUNT(*) FROM flashcards WHERE parentTermId=t.id ) as numberOfFlashcards ,(SElECT COUNT(*) FROM relatedTerms WHERE t.id in (termId,anotherTermId) ) as numberOfRelatedTerms from terms t left outer join termsTags tt on tt.id in (select tagId from termsLinkedToTags where termId=t.id) left outer join termsLabels tl on tl.id in (select labelId from termsLinkedToLabels where termId=t.id) where ";
  static const String _termsOrderClause =
      " order by tl.id desc,ordering desc,creation desc";
  TermService(
      {required this.databaseService, required this.firebaseRepository});

  Future addTerms(List<TermData> terms) => databaseService.batch((batch) {
        List<Term> updatedTerms = terms
            .where((element) => !element.isDeleted() && element.isVisible())
            .map((element) => element.term)
            .toList();
        List<Term> deletedTerms = terms
            .where((element) => element.isDeleted() || !element.isVisible())
            .map((element) => element.term)
            .toList();
        batch.insertAllOnConflictUpdate(databaseService.terms, updatedTerms);
        batch.insertAllOnConflictUpdate(
            databaseService.termTrees,
            updatedTerms
                .map((e) => TermTreesCompanion(
                    termId: Value(e.id),
                    parentTermId: Value(e.id),
                    depth: const Value(0)))
                .toList());
        for (Term deletedTerm in deletedTerms) {
          batch.delete(databaseService.terms, deletedTerm);
          batch.deleteWhere(databaseService.termTrees,
              (tbl) => tbl.termId.equals(deletedTerm.id));
          batch.deleteWhere(databaseService.termTrees,
              (tbl) => tbl.parentTermId.equals(deletedTerm.id));
        }
      });

  Future subscribeToTermsUpdates(List<TermData> terms) {
    for (TermData term in terms) {
      String topic = "termId.${term.term.id}";
      FCMTopicService fcmTopicService = Get.find();
      if (!term.isDeleted()) {
        firebaseRepository
            .subscribeToTopic(topic)
            .then((_) => fcmTopicService
                .addFCMTopic(FcmTopic(title: topic, subscriptionSucceed: true)))
            .onError((error, stackTrace) => fcmTopicService.addFCMTopic(
                FcmTopic(title: topic, subscriptionSucceed: false)));
      } else {
        firebaseRepository.unSubscribeToTopic(topic);
      }
    }
    return Future.value();
  }

  Future setTermsNeedUpdate(List<Id> termsIds) =>
      (databaseService.update(databaseService.terms)
            ..where((tbl) => tbl.id.isIn(termsIds.map((e) => e.value!))))
          .write(const TermsCompanion(needsUpdate: Value(1)));

  Future<List<TermData>> _queryTerms(String query,
          {String orderByClaus = _termsOrderClause, int? limit, int? offset}) =>
      databaseService
          .customSelect(
              "$_termsSelectClause $query $orderByClaus ${limit != null ? 'limit $limit' : ''} ${offset != null ? 'offset $offset' : ''}")
          .watch()
          .map((rows) => rows
              .map(
                (row) => TermData.fromMap(row),
              )
              .toList())
          .first;

  Future<List<TermData>> getFirstLayerTerms() => _queryTerms(
      "t.id in (select termId from termsParents where parentTermId=rootTermId) and (((numberOfQuestions>0 or numberOfSubTerms>0 or numberOfFlashcards>0)and enabled=1) or enabled=0 )");

  Future<List<TermData>> getSubTerms(int termId) => _queryTerms(
      "t.id in (select termId from termsParents where parentTermId=$termId)");

  Future setTermUpdated(TermData termData) =>
      (databaseService.update(databaseService.terms)
            ..whereSamePrimaryKey(termData.term))
          .write(const TermsCompanion(needsUpdate: Value(0)));

  Future<bool> termHasTemplate(TermData termData) async =>
      (await databaseService
              .customSelect(
                  "select count(*) as NumberOfTemplates from terms where type=3 and id in"
                  "(select termId from termTrees where parentTermId=${termData.term.id})")
              .watch()
              .map((rows) => rows
                  .map((row) => row.read<int>('NumberOfTemplates'))
                  .toList())
              .first)
          .first >
      0;

  Future<List<TermData>> getTermRelatedTerms(TermData termData) => _queryTerms(
      "t.id in (select termId from relatedTerms where anotherTermId=${termData.term.id}) or t.id in (select anotherTermId from relatedTerms where termId=${termData.term.id})");

  Future<
      List<
          TermData>> getRecentTerms({int? limit, int? offset}) => databaseService
      .customSelect(
          "select t.*,tt.id as tagId,tl.id as labelId,(SElECT COUNT(*) FROM termsParents WHERE parentTermId=t.id) as numberOfSubTerms, (SElECT COUNT(*) FROM questions WHERE parentTermId=t.id ) as numberOfQuestions ,(SElECT COUNT(*) FROM flashcards WHERE parentTermId=t.id ) as numberOfFlashcards ,(SElECT COUNT(*) FROM relatedTerms WHERE t.id in (termId,anotherTermId) ) as numberOfRelatedTerms from terms t left outer join termsTags tt on tt.id in (select tagId from termsLinkedToTags where termId=t.id) left outer join termsLabels tl on tl.id in (select labelId from termsLinkedToLabels where termId=t.id) inner join termsLastAccess on termsLastAccess.parentTermId=t.id  where t.type!=0 group by t.id order by termsLastAccess.lastAccess desc ${limit != null ? 'limit $limit' : ''} ${offset != null ? 'offset $offset' : ''}")
      .watch()
      .map((rows) => rows.map((row) => TermData.fromMap(row)).toList())
      .first;

  Future<List<TermData>> getNewTerms({int? limit, int? offset}) => _queryTerms(
      "t.id not in (select parentTermId from termsLastAccess) and t.type!=0",
      limit: limit,
      offset: offset);

  Future<
      List<
          TermData>> getUnstudiedTerms({int? limit, int? offset}) => _queryTerms(
      "t.id not in (select termId from termProperties where name='studied') and type!=0",
      limit: limit,
      offset: offset);

  Future<
      List<
          TermData>> getFavoriteTerms({int? limit, int? offset}) => _queryTerms(
      "t.id in (select termId from termProperties where name='favorite') and type!=0",
      limit: limit,
      offset: offset);

  Future<List<TermData>> getUpdateableTerms({int? limit, int? offset}) =>
      _queryTerms("t.enabled=1 and t.needsUpdate=1 and t.type!=0",
          limit: limit, offset: offset);

  Future<Term> getTermById(Id sourceId) =>
      (databaseService.select(databaseService.terms)
            ..where((tbl) => tbl.id.equals(sourceId.value!)))
          .getSingle();

  Future<Term> getTermByQuestionUuid(String uuid) =>
      (databaseService.select(databaseService.terms)
            ..where((tbl) => tbl.id.equalsExp(subqueryExpression(
                databaseService.selectOnly(databaseService.questions)
                  ..addColumns([databaseService.questions.parentTermId])
                  ..where(databaseService.questions.uuid.equals(uuid))
                  ..limit(1)))))
          .getSingle();

  Future deleteTermContent(Term term) async {
    List<int> termIds = await (databaseService.select(databaseService.termTrees)
          ..where((tbl) => tbl.parentTermId.equals(term.id)))
        .map((row) => row.termId)
        .get();
    List<int> questionIds =
        await (databaseService.select(databaseService.questions)
              ..where((question) => question.parentTermId.isIn(termIds)))
            .map((row) => row.id)
            .get();
    await (databaseService.delete(databaseService.answers)
          ..where((answer) => answer.parentQuestionId.isIn(questionIds)))
        .go();
    await (databaseService.delete(databaseService.flashcards)
          ..where((flashcard) => flashcard.parentTermId.isIn(termIds)))
        .go();
    await (databaseService.delete(databaseService.questionsLinkedToTags)
          ..where((tbl) => tbl.questionId.isIn(questionIds)))
        .go();
    await (databaseService.delete(databaseService.questionMedias)
          ..where((media) => media.parentQuestionId.isIn(questionIds)))
        .go();
    await (databaseService.delete(databaseService.questions)
          ..where((tbl) => tbl.id.isIn(questionIds)))
        .go();
  }

  Future<bool> isUnExpired(TermData termData) async {
    return (await databaseService
                .customSelect(
                    "select count(*) as c from terms where id=${termData.term.id} and (id in "
                    "(select termId from termTrees where parentTermId in (select termId from couponsLinkedToTerms where couponId in "
                    "(select id from coupons where activationDate is null or "
                    "(activationDate!='' and CURRENT_TIMESTAMP<DATETIME(activationDate,'+'||expirationDays||' days'))))) or free=1)")
                .watch()
                .map((rows) => rows.map((row) => row.read<int>('c')).toList())
                .first)
            .first >
        0;
  }

  Future<int> getTermUndownloadedTermsWithQuestionsCount(
      TermData termData) async {
    return (await databaseService
            .customSelect(
                "select count(*) as c from terms t where type in (1,3) and id in (select termId from termTrees where parentTermId=${termData.term.id}) and (needsUpdate=1 or (SElECT COUNT(*) FROM questions WHERE parentTermId=t.id)=0) and enabled=1")
            .watch()
            .map((rows) => rows.map((row) => row.read<int>('c')).toList())
            .first)
        .first;
  }

  Future storeTermContent(dynamic body) {
    return databaseService.transaction(() async {
      List<Question> questions =
          (body['questions'] as List).map((e) => Question.fromJson(e)).toList();
      List<Flashcard> flashcards = (body['flashcards'] as List)
          .map((e) => Flashcard.fromJson(e))
          .toList();
      List<Answer> answers =
          (body['answers'] as List).map((e) => Answer.fromJson(e)).toList();
      List<QuestionMedia> questionMedias = (body['media'] as List)
          .map((e) => QuestionMedia.fromJson(e))
          .toList();
      List<QuestionTag> questionTags = (body['questionTags'] as List)
          .map((e) => QuestionTag.fromJson(e))
          .toList();
      List<QuestionsLinkedToTag> questionsLinkedToTags =
          (body['questionsLinkedToTags'] as List)
              .map((e) => QuestionsLinkedToTag.fromJson(e))
              .toList();
      QuestionService questionService = Get.find();
      await questionService.addQuestions(questions);
      AnswerService answerService = Get.find();
      await answerService.addAnswers(answers);
      FlashcardService flashcardService = Get.find();
      await flashcardService.addFlashcards(flashcards);
      QuestionMediaService questionMediaService = Get.find();
      await questionMediaService.addQuestionMedias(questionMedias);
      QuestionTagService questionTagService = Get.find();
      await questionTagService.addQuestionTags(questionTags);
      QuestionLinkedToTagService questionLinkedToTagService = Get.find();
      await questionLinkedToTagService
          .addQuestionsLinkdeToTags(questionsLinkedToTags);
    });
  }
}
