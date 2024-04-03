import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/coupon_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_property_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/application/services/theme_service.dart';
import 'package:beta/infrastructure/device_repository.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainController {
  static bool testing = false;

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

  static Future initServices() async {
    if (testing == false) WidgetsFlutterBinding.ensureInitialized();
    KeyValue keyValue = await KeyValue().initialise();
    await EasyLocalization.ensureInitialized();
    Get.put(await DeviceRepository().initialise());
    Get.put(await PackageRepository().initialise());
    Get.put(keyValue);
    DatabaseService databaseService = DatabaseService();
    Get.put(databaseService);
    Get.put(ThemeService(keyValue: keyValue));
    Get.put(QuestionPropertyService(databaseService: databaseService));
    Get.put(AnswerPropertyService(databaseService: databaseService));
    Get.put(TermLastAccessService(databaseService: databaseService));
    Get.put(CouponService(databaseService: databaseService));
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingHandler);
    // FirebaseMessaging.onMessage.listen(_firebaseMessagingHandler);
    // await DeviceInfoHelper.configure();
    // initialiseLocalNotificationsPlugin();
    // Get.put(UserController());
  }

  // static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // @pragma('vm:entry-point')
  // static Future<void> _firebaseMessagingHandler(RemoteMessage message) async {
  //   // Initialize Firebase app
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   initialiseLocalNotificationsPlugin();
  //   // Show a notification
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(Configs.appName, Configs.appName,
  //           channelDescription: '',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           icon: '@mipmap/ic_launcher'
  //           // ticker: 'ticker'
  //           );
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   if (message.data.containsKey('notification')) {
  //     var notification = jsonDecode(message.data['notification']);
  //     flutterLocalNotificationsPlugin.show(Randoms.getRandomInt(),
  //         notification['title'], notification['body'], notificationDetails,
  //         payload: '');
  //     await SharedPreferencesHelper.init();
  //     SharedPreferencesHelper.set(
  //         SharedPreferencesConstant.newNotificationsRecieved, true);
  //     if (Get.isRegistered<HomeController>()) {
  //       HomeController homeController = Get.find();
  //       homeController.showNewNotificationsBadge(true);
  //     }
  //   }
  // }

//   static void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // display a dialog with the notification details, tap ok to go to another page
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       Configs.appName, Configs.appName,
//       channelDescription: '',
//       importance: Importance.max,
//       priority: Priority.high,
//       // ticker: 'ticker'
//     );
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     // if (flutterLocalNotificationsPlugin == null) {
//     //   initialiseLocalNotificationsPlugin();
//     // }
//     await flutterLocalNotificationsPlugin.show(
//         0, title, body, notificationDetails);
//   }
}
