import 'package:beta/configs/style.dart';
import 'package:beta/constants/route_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/choose_term/choose_term_screen.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();

  testWidgets('scan qr fab navigates to scan qr screen', (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      routes: routes,
      home: const EnterCouponScreen(),
    ));
    await widgetTester.tap(find.text(ScanQrScreen.title));
    await widgetTester.pumpAndSettle();
    expect(find.byType(ScanQrScreen), findsOneWidget);
  });

  // testWidgets('an error is displayed when name is empty and ok is clicked',
  //     (widgetTester) async {
  //   await widgetTester.pumpWidget(MaterialApp(
  //     routes: routes,
  //     home: const EnterCouponScreen(),
  //   ));
  //   await widgetTester.pump(animationDuration);
  //   final listFinder = find.byType(Scrollable);

  //   await widgetTester.scrollUntilVisible(find.byType(EnterNameInput), 50,
  //       scrollable: listFinder);
  //   await widgetTester.enterText(find.byType(EnterNameInput), '');
  //   await widgetTester.scrollUntilVisible(find.byType(EnterCoupon), 50,
  //       scrollable: listFinder);
  //   await widgetTester.enterText(find.byType(EnterCoupon), 'aaa');
  //   await widgetTester.scrollUntilVisible(find.byType(SubmitButton), 50,
  //       scrollable: listFinder);
  //   await widgetTester.tap(find.byType(SubmitButton));
  //   expect(find.byType(ChooseTermScreen), findsNothing);
  //   expect(find.text(StringConstant.pleaseFillThisField), findsOneWidget);
  // });

  testWidgets('clicking do you need help navigates to contact us screen',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      routes: routes,
      home: const DoYouNeedHelp(),
    ));
    await widgetTester.tap(find.byType(DoYouNeedHelp));
    await widgetTester.pumpAndSettle();
    expect(find.byType(ContactUsScreen), findsOneWidget);
  });
}
