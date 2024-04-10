import 'package:beta/presentation/splash/shimmering_logo.dart';
import 'package:beta/presentation/splash/splash_screen_notifier.dart';
import 'package:beta/presentation/splash/version_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO apply test that splash screen is changed after amount of time
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const route = '/spalsh';

  @override
  Widget build(BuildContext context) {
    SplashScreenController notifier = Get.put(SplashScreenController());
    notifier.startTimer(context);
    return const SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 9,
              child: ShimmeringLogo(),
            ),
            Expanded(flex: 1, child: VersionName()),
          ],
        ),
      ),
    );
  }
}
