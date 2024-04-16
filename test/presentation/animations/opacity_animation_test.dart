import 'package:beta/configs/style.dart';
import 'package:beta/constants/route_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('opacity screen shows widget', (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: const OpacityAnimation(
        child: Center(),
      ),
      routes: routes,
    ));
    await widgetTester.pump(animationDuration);
    expect(find.byType(Center), findsOneWidget);
  });
}
