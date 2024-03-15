import 'package:beta/application/service/database_service.dart';
import 'package:beta/infrastructure/device_repository.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/presentation/splash/shimmering_logo.dart';
import 'package:beta/presentation/splash/splash_screen_notifier.dart';
import 'package:beta/presentation/splash/version_name.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  static const route = '/spalsh';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(splashScreenProvider.notifier);

    final package = ref.watch(packageRepositoryProvider);
    final device = ref.watch(deviceRepositoryProvider);
    DatabaseService? database;
    if (device.hasValue && package.hasValue) {
      database = ref.watch(databaseServiceProvider);
    }
    if (database != null) {
      notifier.startTimer(context);
    }
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              flex: 9,
              child: ShimmeringLogo(),
            ),
            if (package.hasValue)
              const Expanded(flex: 1, child: VersionName()),
          ],
        ),
      ),
    );
  }
}
