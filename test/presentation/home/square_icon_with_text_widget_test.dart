import 'package:beta/presentation/home/square_icon_with_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders icon and text', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SquareIconWithTextWidget(
            iconData: Icons.home,
            text: 'Home',
            onTap: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);
  });

  testWidgets('calls onTap when tapped', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SquareIconWithTextWidget(
            iconData: Icons.settings,
            text: 'Settings',
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(InkWell));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('uses theme primary color for icon', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        home: Scaffold(
          body: SquareIconWithTextWidget(
            iconData: Icons.star,
            text: 'Star',
            onTap: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final iconWidget = tester.widget<Icon>(find.byIcon(Icons.star));
    expect(iconWidget.color, Colors.red);
  });

  testWidgets('uses titleMedium text style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        home: Scaffold(
          body: SquareIconWithTextWidget(
            iconData: Icons.favorite,
            text: 'Favorite',
            onTap: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final textWidget = tester.widget<Text>(find.text('Favorite'));
    expect(textWidget.style?.fontSize, 18);
    expect(textWidget.style?.fontWeight, FontWeight.bold);
  });
}
