import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/application/services/theme_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  MainController.testing = true;
  late DatabaseService databaseService;

  setUp(
    () async {
      Get.put(ThemeService(keyValue: await KeyValue().initialise()));
      databaseService = Get.put(DatabaseService());
    },
  );

  testWidgets('DeleteTermLastAccessWidget shows warning notice',
      (widgetTester) async {
    Get.put(TermLastAccessService(databaseService: databaseService));
    await widgetTester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    await widgetTester.tap(find.text(StringConstant.deleteTermLastAccess.tr()));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.confirmAction.tr()), findsOneWidget);

    // confirm dialogue
    await widgetTester.tap(find.text(StringConstant.ok.tr()));
    await widgetTester.pumpAndSettle();
    expect(find.text(StringConstant.success.tr()), findsOneWidget);
  });
}
