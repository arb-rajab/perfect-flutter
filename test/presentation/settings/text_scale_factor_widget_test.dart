import 'package:beta/constants/string_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/settings/text_scale_factor_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  testWidgets('clicking text scale factor invokes dialogue',
      (widgetTester) async {
    await widgetTester.pumpWidget(
        const MaterialApp(home: Scaffold(body: TextScaleFactorWidget())));

    await widgetTester.drag(find.byType(Slider), const Offset(10, 0));
    await widgetTester.pumpAndSettle();

    //changesWillBeAppliedUponRestart dialogue is shown
    expect(find.text(StringConstant.changesWillBeAppliedUponRestart.tr()),
        findsOneWidget);

    await widgetTester.tap(find.text(StringConstant.ok.tr()));
    await widgetTester.pumpAndSettle();

    //changesWillBeAppliedUponRestart is dismissed
    expect(find.text(StringConstant.changesWillBeAppliedUponRestart.tr()),
        findsNothing);
  });
}
