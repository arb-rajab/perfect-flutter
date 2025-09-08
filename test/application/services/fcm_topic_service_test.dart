import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/fcm_topic_service.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';

void main() {
  late FCMTopicService fcmTopicService;
  setUp(() async {
    await initTests();
    fcmTopicService = Get.find();
  });

  FcmTopic createTestFcmTopic({
    String title = 'test_topic',
    bool subscriptionSucceed = false,
  }) {
    return FcmTopic(
      title: title,
      subscriptionSucceed: subscriptionSucceed,
    );
  }

  test('addFCMTopic inserts topic with conflict resolution', () async {
    final topic =
        createTestFcmTopic(title: 'topic1', subscriptionSucceed: false);

    await fcmTopicService.addFCMTopic(topic);

    final storedTopics =
        await databaseService.select(databaseService.fcmTopics).get();
    expect(storedTopics.length, 1);
    expect(storedTopics.first.title, 'topic1');
    expect(storedTopics.first.subscriptionSucceed, false);
  });

  test('addFCMTopic updates existing topic on conflict', () async {
    final initialTopic =
        createTestFcmTopic(title: 'topic2', subscriptionSucceed: false);
    await databaseService.into(databaseService.fcmTopics).insert(initialTopic);

    final updatedTopic =
        createTestFcmTopic(title: 'topic2', subscriptionSucceed: true);
    await fcmTopicService.addFCMTopic(updatedTopic);

    final storedTopics =
        await databaseService.select(databaseService.fcmTopics).get();
    expect(storedTopics.length, 1);
    expect(storedTopics.first.title, 'topic2');
    expect(storedTopics.first.subscriptionSucceed, true);
  });

  test('getFailedTopics returns only topics with subscriptionSucceed == false',
      () async {
    await databaseService
        .into(databaseService.fcmTopics)
        .insert(createTestFcmTopic(title: 'fail1', subscriptionSucceed: false));
    await databaseService
        .into(databaseService.fcmTopics)
        .insert(createTestFcmTopic(title: 'ok1', subscriptionSucceed: true));
    await databaseService
        .into(databaseService.fcmTopics)
        .insert(createTestFcmTopic(title: 'fail2', subscriptionSucceed: false));

    final failedTopics = await fcmTopicService.getFailedTopics();
    expect(failedTopics.length, 2);
    expect(failedTopics.map((t) => t.title), containsAll(['fail1', 'fail2']));
    expect(failedTopics.every((t) => t.subscriptionSucceed == false), isTrue);
  });
}
