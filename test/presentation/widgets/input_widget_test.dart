import 'package:beta/presentation/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TextEditingController controller;

  setUp(() {
    controller = TextEditingController();
  });

  tearDown(() {
    controller.dispose();
  });

  testWidgets('Renders basic input field with label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputWidget(
            label: 'Test Label',
            controller: controller,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Test Label'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets('Displays password toggle when obscureText is true',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputWidget(
            label: 'Password',
            obscureText: true,
            controller: controller,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Initial state - eye with outline (password hidden)
    expect(find.byIcon(Icons.remove_red_eye_outlined), findsOneWidget);

    // Tap to show password
    await tester.tap(find.byIcon(Icons.remove_red_eye_outlined));
    await tester.pump();

    // State after tap - filled eye (password visible)
    expect(find.byIcon(Icons.remove_red_eye), findsOneWidget);
  });

  testWidgets('Shows error message when provided', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputWidget(
            label: 'Test',
            controller: controller,
            error: 'Error message',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Error message'), findsOneWidget);
  });

  testWidgets('Applies correct styling', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputWidget(
            label: 'Styled Input',
            controller: controller,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify label styling
    final label = tester.widget<Text>(find.text('Styled Input'));
    expect(label.style?.fontSize, 15);
    expect(label.style?.fontWeight, FontWeight.w400);

    // Verify spacing
    final column = tester.widget<Column>(find.byType(Column));
    expect(
        column.children.length, 4); // Label, SizedBox, TextFormField, SizedBox
  });
}
