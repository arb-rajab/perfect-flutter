import 'package:beta/configs/style.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  MainController.testing = true;
  await MainController.initServices();

  testWidgets('widget wrapper with border contains child',
      (widgetTester) async {
    const String randomText = 'random text';
    await widgetTester.pumpWidget(const MaterialApp(
        home: WidgetWrapperWithBorder(child: Text(randomText))));
    await widgetTester.pump(animationDuration);
    expect(find.text(randomText), findsOneWidget);
  });
}
