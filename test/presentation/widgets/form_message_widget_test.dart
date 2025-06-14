import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/widgets/form_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();
  late Function onDismiss;
  const testMessage = 'Test message';

  setUp(() {
    onDismiss = () {};
  });

  testWidgets('FormMessageWidget renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MyApp(
        child: FormMessageWidget(
          message: testMessage,
          onDismiss: onDismiss,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(testMessage), findsOneWidget);
    expect(find.text(StringConstant.ok), findsOneWidget);
    expect(find.byType(OpacityAnimation), findsOneWidget);
    expect(find.byType(MaterialBanner), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
  });

  testWidgets('FormMessageWidget calls onDismiss when button is pressed',
      (WidgetTester tester) async {
    var dismissed = false;
    onDismiss() => dismissed = true;

    await tester.pumpWidget(
      MyApp(
        child: FormMessageWidget(
          message: testMessage,
          onDismiss: onDismiss,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(OutlinedButton));
    expect(dismissed, isTrue);
  });

  testWidgets('FormMessageWidget shows the correct message',
      (WidgetTester tester) async {
    const customMessage = 'Custom error message';

    await tester.pumpWidget(
      MyApp(
        child: FormMessageWidget(
          message: customMessage,
          onDismiss: onDismiss,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(customMessage), findsOneWidget);
    expect(find.text(testMessage), findsNothing);
  });

  testWidgets('FormMessageWidget contains all required components',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MyApp(
        child: FormMessageWidget(
          message: testMessage,
          onDismiss: onDismiss,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2)); // Message + button text
  });

  testWidgets('FormMessageWidget uses OpacityAnimation',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MyApp(
        child: FormMessageWidget(
          message: testMessage,
          onDismiss: onDismiss,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final opacityAnimation = tester.widget<OpacityAnimation>(
      find.byType(OpacityAnimation),
    );
    expect(opacityAnimation.child, isA<SingleChildScrollView>());
  });
}
