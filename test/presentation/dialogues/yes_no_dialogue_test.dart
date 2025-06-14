import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/yes_no_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();
  testWidgets('test title is rendered', (widgetTester) async {
    String title = 'random title';
    String description = 'random desciption';
    await widgetTester.pumpWidget(MyApp(
      child: YesNoDialogue(
        onYesClicked: () {},
        onNoClicked: () {},
        title: title,
        description: description,
      ),
    ));

    await widgetTester.pumpAndSettle();

    expect(find.text(title), findsOneWidget);
  });

  testWidgets('test description is rendered', (widgetTester) async {
    String title = 'random title';
    String description = 'random desciption';
    await widgetTester.pumpWidget(MyApp(
      child: YesNoDialogue(
        onYesClicked: () {},
        onNoClicked: () {},
        title: title,
        description: description,
      ),
    ));

    await widgetTester.pumpAndSettle();

    expect(find.text(description), findsOneWidget);
  });

  testWidgets('yes button is rendered', (widgetTester) async {
    String title = 'random title';
    String description = 'random desciption';
    await widgetTester.pumpWidget(MyApp(
      child: YesNoDialogue(
        onYesClicked: () {},
        onNoClicked: () {},
        title: title,
        description: description,
      ),
    ));

    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(TextButton, StringConstant.yes), findsOneWidget);
  });

  testWidgets('no button is rendered', (widgetTester) async {
    String title = 'random title';
    String description = 'random desciption';
    await widgetTester.pumpWidget(MyApp(
      child: YesNoDialogue(
        onYesClicked: () {},
        onNoClicked: () {},
        title: title,
        description: description,
      ),
    ));

    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(TextButton, StringConstant.no), findsOneWidget);
  });
}
