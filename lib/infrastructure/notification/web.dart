import 'package:beta/abstract/notification_repository_base.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotifiationRepository implements NotificationRepositoryBase {
  @override
  void initialise() {}

  @override
  Future showNotification(RemoteMessage message) => Future.value();
}
