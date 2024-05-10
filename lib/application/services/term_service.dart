import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/fcm_topic_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/infrastructure/firebase_repository.dart';
import 'package:drift/drift.dart';
import 'package:get/instance_manager.dart';

class TermService {
  final DatabaseService databaseService;
  final FirebaseRepository firebaseRepository;

  final String _termsSelectClause =
      "select t.*,tt.id as tagId,tl.id as labelId,(SElECT COUNT(*) FROM termsParents WHERE parentTermId=t.id) as numberOfSubTerms, (SElECT COUNT(*) FROM questions WHERE parentTermId=t.id ) as numberOfQuestions ,(SElECT COUNT(*) FROM flashcards WHERE parentTermId=t.id ) as numberOfFlashcards ,(SElECT COUNT(*) FROM relatedTerms WHERE t.id in (termId,anotherTermId) ) as numberOfRelatedTerms from terms t left outer join termsTags tt on tt.id in (select tagId from termsLinkedToTags where termId=t.id) left outer join termsLabels tl on tl.id in (select labelId from termsLinkedToLabels where termId=t.id) where ";
  final String _termsOrderClause =
      " order by tl.id desc,ordering desc,creation desc";
  TermService(
      {required this.databaseService, required this.firebaseRepository});

  //TODO add tests
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

  //TODO add test
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

  //TODO add test
  Future setTermsNeedUpdate(List<Id> termsIds) =>
      (databaseService.update(databaseService.terms)
            ..where((tbl) => tbl.id.isIn(termsIds.map((e) => e.value!))))
          .write(const TermsCompanion(needsUpdate: Value(1)));

  Future<List<TermData>> _queryTerms(String query) => databaseService
      .customSelect("$_termsSelectClause $query $_termsOrderClause")
      .watch()
      .map((rows) => rows
          .map(
            (row) => TermData(databaseService.terms.map(row.data),
                tagId: Id(row.read<int?>('tagId')),
                labelId: Id(row.read<int?>('labelId')),
                numberOfSubTerms:
                    NumberOfSubTerms(row.read<int>('numberOfSubTerms')),
                numberOfFlashcards:
                    NumberOfSubTerms(row.read<int>('numberOfFlashcards')),
                numberOfRelatedTerms:
                    NumberOfSubTerms(row.read<int>('numberOfRelatedTerms'))),
          )
          .toList())
      .first;

  //TODO add test
  Future<List<TermData>> getFirstLayerTerms() => _queryTerms(
      "t.id in (select termId from termsParents where parentTermId=rootTermId) and (((numberOfQuestions>0 or numberOfSubTerms>0 or numberOfFlashcards>0)and enabled=1) or enabled=0 )");

  //TODO add test
  Future<List<TermData>> getSubTerms(int termId) => _queryTerms(
      "t.id in (select termId from termsParents where parentTermId=$termId)");

  //TODO add test
  Future setTermUpdated(TermData termData) =>
      (databaseService.update(databaseService.terms)
            ..whereSamePrimaryKey(termData.term))
          .write(const TermsCompanion(needsUpdate: Value(0)));

  //TODO add test
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
}
