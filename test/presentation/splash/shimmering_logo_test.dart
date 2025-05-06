import 'package:beta/main.dart';
import 'package:beta/presentation/splash/shimmering_logo.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  testWidgets('shimmer effect is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(child: ShimmeringLogo()));
    await widgetTester.pumpAndSettle();
    expect(find.byType(Shimmer), findsOneWidget);
  });

  testWidgets('logo widget is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(child: ShimmeringLogo()));
    await widgetTester.pumpAndSettle();
    expect(find.byType(NoBackgroundLogo), findsOneWidget);
  });
}
