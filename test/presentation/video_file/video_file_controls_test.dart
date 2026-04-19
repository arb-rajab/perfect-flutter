import 'package:beta/main.dart';
import 'package:beta/presentation/video_file/video_file_screen.dart';
import 'package:beta/presentation/video_file/video_file_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../common/tests.dart';
import 'common.dart';

/// Pumps the widget and waits long enough for [VideoFileScreenController._init]
/// to complete and the loading state to clear.
Future<void> _pumpScreen(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp(defaultRoute: VideoFileScreen.route));
  // Allow _init() async work (file read, controller init) to complete
  await tester.pump(const Duration(seconds: 5));
  // Flush the setState(() => loading = false) rebuild
  await tester.pump();
}

Future main() async {
  await initTests();
  await initData();

  testWidgets('renders all transport buttons and speed chips',
      (WidgetTester tester) async {
    await _pumpScreen(tester);

    expect(find.byIcon(Icons.replay_10), findsOneWidget);
    expect(find.byIcon(Icons.forward_10), findsOneWidget);
    expect(find.byIcon(Icons.fullscreen), findsOneWidget);

    // Speed chips — 1.0x should be selected by default
    expect(find.byType(ChoiceChip), findsWidgets);
    final selectedChip = tester
        .widgetList<ChoiceChip>(find.byType(ChoiceChip))
        .firstWhere((c) => c.selected);
    expect((selectedChip.label as Text).data, '1.0x');

    // Should show pause button initially, no play
    expect(find.byIcon(Icons.play_circle_filled), findsNothing);
    expect(find.byIcon(Icons.pause_circle_filled), findsOneWidget);
  });

  testWidgets('changes speed when a speed chip is tapped',
      (WidgetTester tester) async {
    await _pumpScreen(tester);

    await tester.tap(find.text('1.5x'));
    await tester.pump(const Duration(milliseconds: 300));

    VideoFileScreenController controller = Get.find();
    expect(controller.playbackSpeed, 1.5);
  });

  testWidgets('play button switches to pause button after tap',
      (WidgetTester tester) async {
    await _pumpScreen(tester);

    await tester.tap(find.byIcon(Icons.pause_circle_filled));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byIcon(Icons.play_circle_filled), findsOneWidget);
    expect(find.byIcon(Icons.pause_circle_filled), findsNothing);
  });

  testWidgets(
      'pause button switches to play button after tap then change to pause when tapped',
      (WidgetTester tester) async {
    await _pumpScreen(tester);

    await tester.tap(find.byIcon(Icons.pause_circle_filled));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byIcon(Icons.play_circle_filled), findsOneWidget);
    expect(find.byIcon(Icons.pause_circle_filled), findsNothing);

    await tester.tap(find.byIcon(Icons.play_circle_filled));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byIcon(Icons.pause_circle_filled), findsOneWidget);
    expect(find.byIcon(Icons.play_circle_filled), findsNothing);
  });

  testWidgets('fullscreen button toggles isFullScreen on controller',
      (WidgetTester tester) async {
    await _pumpScreen(tester);

    VideoFileScreenController controller = Get.find();
    expect(controller.isFullScreen, isFalse);

    await tester.tap(find.byIcon(Icons.fullscreen));
    await tester.pump(const Duration(milliseconds: 300));

    expect(controller.isFullScreen, isTrue);
  });
}
