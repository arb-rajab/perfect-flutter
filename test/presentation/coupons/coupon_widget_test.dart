import 'dart:convert';

import 'package:beta/application/services/coupon_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/clipboard_repository.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/coupons/coupon_widget.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/widgets/copy_widget.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future<void> main() async {
  await initTests();
  DatabaseService databaseService = Get.find();
  tearDownAll(databaseService.close);
  tearDown(() async {
    await databaseService.coupons.deleteAll();
  });

  testWidgets('coupon widget is rendered', (widgetTester) async {
    CouponService couponService = Get.find();
    Coupon coupon = Coupon.fromJson(jsonDecode(r'''
{"id":10121738,"serial":"abdb8c99-73c0-5e47-6825-edfa24e871c3","ordering":1000,"type":10000033,"deviceId":10027871,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-1603:51:30","onUpdate":null}'''));
    await couponService.addCoupon(coupon);
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: CouponsScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.byType(CouponWidget), findsOneWidget);
  });

  testWidgets('coupon serial exists', (widgetTester) async {
    CouponService couponService = Get.find();
    Coupon coupon = Coupon.fromJson(jsonDecode(r'''
{"id":10121738,"serial":"abdb8c99-73c0-5e47-6825-edfa24e871c3","ordering":1000,"type":10000033,"deviceId":10027871,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-1603:51:30","onUpdate":null}'''));
    await couponService.addCoupon(coupon);
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: CouponsScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(coupon.serial), findsOneWidget);
  });

  testWidgets('copy widget exists exists', (widgetTester) async {
    CouponService couponService = Get.find();
    Coupon coupon = Coupon.fromJson(jsonDecode(r'''
{"id":10121738,"serial":"abdb8c99-73c0-5e47-6825-edfa24e871c3","ordering":1000,"type":10000033,"deviceId":10027871,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-1603:51:30","onUpdate":null}'''));
    await couponService.addCoupon(coupon);
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: CouponsScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.byType(CopyWidget), findsAny);
  });

  testWidgets('expired coupons show message', (widgetTester) async {
    CouponService couponService = Get.find();
    Coupon coupon = Coupon.fromJson(jsonDecode(r'''
{"id":10121738,"serial":"abdb8c99-73c0-5e47-6825-edfa24e871c3","ordering":1000,"type":10000033,"deviceId":10027871,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":100,"activationDate":"2024-04-16 03:51:30","termPrintId":0,"creation":"2025-04-16 03:51:30","onUpdate":null}'''));
    await couponService.addCoupon(coupon);
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: CouponsScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(StringConstant.expiresInNDays), findsNothing);
    expect(find.text(StringConstant.couponExpired), findsOneWidget);
  });

  testWidgets('unexpired coupons show expiration days', (widgetTester) async {
    CouponService couponService = Get.find();
    //activation date needs to be modified periodicaly as the coupon becoms expired with time
    Coupon coupon = Coupon.fromJson(jsonDecode(r'''
{"id":10121738,"serial":"abdb8c99-73c0-5e47-6825-edfa24e871c3","ordering":1000,"type":10000033,"deviceId":10027871,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":500,"activationDate":"2026-04-16 03:51:30","termPrintId":0,"creation":"2025-04-16 03:51:30","onUpdate":null}'''));
    await couponService.addCoupon(coupon);
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: CouponsScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(StringConstant.expiresInNDays), findsOneWidget);
    expect(find.text(StringConstant.couponExpired), findsNothing);
  });

  testWidgets('no message is shown when the coupon has no activation date',
      (widgetTester) async {
    CouponService couponService = Get.find();
    Coupon coupon = Coupon.fromJson(jsonDecode(r'''
{"id":10121738,"serial":"abdb8c99-73c0-5e47-6825-edfa24e871c3","ordering":1000,"type":10000033,"deviceId":10027871,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-16 03:51:30","onUpdate":null}'''));
    await couponService.addCoupon(coupon);
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: CouponsScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(StringConstant.expiresInNDays), findsNothing);
    expect(find.text(StringConstant.couponExpired), findsNothing);
  });

  testWidgets('coupon serial can be copied', (widgetTester) async {
    CouponService couponService = Get.find();
    Coupon coupon = Coupon.fromJson(jsonDecode(r'''
{"id":10121738,"serial":"abdb8c99-73c0-5e47-6825-edfa24e871c3","ordering":1000,"type":10000033,"deviceId":10027871,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":500,"activationDate":"2024-04-16 03:51:30","termPrintId":0,"creation":"2025-04-16 03:51:30","onUpdate":null}'''));
    await couponService.addCoupon(coupon);
    ClipboardRepository clipboardRepository = Get.find();
    await clipboardRepository.setText('');
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: CouponsScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byType(CopyWidget));
    await widgetTester.pumpAndSettle();
    expect(await clipboardRepository.getText(), coupon.serial);
  });
}
