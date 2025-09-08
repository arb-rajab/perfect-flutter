import 'package:beta/application/services/database_service.dart';

class FCMTopicService {
  final DatabaseService databaseService;

  FCMTopicService({required this.databaseService});

  Future addFCMTopic(FcmTopic fcmTopic) => databaseService
      .into(databaseService.fcmTopics)
      .insertOnConflictUpdate(fcmTopic);

  Future<List<FcmTopic>> getFailedTopics() =>
      (databaseService.select(databaseService.fcmTopics)
            ..where((tbl) => tbl.subscriptionSucceed.equals(false)))
          .get();
  
}
