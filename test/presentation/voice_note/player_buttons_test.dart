import 'package:beta/main.dart';
import 'package:beta/presentation/voice_note/voice_note_screen.dart';
import 'package:beta/presentation/voice_note/voice_note_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../common/tests.dart';
import 'common.dart';

Future main() async {
  await initTests();
  await initData();
  testWidgets('renders all buttons and dropdown', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(
      defaultRoute: VoiceNoteScreen.route,
    ));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.replay_10), findsOneWidget);
    expect(find.byIcon(Icons.forward_10), findsOneWidget);
    expect(find.byType(DropdownButton<double>), findsOneWidget);
    // Should show play button initially
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    expect(find.byIcon(Icons.pause), findsNothing);
  });

  testWidgets('changes speed when dropdown is selected',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(
      defaultRoute: VoiceNoteScreen.route,
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButton<double>));
    await tester.pumpAndSettle();

    // Tap the 1.5x option
    await tester.tap(find.text('1.5x').last);
    await tester.pumpAndSettle();

    VoiceNoteScreenController controller = Get.find();

    expect(controller.playbackSpeed, 1.5);
  });
}
