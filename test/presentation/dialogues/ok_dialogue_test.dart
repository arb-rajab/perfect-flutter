import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  testWidgets('title is rendered if provided', (widgetTester) async {
    const String randomTitle = 'random title';
    await widgetTester.pumpWidget(const MyApp(
      child: OKDialogue(
        title: randomTitle,
        content: 'random content',
      ),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(randomTitle), findsOneWidget);
  });

  testWidgets('title string is rendered if provided', (widgetTester) async {
    const String randomContent = 'random content';
    await widgetTester.pumpWidget(const MyApp(
      child: OKDialogue(
        content: randomContent,
      ),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(randomContent), findsOneWidget);
  });

  testWidgets('title widget is rendered if provided', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      child: OKDialogue(
        contentWidget: RandomWidget(),
      ),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.byType(RandomWidget), findsOneWidget);
  });

  testWidgets('ok button rendered', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      child: OKDialogue(
        content: 'content',
      ),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(StringConstant.ok), findsOneWidget);
  });
}

class RandomWidget extends StatelessWidget {
  const RandomWidget({super.key});

  @override
  Widget build(BuildContext context) => const Center();
}
