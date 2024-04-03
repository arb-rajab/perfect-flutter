import 'dart:developer';

import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test text is visible and ok button removes dialogue',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: Scaffold(
      body: ConfirmDialogue(
        onConfirm: () {
          log('success');
        },
      ),
    )));

    expect(find.text(StringConstant.confirmActionExplanation.tr()),
        findsOneWidget);

    await widgetTester.tap(find.text(StringConstant.ok.tr()));
    await widgetTester.pumpAndSettle();

    expect(
        find.text(StringConstant.confirmActionExplanation.tr()), findsNothing);
  });

  testWidgets('test text is visible and cancel button removes dialogue',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: Scaffold(
      body: ConfirmDialogue(
        onConfirm: () {
          log('success');
        },
      ),
    )));

    expect(find.text(StringConstant.confirmActionExplanation.tr()),
        findsOneWidget);

    await widgetTester.tap(find.text(StringConstant.cancel.tr()));
    await widgetTester.pumpAndSettle();

    expect(
        find.text(StringConstant.confirmActionExplanation.tr()), findsNothing);
  });
}
