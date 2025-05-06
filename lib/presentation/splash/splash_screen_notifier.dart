import 'package:beta/main_controller.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreenController {
  Duration duration = const Duration(seconds: 1);
  bool poped = false;
  void startTimer(BuildContext context) {
    Future.delayed(duration, () {
      if (MainController.testing) {
        poped = true;
      } else if (context.mounted) {
        context.pushReplacement(HomeScreen.route);
      }
    });
  }
}
