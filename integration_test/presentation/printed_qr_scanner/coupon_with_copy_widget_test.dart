import 'package:beta/configs/style.dart';
import 'package:beta/constants/route_constant.dart';
import 'package:beta/presentation/printed_qr_scanner/coupon_with_copy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  // patrolTest('copy botton copies coupon to clipboard', (widgetTester) async {
  //   const String coupon = 'MMMMMMMM-MMMM-MMMM-MMMM-MMMMMMMMMMMM';
  //   await widgetTester.pumpWidgetAndSettle(MaterialApp(
  //       routes: routes, home: const Scaffold(body: CouponWithCopy(coupon))));
  //   await widgetTester.pump(animationDuration);
  //   await Clipboard.setData(const ClipboardData(text: ''));
  //   await widgetTester.tap(find.byIcon(CouponWithCopy.copyIcon));
  //   expect(await Clipboard.getData('text/plain'), coupon);
  // });
}
