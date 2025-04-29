import 'dart:convert';

import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/coupon_type.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/choose_term/check_term_widget.dart';
import 'package:beta/presentation/choose_term/choose_term_screen.dart';
import 'package:beta/presentation/widgets/number_of_children_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  testWidgets('check term widget is rendered', (widgetTester) async {
    dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
    Coupon coupon = Coupon.fromJson(data['coupon']);
    CouponType couponType = CouponType.fromJson(data['coupon']['coupon_type']);
    Get.delete<ChooseTermScreenArgument>();
    Get.delete<ChooseTermScreenArgument>();
    Get.put(ChooseTermScreenArgument(
        coupon: coupon, terms: [], couponType: couponType));
    dioAdapter.onGet(
        ApiConstant.termSubTerms
            .replaceFirst('(COUPON_ID)', coupon.id.toString())
            .replaceFirst(
                '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
            .replaceFirst('(TERM_ID)', couponType.rootTermId.value.toString()),
        (server) {
      server.reply(200,
          r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10002051,"uuid":"498f14aa-c9ba-11ed-94ac-00e5d7377621","ordering":10002051,"name":"\u0643\u0644\u064a\u0629 \u0637\u0628\u0627\u0644\u0623\u0633\u0646\u0627\u0646 \u0628\u062c\u0627\u0645\u0639\u0629\u0627\u0644\u0628\u0639\u062b","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-23T20:35:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10001613,"uuid":"9122c6d2-8dbb-11ed-84cf-00e5d7377621","ordering":10001613,"name":"term 2","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-01-06T12:13:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":5}],"result":"success","message":""}''');
    });
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: ChooseTermScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.byType(CheckTermWidget), findsAny);
  });

  group('path widget tests', () {
    testWidgets('no path is rendered when there is no path',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      String path1 = 'random path 1';
      String path2 = 'random path 2';
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: [], couponType: couponType));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) {
        server.reply(200,
            r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10002051,"uuid":"498f14aa-c9ba-11ed-94ac-00e5d7377621","ordering":10002051,"name":"\u0643\u0644\u064a\u0629 \u0637\u0628\u0627\u0644\u0623\u0633\u0646\u0627\u0646 \u0628\u062c\u0627\u0645\u0639\u0629\u0627\u0644\u0628\u0639\u062b","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-23T20:35:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10001613,"uuid":"9122c6d2-8dbb-11ed-84cf-00e5d7377621","ordering":10001613,"name":"term 2","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-01-06T12:13:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":5}],"result":"success","message":""}''');
      });
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.text(path1), findsNothing);
      expect(find.text(path2), findsNothing);
    });

    testWidgets('a path is rendered when there is a path',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      String path1 = 'random path 1'; // exists in json response
      String path2 = 'random path 2';
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: [], couponType: couponType));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) {
        server.reply(200,
            r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"random path 1","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10002051,"uuid":"498f14aa-c9ba-11ed-94ac-00e5d7377621","ordering":10002051,"name":"\u0643\u0644\u064a\u0629 \u0637\u0628\u0627\u0644\u0623\u0633\u0646\u0627\u0646 \u0628\u062c\u0627\u0645\u0639\u0629\u0627\u0644\u0628\u0639\u062b","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-23T20:35:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10001613,"uuid":"9122c6d2-8dbb-11ed-84cf-00e5d7377621","ordering":10001613,"name":"term 2","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-01-06T12:13:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":5}],"result":"success","message":""}''');
      });
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.text(path1), findsOneWidget);
      expect(find.text(path2), findsNothing);
    });

    testWidgets(
        'only the first occurence if the same path is rendered when there is a path',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      String path1 = 'random path 1'; // exists in json response
      String path2 = 'random path 2';
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: [], couponType: couponType));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) {
        server.reply(200,
            r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"random path 1","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10002051,"uuid":"498f14aa-c9ba-11ed-94ac-00e5d7377621","ordering":10002051,"name":"\u0643\u0644\u064a\u0629 \u0637\u0628\u0627\u0644\u0623\u0633\u0646\u0627\u0646 \u0628\u062c\u0627\u0645\u0639\u0629\u0627\u0644\u0628\u0639\u062b","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"random path 1","creation":"2023-03-23T20:35:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10001613,"uuid":"9122c6d2-8dbb-11ed-84cf-00e5d7377621","ordering":10001613,"name":"term 2","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-01-06T12:13:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":5}],"result":"success","message":""}''');
      });
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.text(path1), findsOneWidget);
      expect(find.text(path2), findsNothing);
    });

    testWidgets('two different paths are visible', (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      String path1 = 'random path 1'; // exists in json response
      String path2 = 'random path 2';
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: [], couponType: couponType));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) {
        server.reply(200,
            r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"random path 1","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10002051,"uuid":"498f14aa-c9ba-11ed-94ac-00e5d7377621","ordering":10002051,"name":"\u0643\u0644\u064a\u0629 \u0637\u0628\u0627\u0644\u0623\u0633\u0646\u0627\u0646 \u0628\u062c\u0627\u0645\u0639\u0629\u0627\u0644\u0628\u0639\u062b","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"random path 2","creation":"2023-03-23T20:35:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10001613,"uuid":"9122c6d2-8dbb-11ed-84cf-00e5d7377621","ordering":10001613,"name":"term 2","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-01-06T12:13:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":5}],"result":"success","message":""}''');
      });
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.text(path1), findsOneWidget);
      expect(find.text(path2), findsOneWidget);
    });
  });

  testWidgets('term name is visible', (widgetTester) async {
    dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
    Coupon coupon = Coupon.fromJson(data['coupon']);
    CouponType couponType = CouponType.fromJson(data['coupon']['coupon_type']);
    Get.delete<ChooseTermScreenArgument>();
    Get.delete<ChooseTermScreenArgument>();
    Get.put(ChooseTermScreenArgument(
        coupon: coupon, terms: [], couponType: couponType));
    dioAdapter.onGet(
        ApiConstant.termSubTerms
            .replaceFirst('(COUPON_ID)', coupon.id.toString())
            .replaceFirst(
                '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
            .replaceFirst('(TERM_ID)', couponType.rootTermId.value.toString()),
        (server) {
      server.reply(200,
          r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}],"result":"success","message":""}''');
    });
    String term1 = 'term 1';
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: ChooseTermScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(term1), findsOneWidget);
  });

  group('number of subterms tests', () {
    testWidgets('number of subterms is shown for term with type Term',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: [], couponType: couponType));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) {
        server.reply(200,
            r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}],"result":"success","message":""}''');
      });
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(NumberOfChildrenWidget), findsOneWidget);
      find.widgetWithText(NumberOfChildrenWidget, '4');
    });

    testWidgets(
        'number of subterms is not shown for term with type other than Term',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: [], couponType: couponType));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) {
        server.reply(200,
            r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}],"result":"success","message":""}''');
      });
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(NumberOfChildrenWidget), findsNothing);
    });
  });

  group('trailing widget tests', () {
    testWidgets('next arrow is visible when navigateable',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: [], couponType: couponType));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) {
        server.reply(200,
            r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}],"result":"success","message":""}''');
      });
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byIcon(Icons.navigate_next), findsOneWidget);
      expect(find.byType(Checkbox), findsNothing);
    });

    testWidgets('checkbox is visible when recieving terms',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      ChooseTermScreenArgument argument = Get.put(ChooseTermScreenArgument(
          coupon: coupon,
          terms: [
            TermData.fromJson(jsonDecode(
                r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
            TermData.fromJson(jsonDecode(
                r'''{"id":10001613,"uuid":"9122c6d2-8dbb-11ed-84cf-00e5d7377621","ordering":10001613,"name":"term 2","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-01-06T12:13:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":5}'''))
          ],
          couponType: couponType));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(
          find.byType(CheckTermWidget), findsNWidgets(argument.terms.length));
      expect(find.byIcon(Icons.navigate_next), findsNothing);
      expect(find.byType(Checkbox), findsNWidgets(argument.terms.length));
      expect(
          find.byWidgetPredicate(
              (element) => element is Checkbox && element.value == true),
          findsNWidgets(argument.terms.length));
    });

    testWidgets(
        'checkbox is visible when recieving terms and can not be changed',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      ChooseTermScreenArgument argument = Get.put(ChooseTermScreenArgument(
          coupon: coupon,
          terms: [
            TermData.fromJson(jsonDecode(
                r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
            TermData.fromJson(jsonDecode(
                r'''{"id":10001613,"uuid":"9122c6d2-8dbb-11ed-84cf-00e5d7377621","ordering":10001613,"name":"term 2","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-01-06T12:13:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":5}'''))
          ],
          couponType: couponType));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(
          find.byWidgetPredicate(
              (element) => element is Checkbox && element.value == true),
          findsNWidgets(argument.terms.length));
      await widgetTester.tap(find.text('term 1'));
      await widgetTester.pumpAndSettle();
      expect(
          find.byWidgetPredicate(
              (element) => element is Checkbox && element.value == true),
          findsNWidgets(argument.terms.length));
    });

    testWidgets(
        'checkbox is visible when reaching coupon type layer after navigation',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":1,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: [], couponType: couponType));
      String response =
          r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}],"result":"success","message":""}''';
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) {
        server.reply(200, response);
      });
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(CheckTermWidget),
          findsNWidgets(jsonDecode(response)['terms'].length));
      expect(find.byIcon(Icons.navigate_next), findsNothing);
      expect(find.byType(Checkbox),
          findsNWidgets(jsonDecode(response)['terms'].length));
      expect(
          find.byWidgetPredicate(
              (element) => element is Checkbox && element.value == false),
          findsNWidgets(jsonDecode(response)['terms'].length));
    });

    testWidgets(
        'checkbox is visible when accessing terms after navigation and can be changed',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":1,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: [], couponType: couponType));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) {
        server.reply(200,
            r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}],"result":"success","message":""}''');
      });
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(
          find.byWidgetPredicate(
              (element) => element is Checkbox && element.value == true),
          findsNothing);
      await widgetTester.tap(find.text('term 1'));
      await widgetTester.pumpAndSettle();
      expect(
          find.byWidgetPredicate(
              (element) => element is Checkbox && element.value == true),
          findsOneWidget);
    });

    testWidgets(
        'checkbox is visible when accessing terms after navigation and can be changed but can not exceed coupon type number of items',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":1,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: [], couponType: couponType));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) {
        server.reply(200,
            r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"random path 1","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10002051,"uuid":"498f14aa-c9ba-11ed-94ac-00e5d7377621","ordering":10002051,"name":"\u0643\u0644\u064a\u0629 \u0637\u0628\u0627\u0644\u0623\u0633\u0646\u0627\u0646 \u0628\u062c\u0627\u0645\u0639\u0629\u0627\u0644\u0628\u0639\u062b","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"random path 2","creation":"2023-03-23T20:35:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10001613,"uuid":"9122c6d2-8dbb-11ed-84cf-00e5d7377621","ordering":10001613,"name":"term 2","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-01-06T12:13:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":5}],"result":"success","message":""}''');
      });
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(
          find.byWidgetPredicate(
              (element) => element is Checkbox && element.value == true),
          findsNothing);
      await widgetTester.tap(find.text('term 1'));
      await widgetTester.pumpAndSettle();
      expect(
          find.byWidgetPredicate(
              (element) => element is Checkbox && element.value == true),
          findsOneWidget);
      await widgetTester.tap(find.text('term 2'));
      await widgetTester.pumpAndSettle();
      expect(
          find.byWidgetPredicate(
              (element) => element is Checkbox && element.value == true),
          findsOneWidget);
    });
  });
}
