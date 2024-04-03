import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/dialogues/changes_applied_upon_restart_dialogue.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test text is visible and dismiss button', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
        home: Scaffold(
      body: ChangesAppliedUponRestartDialogue(),
    )));

    expect(find.text(StringConstant.changesWillBeAppliedUponRestart.tr()),
        findsOneWidget);

    await widgetTester.tap(find.text(StringConstant.ok.tr()));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.changesWillBeAppliedUponRestart.tr()),
        findsNothing);
  });
}
