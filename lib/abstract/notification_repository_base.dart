import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationRepositoryBase {
  void initialise();
  Future showNotification(RemoteMessage message, {bool background = false});
}
