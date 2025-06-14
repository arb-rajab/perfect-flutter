import 'package:beta/configs/style.dart';
import 'package:beta/presentation/widgets/widget_wrapper.dart';
import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders correctly with child widget', (tester) async {
    const testWidget = Text('Test Child');

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: WidgetWrapperWithBorder(child: testWidget),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(WidgetWrapperWithBorder), findsOneWidget);
    expect(find.text('Test Child'), findsOneWidget);
  });

  testWidgets('applies correct border styling', (tester) async {
    const testColor = Colors.blue;
    const testWidget = SizedBox();

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(primaryColor: testColor),
        home: const Scaffold(
          body: WidgetWrapperWithBorder(child: testWidget),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final container = tester.widget<Container>(find.descendant(
      of: find.byType(WidgetWrapperWithBorder),
      matching: find.byType(Container),
    ));

    final decoration = container.decoration as BoxDecoration;
    final border = decoration.border as Border;

    expect(border.top.color, testColor);
    expect(border.bottom.color, testColor);
    expect(border.left.color, testColor);
    expect(border.right.color, testColor);
  });

  testWidgets('applies correct box shadow with alpha value', (tester) async {
    const testColor = Colors.red;
    const testWidget = SizedBox();

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(primaryColor: testColor),
        home: const Scaffold(
          body: WidgetWrapperWithBorder(child: testWidget),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final container = tester.widget<Container>(find.descendant(
      of: find.byType(WidgetWrapperWithBorder),
      matching: find.byType(Container),
    ));

    final decoration = container.decoration as BoxDecoration;
    final boxShadow = decoration.boxShadow!;

    expect(boxShadow.length, 1);
    expect(boxShadow[0].color, testColor.withAlpha((opacity * 255).toInt()));
    expect(boxShadow[0].spreadRadius, 5);
    expect(boxShadow[0].blurRadius, 7);
    expect(boxShadow[0].offset, const Offset(0, 2));
  });

  testWidgets('applies correct borderRadius', (tester) async {
    const testWidget = SizedBox();

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: WidgetWrapperWithBorder(child: testWidget),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final container = tester.widget<Container>(find.descendant(
      of: find.byType(WidgetWrapperWithBorder),
      matching: find.byType(Container),
    ));

    final decoration = container.decoration as BoxDecoration;
    expect(decoration.borderRadius, BorderRadius.circular(borderRadius));
  });

  testWidgets('wraps child with WidgetWrapper', (tester) async {
    const testWidget = SizedBox();

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: WidgetWrapperWithBorder(child: testWidget),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(WidgetWrapper), findsOneWidget);
  });
}
