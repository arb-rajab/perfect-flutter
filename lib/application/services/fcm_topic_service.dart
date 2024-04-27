import 'package:beta/application/services/database_service.dart';

class FCMTopicService {
  final DatabaseService databaseService;

  FCMTopicService({required this.databaseService});

  Future addFCMTopic(FcmTopic fcmTopic) => databaseService
      .into(databaseService.fcmTopics)
      .insertOnConflictUpdate(fcmTopic);
}
