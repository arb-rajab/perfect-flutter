import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/splash/version_name.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() async {
  await initTests();

  testWidgets('version name is visible', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(child: VersionName()));
    await widgetTester.pumpAndSettle();
    PackageRepository packageRepository = Get.find();
    expect(find.text(packageRepository.getVersionName()), findsOneWidget);
  });
}
