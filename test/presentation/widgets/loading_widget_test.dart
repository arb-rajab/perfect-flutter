import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Renders CircularProgressIndicator centered',
      (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoadingWidget(),
        ),
      ),
    );

    // Verify the CircularProgressIndicator exists and is centered
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Get the Center widget that should be parent of the progress indicator
    final centerFinder = find.byType(Center);
    expect(centerFinder, findsOneWidget);

    // Verify the Center contains the CircularProgressIndicator
    final centerWidget = tester.widget<Center>(centerFinder);
    expect(centerWidget.child, isA<CircularProgressIndicator>());
  });

  testWidgets('Has correct widget hierarchy', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoadingWidget(),
        ),
      ),
    );

    // Verify the exact widget hierarchy
    expect(
      find.ancestor(
        of: find.byType(CircularProgressIndicator),
        matching: find.byType(Center),
      ),
      findsOneWidget,
    );

    expect(
      find.ancestor(
        of: find.byType(Center),
        matching: find.byType(Scaffold),
      ),
      findsOneWidget,
    );
  });
}
