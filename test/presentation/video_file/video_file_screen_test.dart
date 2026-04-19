import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/video_file/video_file_screen.dart';
import 'package:beta/presentation/video_file/video_file_screen_controller.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';
import 'common.dart';

Future main() async {
  await initTests();
  await initData();

  testWidgets('VideoFileScreen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(defaultRoute: VideoFileScreen.route));
    await tester.pump(const Duration(seconds: 2));

    expect(find.byType(VideoFileScreen), findsOneWidget);
    expect(find.byType(NoBackgroundLogo), findsOneWidget);
  });

  testWidgets(
      'VideoFileScreen shows position text and transport buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(defaultRoute: VideoFileScreen.route));
    await tester.pump(const Duration(seconds: 2));

    // Slider
    // expect(find.byType(Slider), findsOneWidget);

    // Position text (format: m:ss / m:ss)
    final textWidgets = tester.widgetList<Text>(find.byType(Text));
    final hasPositionText = textWidgets.any((t) =>
        t.data != null && RegExp(r'^\d+:\d{2} / \d+:\d{2}$').hasMatch(t.data!));
    expect(hasPositionText, isTrue, reason: 'Position text not found');

    // Transport buttons
    expect(find.byIcon(Icons.replay_10), findsOneWidget);
    expect(find.byIcon(Icons.forward_10), findsOneWidget);
    expect(find.byIcon(Icons.fullscreen), findsOneWidget);
  });

  testWidgets('VideoFileScreen displays the term name',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(defaultRoute: VideoFileScreen.route));
    await tester.pump(const Duration(seconds: 2));

    expect(find.widgetWithText(AppBar, 'name'), findsWidgets);
  });

  testWidgets('if there is no termlastaccess object, initial second is 0',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(defaultRoute: VideoFileScreen.route));
    await tester.pump(const Duration(seconds: 2));

    final textWidgets = tester.widgetList<Text>(find.byType(Text));
    final hasZeroPosition = textWidgets.any((t) =>
        t.data != null &&
        (t.data!.startsWith('0:00') || t.data!.contains('0:00')));
    expect(hasZeroPosition, isTrue);
  });

  testWidgets(
      'if there is a termlastaccess object, initial second is set accordingly',
      (WidgetTester tester) async {
    TermLastAccessService termLastAccessService = Get.find();
    termLastAccessService.addTermLastAccessed(const Id(1), const Id(42).value!);

    await tester.pumpWidget(const MyApp(defaultRoute: VideoFileScreen.route));
    await tester.pump(const Duration(seconds: 2));

    VideoFileScreenController controller = Get.find();
    final result = await controller.getLastSecond();
    expect(result, 42);
  });
}
