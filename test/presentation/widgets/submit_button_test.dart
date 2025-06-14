import 'package:beta/configs/style.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockOnSubmit mockOnSubmit;

  setUp(() {
    mockOnSubmit = MockOnSubmit();
  });

  testWidgets('renders correctly with basic properties', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SubmitButton(
            text: 'Submit',
            onSubmit: mockOnSubmit.call,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(OpacityAnimation), findsOneWidget);
    expect(find.byType(MaterialButton), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('shows loading indicator when loading is true', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SubmitButton(
            text: 'Submit',
            onSubmit: mockOnSubmit.call,
            loading: true,
          ),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SubmitButton(
            text: 'Submit',
            onSubmit: mockOnSubmit.call,
            loading: false,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  });

  testWidgets('shows icon when provided', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SubmitButton(
            text: 'Submit',
            onSubmit: mockOnSubmit.call,
            icon: Icons.send,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.send), findsOneWidget);
  });

  testWidgets('calls onSubmit when pressed and not loading', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SubmitButton(
            text: 'Submit',
            onSubmit: mockOnSubmit.call,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MaterialButton));
    verify(() => mockOnSubmit.call()).called(1);
  });

  testWidgets('does not call onSubmit when pressed and loading',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SubmitButton(
            text: 'Submit',
            onSubmit: mockOnSubmit.call,
            loading: true,
          ),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byType(MaterialButton));
    verifyNever(() => mockOnSubmit.call());

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SubmitButton(
            text: 'Submit',
            onSubmit: mockOnSubmit.call,
            loading: false,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
  });

  testWidgets('applies correct styling', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SubmitButton(
            text: 'Submit',
            onSubmit: mockOnSubmit.call,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final container = tester.widget<Container>(find.byType(Container));
    expect(container.padding,
        const EdgeInsets.only(top: halfMargin, left: halfMargin));

    final decoration = container.decoration as BoxDecoration;
    expect(decoration.borderRadius, BorderRadius.circular(50));

    final materialButton =
        tester.widget<MaterialButton>(find.byType(MaterialButton));
    expect(materialButton.minWidth, double.infinity);
    expect(materialButton.height, 60);
    expect(materialButton.shape, isA<RoundedRectangleBorder>());
  });

  testWidgets('applies progress value to CircularProgressIndicator',
      (tester) async {
    const testProgress = 0.75;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SubmitButton(
            text: 'Submit',
            onSubmit: mockOnSubmit.call,
            loading: true,
            progress: testProgress,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final progressIndicator = tester.widget<CircularProgressIndicator>(
      find.byType(CircularProgressIndicator),
    );
    expect(progressIndicator.value, testProgress);
  });

  testWidgets('has correct border styling', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue),
        home: Scaffold(
          body: SubmitButton(
            text: 'Submit',
            onSubmit: mockOnSubmit.call,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final container = tester.widget<Container>(find.byType(Container));
    final decoration = container.decoration as BoxDecoration;
    final border = decoration.border as Border;

    expect(border.top.color, Colors.blue);
    expect(border.bottom.color, Colors.blue);
    expect(border.left.color, Colors.blue);
    expect(border.right.color, Colors.blue);
  });

  testWidgets('has horizontally scrollable content', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SubmitButton(
            text: 'Very Long Button Text That Should Scroll',
            onSubmit: mockOnSubmit.call,
            icon: Icons.send,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    final scrollView = tester
        .widget<SingleChildScrollView>(find.byType(SingleChildScrollView));
    expect(scrollView.scrollDirection, Axis.horizontal);
  });
}

class MockOnSubmit extends Mock {
  void call();
}
