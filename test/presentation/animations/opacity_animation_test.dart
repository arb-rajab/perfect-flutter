import 'package:beta/configs/style.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();
  testWidgets('opacity screen shows widget', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      child: OpacityAnimation(
        child: RandomWidget(),
      ),
    ));
    await widgetTester.pump(animationDuration);
    expect(find.byType(RandomWidget), findsOneWidget);
  });
}

class RandomWidget extends StatelessWidget {
  const RandomWidget({super.key});

  @override
  Widget build(BuildContext context) => const Center();
}
