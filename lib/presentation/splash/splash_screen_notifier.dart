import 'package:beta/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenController {
  void startTimer(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, HomeScreen.route);
    });
  }
}
