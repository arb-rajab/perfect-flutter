import 'dart:math';

import 'package:beta/application/services/theme_service.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  late ThemeService themeService;
  List themes = ThemeMode.values;
  Random random = Random();
  MainController.testing = true;
  setUp(() async {
    themeService = ThemeService(keyValue: await KeyValue().initialise());
  });

  test('setThemeMode changes theme mode', () {
    ThemeMode newTheme = themes[random.nextInt(themes.length)];
    themeService.setThemeMode(newTheme);
    expect(themeService.getThemeMode(), newTheme);
  });

  test('setScaleFactor changes scale factor', () {
    double newScaleFactor = themeService.minimumScaleFactor +
        random.nextDouble() *
            (themeService.maximumScaleFactor - themeService.minimumScaleFactor);
    themeService.setScaleFactor(newScaleFactor);
    expect(themeService.getScaleFactor(), newScaleFactor);
  });
}
