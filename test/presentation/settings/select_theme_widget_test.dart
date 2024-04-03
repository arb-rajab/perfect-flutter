import 'dart:math';

import 'package:beta/application/services/theme_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/settings/select_theme_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  MainController.testing = true;
  Get.put(ThemeService(keyValue: await KeyValue().initialise()));
  testWidgets('clicking select theme invokes dialogue', (widgetTester) async {
    await widgetTester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SelectThemeWidget())));

    //click on the widget
    await widgetTester.tap(find.text(StringConstant.themeMode.tr()));
    await widgetTester.pump();
    expect(find.text(StringConstant.chooseAnOption.tr()), findsOneWidget);
    expect(find.text(StringConstant.systemDefaults.tr()), findsNWidgets(2));
    expect(find.text(StringConstant.light.tr()), findsOneWidget);
    expect(find.text(StringConstant.night.tr()), findsOneWidget);

    //choose an option
    List<String> options = [
      // StringConstant.systemDefaults.tr(),
      StringConstant.light.tr(),
      StringConstant.night.tr()
    ];
    String randomOption = options[Random().nextInt(options.length)];

    await widgetTester.tap(find.text(randomOption));
    await widgetTester.pump();

    //multi choice dialogue is dismissed and changesWillBeAppliedUponRestart dialogue is shown
    expect(find.text(StringConstant.chooseAnOption.tr()), findsNothing);
    expect(find.text(StringConstant.changesWillBeAppliedUponRestart.tr()),
        findsOneWidget);

    await widgetTester.tap(find.text(StringConstant.ok.tr()));
    await widgetTester.pump();

    //changesWillBeAppliedUponRestart is dismissed
    expect(find.text(StringConstant.changesWillBeAppliedUponRestart.tr()),
        findsNothing);

    for (int c = 0; c < options.length; c++) {
      if (options[c] == randomOption) {
        expect(find.text(options[c]), findsOneWidget);
      } else {
        expect(find.text(options[c]), findsNothing);
      }
    }
  });
}
