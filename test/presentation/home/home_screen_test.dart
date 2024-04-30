import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/route_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  final DioAdapter dioAdapter = DioAdapter(dio: NetworkService.dio);

  dioAdapter.onGet(ApiConstant.notifications, (server) {
    server.reply(200,
        "{\"notifications\":[{\"id\":777,\"title\":\"\\u0625\\u0634\\u0639\\u0627\\u0631\",\"text\":\"\\u0625\\u0634\\u0639\\u0627\\u0631\",\"data\":\"\",\"topic\":\"\",\"userToken\":\"\",\"deviceId\":0,\"senderId\":null,\"appId\":1,\"creation\":\"2023-06-01T20:17:02.000000Z\",\"onUpdate\":\"2024-03-22T19:23:25.000000Z\",\"seen\":0},{\"id\":8,\"title\":\"\\u0639\\u0646\\u0648\\u0627\\u0646\",\"text\":\"\\u0645\\u062c\\u062a\\u0648\\u0649\",\"data\":\"\",\"topic\":\"\",\"userToken\":\"\",\"deviceId\":0,\"senderId\":null,\"appId\":1,\"creation\":\"2023-06-01T20:17:02.000000Z\",\"onUpdate\":\"2024-03-22T19:23:25.000000Z\",\"seen\":0},{\"id\":9,\"title\":\"\\u0639\\u0646\\u0648\\u0627\\u0646 \",\"text\":\"\\u0645\\u062d\\u062a\\u0648\\u0649\",\"data\":\"\",\"topic\":\"\",\"userToken\":\"\",\"deviceId\":0,\"senderId\":null,\"appId\":1,\"creation\":\"2023-06-01T20:17:02.000000Z\",\"onUpdate\":\"2024-03-22T19:23:25.000000Z\",\"seen\":0},{\"id\":10,\"title\":\"\\u0625\\u0634\\u0639\\u0627\\u0631\",\"text\":\"\\u0625\\u0634\\u0639\\u0627\\u0631\",\"data\":\"\",\"topic\":\"\",\"userToken\":\"\",\"deviceId\":0,\"senderId\":null,\"appId\":1,\"creation\":\"2023-06-01T20:17:02.000000Z\",\"onUpdate\":\"2024-03-22T19:23:25.000000Z\",\"seen\":0},{\"id\":11,\"title\":\"\\u0639\\u0646\\u0648\\u0627\\u0646\",\"text\":\"\\u0645\\u062c\\u062a\\u0648\\u0649\",\"data\":\"\",\"topic\":\"\",\"userToken\":\"\",\"deviceId\":0,\"senderId\":null,\"appId\":1,\"creation\":\"2023-06-01T20:17:02.000000Z\",\"onUpdate\":\"2024-03-22T19:23:25.000000Z\",\"seen\":0},{\"id\":12,\"title\":\"\\u0639\\u0646\\u0648\\u0627\\u0646 \",\"text\":\"\\u0645\\u062d\\u062a\\u0648\\u0649\",\"data\":\"\",\"topic\":\"\",\"userToken\":\"\",\"deviceId\":0,\"senderId\":null,\"appId\":1,\"creation\":\"2023-06-01T20:17:02.000000Z\",\"onUpdate\":\"2024-03-22T19:23:25.000000Z\",\"seen\":0},{\"id\":4,\"title\":\"\\u0625\\u0634\\u0639\\u0627\\u0631\",\"text\":\"\\u0625\\u0634\\u0639\\u0627\\u0631\",\"data\":\"\",\"topic\":\"\",\"userToken\":\"\",\"deviceId\":0,\"senderId\":null,\"appId\":1,\"creation\":\"2023-06-01T20:16:57.000000Z\",\"onUpdate\":\"2024-03-22T19:23:25.000000Z\",\"seen\":0},{\"id\":5,\"title\":\"\\u0639\\u0646\\u0648\\u0627\\u0646\",\"text\":\"\\u0645\\u062c\\u062a\\u0648\\u0649\",\"data\":\"\",\"topic\":\"\",\"userToken\":\"\",\"deviceId\":0,\"senderId\":null,\"appId\":1,\"creation\":\"2023-06-01T20:16:57.000000Z\",\"onUpdate\":\"2024-03-22T19:23:25.000000Z\",\"seen\":0},{\"id\":6,\"title\":\"\\u0639\\u0646\\u0648\\u0627\\u0646 \",\"text\":\"\\u0645\\u062d\\u062a\\u0648\\u0649\",\"data\":\"\",\"topic\":\"\",\"userToken\":\"\",\"deviceId\":0,\"senderId\":null,\"appId\":1,\"creation\":\"2023-06-01T20:16:57.000000Z\",\"onUpdate\":\"2024-03-22T19:23:25.000000Z\",\"seen\":0},{\"id\":3,\"title\":\"\\u0639\\u0646\\u0648\\u0627\\u0646 \",\"text\":\"\\u0645\\u062d\\u062a\\u0648\\u0649\",\"data\":\"\",\"topic\":\"\",\"userToken\":\"\",\"deviceId\":0,\"senderId\":null,\"appId\":1,\"creation\":\"2023-04-25T18:59:29.000000Z\",\"onUpdate\":\"2024-03-22T19:23:25.000000Z\",\"seen\":0}],\"result\":\"success\",\"message\":\"\"}");
  });
  group('test app bar icons', () {
    testWidgets('notifications icon navigates to notifications screen',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: HomeScreen(),
        routes: routes,
      ));
      await widgetTester.tap(find.byIcon(NotificationsScreen.icon));
      await widgetTester.pumpAndSettle();

      expect(find.byType(NotificationsScreen), findsOneWidget);
    });

    testWidgets('settings icon navigates to settings screen',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: HomeScreen(),
        routes: routes,
      ));
      await widgetTester.tap(find.byIcon(SettingsScreen.icon));
      await widgetTester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);
    });
  });

  testWidgets('add coupon icon navigates to add coupon screen',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: HomeScreen(),
      routes: routes,
    ));
    await widgetTester.tap(find.byIcon(EnterCouponScreen.icon));
    await widgetTester.pumpAndSettle();

    expect(find.byType(EnterCouponScreen), findsOneWidget);
  });
}
