import 'dart:io';

import 'package:beta/constants/api_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../common/tests.dart';

// Generates the screenshots embedded in the README. They are written to
// docs/screenshots by `flutter test --update-goldens test/screenshots`;
// a plain `flutter test` compares against the committed images instead, so
// an unintended UI change shows up as a failure.
const _phone = Size(390, 844);

Future<void> _loadAppFont() async {
  final loader = FontLoader('jf_flat')
    ..addFont(
        Future.value(ByteData.sublistView(File('assets/fonts/jf_flat_regular.ttf').readAsBytesSync())));
  await loader.load();
}

void main() {
  setUpAll(_loadAppFont);

  setUp(() async {
    await initTests();
  });

  Future<void> shoot(WidgetTester tester, Widget app, String name) async {
    tester.view.physicalSize = _phone * 2;
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(RepaintBoundary(child: app));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(RepaintBoundary).first,
      matchesGoldenFile('../../docs/screenshots/$name.png'),
    );
  }

  testWidgets('home screen', (tester) async {
    dioAdapter.onGet(ApiConstant.getTermsUpdates, (server) {
      server.reply(
        200,
        r'''{"updated-terms":[],"refreshed-terms-ids":[],"related-terms":[],"terms-with-questions-levelling-enabled":[],"terms-with-homework-enabled":[],"terms-parents":[],"terms-linked-to-tags":[],"terms-tags":[],"terms-linked-to-labels":[],"terms-labels":[],"result":"success","message":""}''',
      );
    });
    await shoot(tester, const MyApp(defaultRoute: HomeScreen.route), 'home');
  });

  testWidgets('settings screen', (tester) async {
    await shoot(tester, const MyApp(child: SettingsScreen()), 'settings');
  });
}
