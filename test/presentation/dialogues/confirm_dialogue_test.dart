import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  testWidgets('title is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: ConfirmDialogue(onConfirm: () {}),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(StringConstant.confirmAction), findsOneWidget);
  });

  testWidgets('default content is rendered if no content is provided',
      (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: ConfirmDialogue(onConfirm: () {}),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(StringConstant.confirmActionExplanation), findsOneWidget);
  });

  testWidgets('a content is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: ConfirmDialogue(
        onConfirm: () {},
        content: const RandomWidget(),
      ),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.byType(RandomWidget), findsOneWidget);
    expect(find.text(StringConstant.confirmActionExplanation), findsNothing);
  });

  testWidgets('cancel button is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: ConfirmDialogue(onConfirm: () {}),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(StringConstant.cancel), findsOneWidget);
  });

  testWidgets('ok button is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: ConfirmDialogue(onConfirm: () {}),
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
