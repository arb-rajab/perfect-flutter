import 'package:beta/configs/style.dart';
import 'package:beta/constants/route_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/dialogues/yes_no_dialogue.dart';
import 'package:beta/presentation/printed_qr_scanner/coupon_with_copy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

Future<void> main() async {
  MainController.testing = true;
  // patrolTest('coupon gift widget displays prompt when back is pressed',
  //     (widgetTester) async {
  //   const String coupon = 'MMMMMMMM-MMMM-MMMM-MMMM-MMMMMMMMMMMM';
  //   await widgetTester.pumpWidget(MaterialApp(
  //       routes: routes, home: const Scaffold(body: CouponWithCopy(coupon))));
  //   await widgetTester.pump(animationDuration);
  //   await widgetTester.native.pressBack();
  //   await widgetTester.pump(animationDuration);
  //   expect(find.byType(YesNoDialogue), findsOneWidget);
  // });
}
