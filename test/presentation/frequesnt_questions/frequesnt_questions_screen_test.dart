import 'package:beta/main.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future<void> main() async {
  await initTests();

  testWidgets('frequent questions screen is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: FrequentQuestionsScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.byType(FrequentQuestionsScreen), findsOneWidget);
    expect(find.text(FrequentQuestionsScreen.title), findsOneWidget);
    expect(find.byIcon(FrequentQuestionsScreen.icon), findsOneWidget);
  });
}
