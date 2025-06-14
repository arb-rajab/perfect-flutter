import 'package:beta/main.dart';
import 'package:beta/presentation/widgets/message_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  testWidgets('message widget displays message', (widgetTester) async {
    String randomText = 'random text';
    await widgetTester.pumpWidget(MyApp(
      child: MessageWidget(randomText),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(randomText), findsOneWidget);
  });
}
