import 'package:beta/constants/route_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/printed_qr_scanner/coupon_gift_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  MainController.testing = true;
  testWidgets('coupon gift widget displays text', (widgetTester) async {
    const String coupon = 'MMMMMMMM-MMMM-MMMM-MMMM-MMMMMMMMMMMM';
    await widgetTester.pumpWidget(MaterialApp(
      routes: routes,
      home: const CouponGiftWidget(
        coupon: coupon,
      ),
    ));
    expect(find.text(coupon), findsOneWidget);
  });
}
