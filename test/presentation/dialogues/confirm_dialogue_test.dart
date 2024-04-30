import 'dart:developer';

import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test text is visible and ok button removes dialogue',
      (widgetTester) async {
    int x = 0;
    await widgetTester.pumpWidget(MaterialApp(home: Scaffold(
      body: ConfirmDialogue(
        onConfirm: () {
          log('success');
          x = 1;
        },
      ),
    )));

    expect(find.byType(ConfirmDialogue), findsOneWidget);

    await widgetTester.tap(find.text(StringConstant.ok.tr()));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ConfirmDialogue), findsNothing);
    expect(x, 1);
  });

  testWidgets('test text is visible and cancel button removes dialogue',
      (widgetTester) async {
    int x = 0;
    await widgetTester.pumpWidget(MaterialApp(home: Scaffold(
      body: ConfirmDialogue(
        onConfirm: () {
          log('success');
          x = 1;
        },
      ),
    )));

    expect(find.byType(ConfirmDialogue), findsOneWidget);

    await widgetTester.tap(find.text(StringConstant.cancel.tr()));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ConfirmDialogue), findsNothing);
    expect(x, 0);
  });

  testWidgets('test custom content is visible', (widgetTester) async {
    const String text = 'custom text';
    await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: ConfirmDialogue(
        onConfirm: () {
          log('success');
        },
        content: const Text(text),
      ),
    )));
    await widgetTester.pump(animationDuration);

    expect(find.text(text), findsOneWidget);
  });
}
