import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/fcm_topic_service.dart';
import 'package:beta/infrastructure/firebase_repository.dart';
import 'package:drift/drift.dart';
import 'package:get/instance_manager.dart';

class TermService {
  final DatabaseService databaseService;
  final FirebaseRepository firebaseRepository;
  TermService(
      {required this.databaseService, required this.firebaseRepository});

  //TODO add tests
  Future addTerms(List<Term> terms) => databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(databaseService.terms, terms);
        batch.insertAllOnConflictUpdate(
            databaseService.termTrees,
            terms
                .map((e) => TermTreesCompanion(
                    termId: Value(e.id),
                    parentTermId: Value(e.id),
                    depth: const Value(0)))
                .toList());
      });

  //TODO add tests
  Future subscribeToTermUpdates(Term term) {
    String topic = "termId.${term.id}";
    FCMTopicService fcmTopicService = Get.find();
    return firebaseRepository
        .subscribeToTopic(topic)
        .then((_) => fcmTopicService
            .addFCMTopic(FcmTopic(title: topic, subscriptionSucceed: true)))
        .onError((error, stackTrace) => fcmTopicService
            .addFCMTopic(FcmTopic(title: topic, subscriptionSucceed: false)));
  }
}
