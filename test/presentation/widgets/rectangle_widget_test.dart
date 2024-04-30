import 'package:beta/configs/style.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/widgets/rectangle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();

  testWidgets('rectangle widget displays child', (widgetTester) async {
    const String text = 'random text';
    await widgetTester.pumpWidget(
        const MaterialApp(home: RectangleWidget(child: Text(text))));
    await widgetTester.pump(animationDuration);
    expect(find.text(text), findsOneWidget);
  });
}
