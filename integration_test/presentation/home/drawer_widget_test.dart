import 'package:beta/constants/route_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/home/drawer_widget.dart';
import 'package:beta/presentation/printed_qr_scanner/control_buttons_widget.dart';
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest(
      'scan printed qr shows app settings dialogue when permission denied',
      (widgetTester) async {
    await widgetTester.pumpWidgetAndSettle(MaterialApp(
      routes: routes,
      home: const DrawerWidget(),
    ));

    await widgetTester.scrollUntilVisible(
        finder: find.text(PrintedQrScannerScreen.title));
    expect(find.text(StringConstant.placeQrInRectangle.tr()), findsNothing);
    await widgetTester.tester.tap(find.text(PrintedQrScannerScreen.title));
    await widgetTester.pumpAndSettle();

    await widgetTester.native.denyPermission();

    expect(find.text(StringConstant.placeQrInRectangle.tr()), findsNothing);
    expect(find.byType(ControlButtons), findsNothing);
    expect(find.byType(AllowCameraPermissionInAppSettings), findsOneWidget);
  });

  patrolTest(
      'scan printed qr shows text and control buttons when permission allowed',
      (widgetTester) async {
    await widgetTester.pumpWidgetAndSettle(MaterialApp(
      routes: routes,
      home: const DrawerWidget(),
    ));

    await widgetTester.scrollUntilVisible(
        finder: find.text(PrintedQrScannerScreen.title));
    expect(find.text(StringConstant.placeQrInRectangle.tr()), findsNothing);
    await widgetTester.tester.tap(find.text(PrintedQrScannerScreen.title));
    await widgetTester.pumpAndSettle();

    await widgetTester.native.grantPermissionOnlyThisTime();
    await widgetTester.pumpAndSettle(duration: Durations.extralong4);

    expect(find.text(StringConstant.placeQrInRectangle.tr()), findsOneWidget);
    expect(find.byType(ControlButtons), findsOneWidget);
    expect(find.byType(AllowCameraPermissionInAppSettings), findsNothing);
  });
}
