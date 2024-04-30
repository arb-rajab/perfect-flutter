import 'package:beta/configs/style.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/printed_qr_scanner/warning_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();

  testWidgets('warning widget displays text', (widgetTester) async {
    String randomText = 'random text';
    await widgetTester
        .pumpWidget(MaterialApp(home: WarningWidget(text: randomText)));
    await widgetTester.pump(animationDuration);
    expect(find.text(randomText), findsOneWidget);
  });
}
