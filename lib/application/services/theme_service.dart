import 'package:beta/common/exceptions.dart';
import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ThemeService {
  KeyValue keyValue;
  ThemeService({required this.keyValue});

  static const String _system = 'system';
  static const String _light = 'light';
  static const String _dark = 'dark';
  final double minimumScaleFactor = 1;
  final double maximumScaleFactor = 2;

  ThemeMode getThemeMode() {
    String theme = keyValue.getString(
        KeyValueConstant.theme, KeyValueConstant.themeDefaultValue)!;
    switch (theme) {
      case _light:
        return ThemeMode.light;
      case _dark:
        return ThemeMode.dark;
      case _system:
        return ThemeMode.system;
    }
    throw UnsupportedValueException(theme);
  }

  double getScaleFactor() {
    double factor = keyValue.getDouble(KeyValueConstant.textScaleFactor,
        KeyValueConstant.textScaleFactorDefaultValue)!;
    return factor;
  }

  String getThemeString() {
    switch (getThemeMode()) {
      case ThemeMode.system:
        return StringConstant.systemDefaults.tr();
      case ThemeMode.light:
        return StringConstant.light.tr();
      case ThemeMode.dark:
        return StringConstant.night.tr();
    }
  }

  void setThemeMode(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        keyValue.setString(KeyValueConstant.theme, _system);
        return;
      case ThemeMode.light:
        keyValue.setString(KeyValueConstant.theme, _light);
        return;
      case ThemeMode.dark:
        keyValue.setString(KeyValueConstant.theme, _dark);
        return;
    }
  }

  void setScaleFactor(double value) {
    keyValue.setDouble(KeyValueConstant.textScaleFactor, value);
  }
}
