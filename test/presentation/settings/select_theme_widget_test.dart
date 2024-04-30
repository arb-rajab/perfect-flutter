import 'dart:math';

import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/settings/select_theme_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  testWidgets('clicking select theme invokes dialogue', (widgetTester) async {
    await widgetTester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SelectThemeWidget())));
    await widgetTester.pump(animationDuration);

    //click on the widget
    await widgetTester.tap(find.text(StringConstant.themeMode.tr()));
    await widgetTester.pump(animationDuration);
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
    await widgetTester.pump(animationDuration);

    //multi choice dialogue is dismissed and changesWillBeAppliedUponRestart dialogue is shown
    expect(find.text(StringConstant.chooseAnOption.tr()), findsNothing);
    expect(find.text(StringConstant.changesWillBeAppliedUponRestart.tr()),
        findsOneWidget);

    await widgetTester.tap(find.text(StringConstant.ok.tr()));
    await widgetTester.pump(animationDuration);

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
