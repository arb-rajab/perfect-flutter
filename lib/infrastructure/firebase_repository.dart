import 'dart:convert';

import 'package:beta/application/services/database_service.dart';
import 'package:beta/firebase_options.dart';
import 'package:beta/main_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/instance_manager.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseRepository {
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

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingHandler(RemoteMessage message) async {
    // Initialize Firebase app
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // initialiseLocalNotificationsPlugin();
    // Show a notification
    // const AndroidNotificationDetails androidNotificationDetails =
    //     AndroidNotificationDetails(Configs.appName, Configs.appName,
    //         channelDescription: '',
    //         importance: Importance.max,
    //         priority: Priority.high,
    //         icon: '@mipmap/ic_launcher'
    //         // ticker: 'ticker'
    //         );
    // const NotificationDetails notificationDetails =
    //     NotificationDetails(android: androidNotificationDetails);
    if (message.data.containsKey('sql')) {
      var sqlQuery = jsonDecode(message.data['sql']);
      if (Get.isRegistered<DatabaseService>()) {
        await MainController.initServices();
      }
      DatabaseService databaseService = Get.find();
      databaseService.customWriteReturning(sqlQuery);
      // flutterLocalNotificationsPlugin.show(Randoms.getRandomInt(),
      //     notification['title'], notification['body'], notificationDetails,
      //     payload: '');
      // await SharedPreferencesHelper.init();
      // SharedPreferencesHelper.set(
      //     SharedPreferencesConstant.newNotificationsRecieved, true);
      // if (Get.isRegistered<HomeController>()) {
      //   HomeController homeController = Get.find();
      //   homeController.showNewNotificationsBadge(true);
      // }
    }
  }

  // static void initialiseLocalNotificationsPlugin() {
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()!
  //       .requestNotificationsPermission();

  //   // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   const DarwinInitializationSettings initializationSettingsDarwin =
  //       DarwinInitializationSettings(
  //           onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  //   const LinuxInitializationSettings initializationSettingsLinux =
  //       LinuxInitializationSettings(defaultActionName: 'Open notification');
  //   const InitializationSettings initializationSettings =
  //       InitializationSettings(
  //           android: initializationSettingsAndroid,
  //           iOS: initializationSettingsDarwin,
  //           linux: initializationSettingsLinux);
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse: (details) {
  //       Navigator.popUntil(Catcher.navigatorKey!.currentContext!,
  //           ModalRoute.withName(HomeScreen.route));
  //       Get.find<HomeController>().moveToNotificationsPage();
  //     },
  //   );
  // }
}
