import 'package:beta/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenController {
  Duration duration = const Duration(seconds: 1);
  void startTimer(BuildContext context) {
    Future.delayed(duration, () {
      Navigator.pushReplacementNamed(context, HomeScreen.route);
    });
  }
}
