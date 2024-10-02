import 'package:beta/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreenController {
  Duration duration = const Duration(seconds: 1);
  void startTimer(BuildContext context) {
    Future.delayed(duration, () {
      if (context.mounted) context.pushReplacement(HomeScreen.route);
    });
  }
}
