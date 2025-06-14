import 'package:animated_number/animated_number.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/widgets/animated_counter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

// class MockAnimatedNumber extends Mock implements AnimatedNumber {}

Future main() async {
  await initTests();
  testWidgets('renders AnimatedNumber with correct parameters', (tester) async {
    const testValue = 42;

    await tester.pumpWidget(
      const MyApp(
        child: AnimatedCounter(value: testValue),
      ),
    );
    await tester.pumpAndSettle();

    // Verify AnimatedNumber is rendered
    final animatedNumberFinder = find.byType(AnimatedNumber);
    expect(animatedNumberFinder, findsOneWidget);

    // Verify AnimatedNumber parameters
    final animatedNumber = tester.widget<AnimatedNumber>(animatedNumberFinder);
    expect(animatedNumber.startValue, 0);
    expect(animatedNumber.endValue, testValue);
    expect(animatedNumber.duration, animationDuration);
    expect(animatedNumber.isFloatingPoint, false);
  });
}
