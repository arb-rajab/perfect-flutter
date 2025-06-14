import 'package:beta/infrastructure/clipboard_repository.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/widgets/copy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  testWidgets('copy widget is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      child: CopyWidget(content: 'text'),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.byIcon(Icons.copy), findsOneWidget);
  });

  testWidgets('copy widget tap copies the text', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      child: CopyWidget(content: 'text'),
    ));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byIcon(Icons.copy));
    await widgetTester.pumpAndSettle();

    ClipboardRepository clipboardRepository = Get.find();
    expect(clipboardRepository.testData, 'text');
  });
}
