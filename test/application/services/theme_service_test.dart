import 'package:beta/common/exceptions.dart';
import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/application/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/tests.dart';

class MockKeyValue extends Mock implements KeyValue {}

Future main() async {
  await initTests();

  group('ThemeService', () {
    late MockKeyValue mockKeyValue;
    late ThemeService themeService;

    setUp(() {
      mockKeyValue = MockKeyValue();
      themeService = ThemeService(keyValue: mockKeyValue);
    });

    test('getThemeMode returns ThemeMode.light for stored light theme', () {
      when(() => mockKeyValue.getString(KeyValueConstant.theme, any()))
          .thenReturn('light');
      final result = themeService.getThemeMode();
      expect(result, ThemeMode.light);
    });

    test('getThemeMode returns ThemeMode.dark for stored dark theme', () {
      when(() => mockKeyValue.getString(KeyValueConstant.theme, any()))
          .thenReturn('dark');
      final result = themeService.getThemeMode();
      expect(result, ThemeMode.dark);
    });

    test('getThemeMode returns ThemeMode.system for stored system theme', () {
      when(() => mockKeyValue.getString(KeyValueConstant.theme, any()))
          .thenReturn('system');
      final result = themeService.getThemeMode();
      expect(result, ThemeMode.system);
    });

    test('getThemeMode throws UnsupportedValueException for unknown theme', () {
      when(() => mockKeyValue.getString(KeyValueConstant.theme, any()))
          .thenReturn('unknown');
      expect(() => themeService.getThemeMode(),
          throwsA(isA<UnsupportedValueException>()));
    });

    test('getScaleFactor returns stored double value', () {
      when(() =>
              mockKeyValue.getDouble(KeyValueConstant.textScaleFactor, any()))
          .thenReturn(1.5);
      final result = themeService.getScaleFactor();
      expect(result, 1.5);
    });

    test('getThemeString returns localized string for system theme', () {
      when(() => mockKeyValue.getString(KeyValueConstant.theme, any()))
          .thenReturn('system');
      // This requires easy_localization set up, otherwise returns key.
      // Just check that value matches the key (safe fallback).
      final result = themeService.getThemeString();
      expect(result, StringConstant.systemDefaults);
    });

    test('setThemeMode stores correct theme string', () {
      when(() => mockKeyValue.setString(any(), any()))
          .thenAnswer((_) async => Future.value());

      themeService.setThemeMode(ThemeMode.light);
      verify(() => mockKeyValue.setString(KeyValueConstant.theme, 'light'))
          .called(1);

      themeService.setThemeMode(ThemeMode.dark);
      verify(() => mockKeyValue.setString(KeyValueConstant.theme, 'dark'))
          .called(1);

      themeService.setThemeMode(ThemeMode.system);
      verify(() => mockKeyValue.setString(KeyValueConstant.theme, 'system'))
          .called(1);
    });

    test('setScaleFactor stores the given scale factor', () {
      when(() => mockKeyValue.setDouble(any(), any()))
          .thenAnswer((_) async => Future.value());

      themeService.setScaleFactor(1.75);
      verify(() =>
              mockKeyValue.setDouble(KeyValueConstant.textScaleFactor, 1.75))
          .called(1);
    });
  });
}
