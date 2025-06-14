import 'package:beta/configs/style.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/widgets/rectangle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders correctly with default opacity', (tester) async {
    const testChild = Text('Test Child');

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RectangleWidget(child: testChild),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify the widget tree
    expect(find.byType(RectangleWidget), findsOneWidget);
    expect(find.byType(OpacityAnimation), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    expect(find.text('Test Child'), findsOneWidget);

    // Verify container properties
    final container = tester.widget<Container>(find.byType(Container));
    expect(container.padding, const EdgeInsets.all(margin));

    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.borderRadius, BorderRadius.circular(borderRadius));
  });

  testWidgets('applies custom opacity correctly', (tester) async {
    const testChild = Text('Test Child');
    const customOpacity = 150;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        home: const Scaffold(
          body: RectangleWidget(
            opacity: customOpacity,
            child: testChild,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify the opacity is applied to the background color
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color?.a, customOpacity / 255);
  });

  testWidgets('uses theme background color', (tester) async {
    const testColor = Colors.red;
    const testChild = Text('Test Child');

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: testColor,
        ),
        home: const Scaffold(
          body: RectangleWidget(child: testChild),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify the widget uses the theme's scaffold background color
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, testColor.withAlpha(255));
  });

  testWidgets('wraps child with OpacityAnimation', (tester) async {
    const testChild = Text('Test Child');

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RectangleWidget(child: testChild),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify the OpacityAnimation wraps the Container
    final opacityAnimation =
        tester.widget<OpacityAnimation>(find.byType(OpacityAnimation));
    expect(opacityAnimation.child, isA<Container>());
  });

  testWidgets('applies correct padding and borderRadius', (tester) async {
    const testChild = Text('Test Child');

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RectangleWidget(child: testChild),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify the container styling
    final container = tester.widget<Container>(find.byType(Container));
    expect(container.padding, const EdgeInsets.all(margin));

    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.borderRadius, BorderRadius.circular(borderRadius));
  });
}
