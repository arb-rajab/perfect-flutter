import 'package:beta/application/services/coupon_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/route_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/home/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  MainController.testing = true;
  DatabaseService databaseService = Get.put(DatabaseService());
  Get.put(CouponService(databaseService: databaseService));
  testWidgets('coupons tile navigates to coupon screen', (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      routes: routes,
      home: const DrawerWidget(),
    ));
    expect(find.byType(CouponsScreen), findsNothing);
    await widgetTester.tap(find.text(CouponsScreen.title));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CouponsScreen), findsOneWidget);
  });
}
