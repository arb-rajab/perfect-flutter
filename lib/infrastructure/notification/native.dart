import 'dart:convert';
import 'dart:math';

import 'package:beta/abstract/notification_repository_base.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/configs/app.dart';
import 'package:beta/main_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/instance_manager.dart';

class NotificationRepository implements NotificationRepositoryBase {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initialise() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
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
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  @override
  Future showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(name, name,
            channelDescription: '',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher'
            // ticker: 'ticker'
            );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    if (message.data.containsKey('sql')) {
      var sqlQuery = jsonDecode(message.data['sql']);
      if (Get.isRegistered<DatabaseService>()) {
        await MainController.initServices();
      }
      DatabaseService databaseService = Get.find();
      databaseService.customWriteReturning(sqlQuery);
    }
    if (message.notification != null) {
      RemoteNotification notification = message.notification!;
      flutterLocalNotificationsPlugin.show(Random().nextInt(1 << 32),
          notification.title, notification.body, notificationDetails,
          payload: '');
    }
  }
}
