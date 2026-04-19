import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/voice_note/player_buttons.dart';
import 'package:beta/presentation/voice_note/voice_note_screen.dart';
import 'package:beta/presentation/voice_note/voice_note_screen_controller.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/tests.dart';
import 'common.dart';
import 'package:get/instance_manager.dart';

class MockTermLastAccessService extends Mock {
  Future<dynamic> getTermLastAccess(String id) async => null;
  Future<void> addTermLastAccessed(dynamic id, dynamic childId) async {}
}

class MockTermsLastAccess extends Mock {
  int get childId => 0;
}

class MockVoiceNoteScreenController extends Mock
    implements VoiceNoteScreenController {}

class MockAudioPlayer extends Mock {}

class MockAudioHandler extends Mock {}

class MockArgument extends Mock {}

Future main() async {
  await initTests();
  await initData();

  testWidgets('VoiceNoteScreen renders ', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(defaultRoute: VoiceNoteScreen.route));
    await tester.pumpAndSettle();

    expect(find.byType(VoiceNoteScreen), findsOneWidget);
    expect(find.byType(NoBackgroundLogo), findsOneWidget);
  });

  testWidgets('VoiceNoteScreen shows slider, position text and PlayerButtons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(defaultRoute: VoiceNoteScreen.route));
    await tester.pumpAndSettle();

    // Slider
    expect(find.byType(Slider), findsOneWidget);

    // Position text (format: m:ss / m:ss)
    final textWidgets = tester.widgetList<Text>(find.byType(Text));
    final hasPositionText = textWidgets.any((textWidget) =>
        textWidget.data != null &&
        RegExp(r'^\d+:\d{2} / \d+:\d{2}$').hasMatch(textWidget.data!));
    expect(hasPositionText, isTrue, reason: 'Position text not found');

    // PlayerButtons (workaround: match by widget type name)
    expect(
      find.byType(PlayerButtons),
      findsOneWidget,
    );
  });

  testWidgets('VoiceNoteScreen displays the term name',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(defaultRoute: VoiceNoteScreen.route));
    await tester.pumpAndSettle();

    // The term name should be displayed somewhere in the widget tree
    expect(find.widgetWithText(AppBar, 'name'), findsWidgets);
  });

  testWidgets('if there is no termlastaccess object, initial second is 0',
      (WidgetTester tester) async {
    // Pump the widget
    await tester.pumpWidget(const MyApp(defaultRoute: VoiceNoteScreen.route));
    await tester.pumpAndSettle();

    // Assert: The slider or position text should show 0 as the initial second
    final textWidgets = tester.widgetList<Text>(find.byType(Text));
    final hasZeroPosition = textWidgets.any((textWidget) =>
        textWidget.data != null &&
        (textWidget.data!.startsWith('0:00') ||
            textWidget.data!.contains('0:00')));
    expect(hasZeroPosition, isTrue);
  });

  testWidgets(
      'if there is a termlastaccess object, initial second is set accordingly',
      (WidgetTester tester) async {
    TermLastAccessService termLastAccessService = Get.find();
    termLastAccessService.addTermLastAccessed(const Id(1), const Id(42).value!);
    // Pump the widget
    await tester.pumpWidget(const MyApp(defaultRoute: VoiceNoteScreen.route));
    await tester.pumpAndSettle();

    VoiceNoteScreenController controller = Get.find();
    final result = await controller.getLastSecond();
    expect(result, 42);
  });
}
