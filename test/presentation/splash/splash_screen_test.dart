import 'package:beta/constants/route_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/splash/splash_screen.dart';
import 'package:beta/presentation/splash/splash_screen_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

void main() async {
  MainController.testing = true;
  await MainController.initServices();

  // testWidgets('splash screen dismissed after certain period',
  //     (widgetTester) async {
  //   await widgetTester
  //       .pumpWidget(MaterialApp(routes: routes, home: const SplashScreen()));
  //   SplashScreenController screenController = Get.find();
  //   await widgetTester.pump(Duration(seconds: 3));
  //   expect(find.byType(SplashScreen), findsNothing);
  // });
}
