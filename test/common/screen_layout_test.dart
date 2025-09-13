import 'package:beta/common/screen_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ScreenLayout screen size tests', (WidgetTester tester) async {
    Future<void> testWidth(double width, bool extraSmall, bool small,
        bool medium, bool large) async {
      // Set test screen size
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = Size(width, 800);
      addTearDown(tester.view.resetPhysicalSize); // Reset after test

      // Pump a widget just to get BuildContext
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Builder(
          builder: (context) {
            expect(ScreenLayout.isExtraSmall(context), extraSmall);
            expect(ScreenLayout.isSmall(context), small);
            expect(ScreenLayout.isMedium(context), medium);
            expect(ScreenLayout.isLarge(context), large);
            return const SizedBox();
          },
        ),
      ));
    }

    // Check at various widths

    await testWidth(500, true, false, false, false); // Extra small (<768)
    await testWidth(800, false, true, false, false); // Small (768 - 991)
    await testWidth(1000, false, false, true, false); // Medium (992 - 1199)
    await testWidth(1300, false, false, false, true); // Large (>=1200)
  });
}
