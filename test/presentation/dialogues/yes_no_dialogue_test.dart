import 'dart:developer';

import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/dialogues/yes_no_dialogue.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'test title and description are visible and yes clicking dismisses dialogue',
      (widgetTester) async {
    String title = 'random title';
    String description = 'random desciption';
    int x = 1;
    await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: YesNoDialogue(
        onYesClicked: () {
          log('yes clicked');
          x = 2;
        },
        onNoClicked: () {
          log('no clicked');
          x = 3;
        },
        title: title,
        description: description,
      ),
    )));

    expect(find.text(title), findsOneWidget);
    expect(find.text(description), findsOneWidget);

    await widgetTester.tap(find.text(StringConstant.yes.tr()));
    await widgetTester.pumpAndSettle();

    expect(find.byType(YesNoDialogue), findsNothing);
    expect(x, 2);
  });

  testWidgets('test no clicking dismisses dialogue', (widgetTester) async {
    String title = 'random title';
    String description = 'random desciption';
    int x = 1;
    await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: YesNoDialogue(
        onYesClicked: () {
          log('yes clicked');
          x = 2;
        },
        onNoClicked: () {
          log('no clicked');
          x = 3;
        },
        title: title,
        description: description,
      ),
    )));

    await widgetTester.tap(find.text(StringConstant.no.tr()));
    await widgetTester.pumpAndSettle();

    expect(find.byType(YesNoDialogue), findsNothing);
    expect(x, 3);
  });
}
