import 'dart:convert';
import 'dart:math';

import 'package:beta/abstract/notification_repository_base.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/configs/app.dart';
import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/home/home_screen_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/instance_manager.dart';

class NotificationRepository implements NotificationRepositoryBase {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initialise() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Request permissions (existing)
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  @override
  Future<void> showNotification(RemoteMessage message,
      {bool background = false}) async {
    await MainController.initServices();
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('name', 'name',
            channelDescription: '',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher');

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    DatabaseService databaseService = Get.find();
    if (message.data.containsKey('sql')) {
      var sqlQuery = jsonDecode(message.data['sql']);
      databaseService.customWriteReturning(sqlQuery);
    }
    if (message.notification != null) {
      RemoteNotification notification = message.notification!;

      // Pass topic info in payload for tap handling
      if (message.from == '/topics/news' && hasNews) {
        KeyValue keyValue = Get.find();
        await keyValue.setBool(KeyValueConstant.newsRecieved, true);

        if (Get.isRegistered<HomeScreenController>()) {
          Get.find<HomeScreenController>().showNewNewsBadge();
        }
      }

      if (!background) {
        flutterLocalNotificationsPlugin.show(
          Random().nextInt(1 << 16),
          notification.title, notification.body, notificationDetails,
          // payload: payload
        );
      }
    }
  }
}
