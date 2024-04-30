import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/splash/version_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();

  testWidgets('version name is visible', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(home: VersionName()));
    PackageRepository packageRepository = Get.find();
    expect(find.text(packageRepository.getVersionName()), findsOneWidget);
  });
}
