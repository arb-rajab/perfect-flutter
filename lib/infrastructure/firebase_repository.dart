import 'package:beta/configs/app.dart';
import 'package:beta/firebase_options.dart';
import 'package:beta/main_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/instance_manager.dart';

import 'notification/shared.dart';

class FirebaseRepository {
  Future<String?> getToken() =>
      FirebaseMessaging.instance.getToken(vapidKey: vapidKey);

  Future initialise() async {
    if (!MainController.testing) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingHandler);
      FirebaseMessaging.onMessage.listen(_firebaseMessagingHandler);
      // initialiseLocalNotificationsPlugin();
    }
    return Future.value(this);
  }

  Stream<String> onTokenRefresh() {
    if (!MainController.testing) {
      return FirebaseMessaging.instance.onTokenRefresh;
    }
    return const Stream.empty();
  }

  Future subscribeToTopic(String topic) {
    if (MainController.testing) return Future.value();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    return firebaseMessaging.subscribeToTopic(topic);
  }

  Future unSubscribeToTopic(String topic) {
    if (MainController.testing) return Future.value();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    return firebaseMessaging.unsubscribeFromTopic(topic);
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingHandler(RemoteMessage message) async {
    // Initialize Firebase app
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    NotificationRepository notificationRepository = Get.find();
    notificationRepository.initialise();
    notificationRepository.showNotification(message);
  }
}
