import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/success_dialogue.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();
  testWidgets('test text is visible', (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: MyApp(
      child: Builder(builder: (context) {
        return TextButton(
          onPressed: () => showSuccessDialogue(context),
          child: const Text('random text'),
        );
      }),
    )));

    await widgetTester.tap(find.text('random text'));
    await widgetTester.pump();

    expect(find.text(StringConstant.success.tr()), findsOneWidget);

    await widgetTester.pumpAndSettle();
  });
}
