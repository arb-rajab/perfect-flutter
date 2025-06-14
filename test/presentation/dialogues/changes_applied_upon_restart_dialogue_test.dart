import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/changes_applied_upon_restart_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  testWidgets('test text is visible', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      child: ChangesAppliedUponRestartDialogue(),
    ));
    await widgetTester.pumpAndSettle();

    expect(
        find.widgetWithText(
            AlertDialog, StringConstant.changesWillBeAppliedUponRestart),
        findsOneWidget);
  });

  testWidgets('test ok button is visible', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      child: ChangesAppliedUponRestartDialogue(),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.ok), findsOneWidget);
  });
}
