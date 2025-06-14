import 'package:beta/application/services/theme_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/changes_applied_upon_restart_dialogue.dart';

import 'package:beta/presentation/settings/text_scale_factor_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  testWidgets('header is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      child: TextScaleFactorWidget(),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.textScaleFactor), findsOneWidget);
  });

  testWidgets('slider is rendered', (widgetTester) async {
    ThemeService themeService = Get.find();
    await widgetTester.pumpWidget(const MyApp(
      child: TextScaleFactorWidget(),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.byType(Slider), findsOneWidget);
    final slider = widgetTester.widget<Slider>(find.byType(Slider));
    expect(slider.min, themeService.minimumScaleFactor);
    expect(slider.max, themeService.maximumScaleFactor);
  });

  testWidgets('slider value is scale factor', (widgetTester) async {
    ThemeService themeService = Get.find();
    await widgetTester.pumpWidget(const MyApp(
      child: TextScaleFactorWidget(),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.byType(Slider), findsOneWidget);
    final slider = widgetTester.widget<Slider>(find.byType(Slider));
    expect(slider.value, themeService.getScaleFactor());
  });

  testWidgets('slider value change changes scale factor', (widgetTester) async {
    ThemeService themeService = Get.find();
    double initialScaleFactor = themeService.getScaleFactor();
    await widgetTester.pumpWidget(const MyApp(
      child: TextScaleFactorWidget(),
    ));
    await widgetTester.pumpAndSettle();

    await widgetTester.drag(find.byType(Slider), const Offset(50, 0));
    await widgetTester.pump();

    expect(initialScaleFactor != themeService.getScaleFactor(), true);

    await widgetTester.pumpAndSettle();
    expect(find.byType(ChangesAppliedUponRestartDialogue), findsOneWidget);
  });
}
