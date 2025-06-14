import 'package:beta/application/services/theme_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';

import 'package:beta/presentation/settings/select_theme_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  testWidgets('header is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      child: SelectThemeWidget(),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.themeMode), findsOneWidget);
  });

  testWidgets('default systerm theme is visible if selected',
      (widgetTester) async {
    ThemeService themeService = Get.find();
    themeService.setThemeMode(ThemeMode.system);
    await widgetTester.pumpWidget(const MyApp(
      child: SelectThemeWidget(),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.systemDefaults), findsOneWidget);
  });

  testWidgets('light theme is visible if selected', (widgetTester) async {
    ThemeService themeService = Get.find();
    themeService.setThemeMode(ThemeMode.light);
    await widgetTester.pumpWidget(const MyApp(
      child: SelectThemeWidget(),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.light), findsOneWidget);
  });

  testWidgets('night theme is visible if selected', (widgetTester) async {
    ThemeService themeService = Get.find();
    themeService.setThemeMode(ThemeMode.dark);
    await widgetTester.pumpWidget(const MyApp(
      child: SelectThemeWidget(),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.night), findsOneWidget);
  });

  testWidgets('dialogue is rendered once tapped', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      child: SelectThemeWidget(),
    ));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byType(SelectThemeWidget));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(AlertDialog, StringConstant.chooseAnOption),
        findsOneWidget);
    expect(find.widgetWithText(AlertDialog, StringConstant.systemDefaults),
        findsOneWidget);
    expect(
        find.widgetWithText(AlertDialog, StringConstant.light), findsOneWidget);
    expect(
        find.widgetWithText(AlertDialog, StringConstant.night), findsOneWidget);
  });

  testWidgets('system default option is applied once selected',
      (widgetTester) async {
    ThemeService themeService = Get.find();
    await widgetTester.pumpWidget(const MyApp(
      child: SelectThemeWidget(),
    ));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byType(SelectThemeWidget));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(StringConstant.systemDefaults));
    await widgetTester.pumpAndSettle();

    expect(themeService.getThemeMode(), ThemeMode.system);
  });

  testWidgets('light mode option is applied once selected',
      (widgetTester) async {
    ThemeService themeService = Get.find();
    await widgetTester.pumpWidget(const MyApp(
      child: SelectThemeWidget(),
    ));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byType(SelectThemeWidget));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(StringConstant.light));
    await widgetTester.pumpAndSettle();

    expect(themeService.getThemeMode(), ThemeMode.light);
  });

  testWidgets('night mode option is applied once selected',
      (widgetTester) async {
    ThemeService themeService = Get.find();
    await widgetTester.pumpWidget(const MyApp(
      child: SelectThemeWidget(),
    ));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byType(SelectThemeWidget));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(StringConstant.night));
    await widgetTester.pumpAndSettle();

    expect(themeService.getThemeMode(), ThemeMode.dark);
  });
}
