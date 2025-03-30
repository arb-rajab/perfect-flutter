import 'package:beta/abstract/notification_repository_base.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRepository implements NotificationRepositoryBase {
  @override
  void initialise() => throw UnimplementedError();

  @override
  Future showNotification(RemoteMessage message) => throw UnimplementedError();
}
