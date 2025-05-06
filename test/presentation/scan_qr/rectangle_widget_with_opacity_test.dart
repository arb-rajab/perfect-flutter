import 'package:beta/main_controller.dart';
import 'package:beta/presentation/scan_qr/rectangle_widget_with_opacity.dart';
import 'package:beta/presentation/widgets/rectangle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  MainController.testing = true;
  MainController.initServices();

  testWidgets('rectangle widget with opacity displays widget',
      (widgetTester) async {
    String randomText = 'random text';
    await widgetTester.pumpWidget(
        MaterialApp(home: RectangleWidgetWithOpacity(child: Text(randomText))));
    expect(find.text(randomText), findsOneWidget);
  });

  testWidgets('rectangle widget with opacity contains a rectangle',
      (widgetTester) async {
    String randomText = 'random text';
    await widgetTester.pumpWidget(
        MaterialApp(home: RectangleWidgetWithOpacity(child: Text(randomText))));
    expect(find.byType(RectangleWidget), findsOneWidget);
  });
}
