import 'package:beta/constants/string_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();

  testWidgets('DeleteTermLastAccessWidget shows warning notice',
      (widgetTester) async {
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
