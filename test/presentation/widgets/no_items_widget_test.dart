import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/widgets/message_widget.dart';
import 'package:beta/presentation/widgets/no_items_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();
  testWidgets('no items widget is rendering', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(child: NoItemsWidget()));
    await widgetTester.pumpAndSettle();
    expect(find.widgetWithText(MessageWidget, StringConstant.listEmpty),
        findsOneWidget);
  });
}
