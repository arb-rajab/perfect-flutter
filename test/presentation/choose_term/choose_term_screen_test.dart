import 'dart:convert';

import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/coupon_type.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/choose_term/check_term_widget.dart';
import 'package:beta/presentation/choose_term/choose_term_screen.dart';
import 'package:beta/presentation/choose_term/choose_term_screen_controller.dart';
import 'package:beta/presentation/choose_term/term_questions_form.dart';
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  group('loading tests', () {
    testWidgets('loading shows a message when a message recieved',
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
      String response =
          r'''{"result":"failed","message":"a message recieved"}''';
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) => server.reply(200, response));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(CheckTermWidget), findsNothing);
      expect(find.text('a message recieved'), findsOneWidget);
    });

    testWidgets('loading shows a no connection message there is no connection',
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
          (server) => server.throws(
              200,
              DioException.connectionError(
                  requestOptions: RequestOptions(), reason: 'no connection')));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(CheckTermWidget), findsNothing);
      expect(find.text(StringConstant.noConnection), findsOneWidget);
    });

    testWidgets('loading shows a loading widget', (widgetTester) async {
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
          (server) => server.throws(
              200,
              DioException.connectionError(
                  requestOptions: RequestOptions(), reason: 'no connection'),
              delay: const Duration(seconds: 1)));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await widgetTester.pumpAndSettle();
    });

    testWidgets('navigation shows a message when a message recieved',
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
      String response =
          r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}],"result":"success","message":""}''';
      String response2 =
          r'''{"result":"failed","message":"a message recieved"}''';
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) => server.reply(200, response));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst('(TERM_ID)', '10002058'),
          (server) => server.reply(200, response2));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('term 1'));
      await widgetTester.pumpAndSettle();
      expect(find.text('term 1'), findsOneWidget);
      expect(find.text('a message recieved'), findsOneWidget);
    });

    testWidgets(
        'navigation shows a no connection message when there is no connection',
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
      String response =
          r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}],"result":"success","message":""}''';
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) => server.reply(200, response));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst('(TERM_ID)', '10002058'),
          (server) => server.throws(
                200,
                DioException.connectionError(
                    requestOptions: RequestOptions(), reason: 'no connection'),
              ));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('term 1'));
      await widgetTester.pumpAndSettle();
      expect(find.text('term 1'), findsOneWidget);
      expect(find.text(StringConstant.noConnection), findsOneWidget);
    });

    testWidgets('navigation shows a loading widget', (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
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
          (server) => server.reply(200, response));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst('(TERM_ID)', '10002058'),
          (server) => server.throws(
              200,
              DioException.connectionError(
                  requestOptions: RequestOptions(), reason: 'no connection'),
              delay: const Duration(seconds: 1)));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('term 1'));
      await widgetTester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await widgetTester.pumpAndSettle();
    });
  });

  group('back press tests', () {
    testWidgets('back press navigates to the previous layer',
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
      String response =
          r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}],"result":"success","message":""}''';
      String response2 =
          r'''{"terms":[{"id":10003608,"uuid":"b8a7da2dcee07a9ebfa4ccdf49c67056","ordering":10003608,"name":"\u0627\u0644\u0641\u0631\u0639\u0627\u0644\u0639\u0644\u0645\u064a","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"\u0634\u0647\u0627\u062f\u0629 \u0627\u0644\u062a\u0639\u0644\u064a\u0645\u0627\u0644\u062b\u0627\u0646\u0648\u064a","creation":"2024-09-12T12:09:33.000000Z","onUpdate":"2025-04-18T21:10:58.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":1}],"result":"success","message":""}''';
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) => server.reply(200, response));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst('(TERM_ID)', '10002058'),
          (server) => server.reply(200, response2));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('term 1'));
      await widgetTester.pumpAndSettle();
      expect(find.text('term 1'), findsNothing);
      ChooseTermScreenController controller = Get.find();
      expect(controller.canPop(), false);
      controller.onPopInvoked(false, null);
      await widgetTester.pumpAndSettle();
      expect(find.text('term 1'), findsOneWidget);
    });

    testWidgets('back press closes screen when no more layers',
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
          (server) => server.reply(200, response));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      ChooseTermScreenController controller = Get.find();
      expect(controller.canPop(), true);
    });

    testWidgets('back press closes screen when terms recieved with coupon',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
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
      ChooseTermScreenController controller = Get.find();
      expect(controller.canPop(), true);
    });
  });

  group('ok button tests', () {
    testWidgets('ok button is visible when recieving terms with coupon',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon,
          terms: [
            TermData.fromJson(jsonDecode(
                r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
          ],
          couponType: couponType));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(SubmitButton), findsOneWidget);
    });

    testWidgets('ok button is not visible when navigating between layers',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":3,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: [], couponType: couponType));
      String response =
          r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}],"result":"success","message":""}''';
      String response2 =
          r'''{"terms":[{"id":10003608,"uuid":"b8a7da2dcee07a9ebfa4ccdf49c67056","ordering":10003608,"name":"\u0627\u0644\u0641\u0631\u0639\u0627\u0644\u0639\u0644\u0645\u064a","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"\u0634\u0647\u0627\u062f\u0629 \u0627\u0644\u062a\u0639\u0644\u064a\u0645\u0627\u0644\u062b\u0627\u0646\u0648\u064a","creation":"2024-09-12T12:09:33.000000Z","onUpdate":"2025-04-18T21:10:58.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":1}],"result":"success","message":""}''';
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) => server.reply(200, response));
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst('(TERM_ID)', '10002058'),
          (server) => server.reply(200, response2));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('term 1'));
      await widgetTester.pumpAndSettle();
      expect(find.byType(SubmitButton), findsNothing);
    });

    testWidgets(
        'ok button is visible when choosing terms according to coupon type number of objects and becomes invisible when unselecting',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":1,"numberOfObjects":2,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: [], couponType: couponType));
      String response =
          r'''{"terms":[{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10002051,"uuid":"498f14aa-c9ba-11ed-94ac-00e5d7377621","ordering":10002051,"name":"\u0643\u0644\u064a\u0629 \u0637\u0628\u0627\u0644\u0623\u0633\u0646\u0627\u0646 \u0628\u062c\u0627\u0645\u0639\u0629\u0627\u0644\u0628\u0639\u062b","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-23T20:35:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4},{"id":10001613,"uuid":"9122c6d2-8dbb-11ed-84cf-00e5d7377621","ordering":10001613,"name":"term 2","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-01-06T12:13:45.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":5}],"result":"success","message":""}''';
      dioAdapter.onGet(
          ApiConstant.termSubTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString())
              .replaceFirst(
                  '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
              .replaceFirst(
                  '(TERM_ID)', couponType.rootTermId.value.toString()),
          (server) => server.reply(200, response));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('term 1'));
      await widgetTester.pumpAndSettle();
      expect(find.byType(SubmitButton), findsNothing);
      await widgetTester.tap(find.text('term 2'));
      await widgetTester.pumpAndSettle();
      expect(find.byType(SubmitButton), findsOneWidget);
      await widgetTester.tap(find.text('term 2'));
      await widgetTester.pumpAndSettle();
      expect(find.byType(SubmitButton), findsNothing);
    });

    testWidgets(
        'ok button click shows confirmation dialogue widget for paid coupons',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon,
          terms: [
            TermData.fromJson(jsonDecode(
                r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
          ],
          couponType: couponType));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ConfirmationDialogueWidget), findsOneWidget);
    });

    testWidgets(
        'ok button click shows confirmation dialogue widget for paid coupons and sends data when ok clicked',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      List<TermData> linkedTerms = [
        TermData.fromJson(jsonDecode(
            r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
      ];
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: linkedTerms, couponType: couponType));
      dioAdapter.onPost(
        ApiConstant.linkCouponWithTerms
            .replaceFirst('(COUPON_ID)', coupon.id.toString()),
        (server) => server.throws(
            200,
            DioException.connectionError(
                requestOptions: RequestOptions(), reason: 'no connection'),
            delay: const Duration(seconds: 1)),
        data: FormData.fromMap({
          'terms': jsonEncode(linkedTerms.map((e) => e.toJson()).toList()),
          'termQuestions': '[]'
        }),
      );
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byKey(const Key('ok')));
      await widgetTester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await widgetTester.pumpAndSettle();
      expect(find.byType(ConfirmDialogue), findsNothing);
    });

    testWidgets(
        'ok button click shows confirmation dialogue widget for paid coupons but does not send data when cancel clicked',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon,
          terms: [
            TermData.fromJson(jsonDecode(
                r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
          ],
          couponType: couponType));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text(StringConstant.cancel));
      await widgetTester.pump();
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets(
        'ok button click does not show confirmation dialogue widget for free coupons',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon,
          terms: [
            TermData.fromJson(jsonDecode(
                r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
          ],
          couponType: couponType));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ConfirmationDialogueWidget), findsNothing);
    });

    testWidgets(
        'ok button click shows term question form when recieving questions',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      List<TermData> linkedTerms = [
        TermData.fromJson(jsonDecode(
            r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
      ];
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: linkedTerms, couponType: couponType));
      String response =
          r'''{"termQuestions":[{"id":1,"termId":1,"title":"question title","type":1,"multi_selections":[{"id":1,"title":"selection 1 title","term_question_id":1},{"id":2,"title":"selection 2 title","term_question_id":1}]}],"result":"success","message":""}''';
      dioAdapter.onPost(
          ApiConstant.linkCouponWithTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString()),
          (server) => server.reply(200, response),
          data: FormData.fromMap({
            'terms': jsonEncode(linkedTerms.map((e) => e.toJson()).toList()),
            'termQuestions': '[]'
          }));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.byType(TermQuestionsForm), findsOneWidget);
    });

    testWidgets(
        'ok button click shows term question form when recieving questions and submits data once answered',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      List<TermData> linkedTerms = [
        TermData.fromJson(jsonDecode(
            r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
      ];
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: linkedTerms, couponType: couponType));
      String response =
          r'''{"termQuestions":[{"id":1,"termId":1,"title":"question title","type":1,"multi_selections":[{"id":1,"title":"selection 1 title","term_question_id":1},{"id":2,"title":"selection 2 title","term_question_id":1}]}],"result":"success","message":""}''';
      String response2 =
          r'''{"terms": [{"id": 1,"uuid": "8c4adac26d7538aafdc06742b91c73ff","ordering": 1,"name": "studio","type": 0,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-02-04 19:39:27","onUpdate": "2024-07-0720:34:04","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 2,"uuid": "39c4aa2edfacba7ab51ee41d11afe673","ordering": 2,"name": "\u0645\u0633\u062a\u0648\u0649\u0623\u0648\u0644","type": 0,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-02-11 09:28:20","onUpdate": "2024-02-2815:19:59","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 3,"uuid": "96cdb4388f33aa7c9cc32cc094a8a61f","ordering": 3,"name": "\u0623\u0633\u062a\u0627\u0630\u0631\u062c\u0628-3-3","type": 0,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-02-11 09:28:46","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 12,"uuid": "2d3d2e9704b5c590671d11c69023848e","ordering": 12,"name": "\u0643\u062a\u0627\u0628\u064a-12-12","type": 2,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-03-02 17:36:41","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 10,"uuid": "aaf8a58ed66271383b17f90dd497af61","ordering": 10,"name": "\u0648\u062d\u062f\u0629-10-10","type": 0,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-03-0120:27:44","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 14,"uuid": "7e2d74d5a3af8a442c012f35cd6a9943","ordering": 14,"name": "\u0641\u064a\u062f\u064a\u0648-14-14","type": 4,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-03-06 20:30:34","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 21,"uuid": "498390cf0506f6f31f288930e077a39d","ordering": 21,"name": "object3","type": 3,"visible": 1,"innerNote": "","outerNote": "","free": 0,"captureable": 0,"minimumSupportedVersion": 0,"text": "","creation": "2023-04-0812:27:38","onUpdate": "2024-02-2820:12:21","deleted_at": null,"deleted_by": null,"enabled": 0}, {"id": 52,"uuid": "13d0a26c18682d3e8dc751f52e7bf4f0","ordering": 52,"name": "under thetree-52-52","type": 6,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-07-2404:04:17","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}],"coupon": {"id": 310,"serial": "943ca9a7-af81-6b1e-f0c6-5827a57ed7ba","ordering": 1000,"type": 1,"deviceId": 25,"used": 1,"prePaid": 0,"free": 1,"price": 0,"logId": 0,"note": null,"expirationDays": -1,"activationDate": "2025-04-27T08:00:49.584135Z","termPrintId": 0,"creation": "2025-04-27 07:44:04","onUpdate": null,"coupon_type": {"id": 1,"name": "\u0645\u0646\u0647\u0627\u062c\u0645\u062c\u0627\u0646\u064a","layer": 1,"numberOfObjects": 1,"rootTermId": -1,"defaultExpirationDays": 730,"allowedTermsTags": "[0]","excludedTerms": "[]","creation": "2021-02-15 13:53:24","onUpdate": "2024-07-0616:17:42"}},"related-terms": [{"termId": 30,"anotherTermId": 26,"created_at": "-000001-11-30T00:00:00.000000Z","deleted_at": null,"deleted_by": null}, {"termId": 30,"anotherTermId": 5000,"created_at": "-000001-11-30T00:00:00.000000Z","deleted_at": null,"deleted_by": null}, {"termId": 58,"anotherTermId": 57,"created_at": "2024-03-01T19:53:45.000000Z","deleted_at": null,"deleted_by": null}],"terms-with-questions-levelling-enabled": [{"termId": 10,"creation": "2024-03-04T15:01:10.000000Z","onUpdate": "2024-03-04T15:01:10.000000Z","deleted_at": null,"deleted_by": null}],"terms-with-homework-enabled": [],"terms-parents": [{"termId": 1,"parentTermId": -1,"layer": 1,"rootTermId": -1,"creation": "2023-02-04 19:39:52","onUpdate": "2023-02-0419:43:01","deleted_at": null,"deleted_by": null}, {"termId": 2,"parentTermId": 1,"layer": 2,"rootTermId": -1,"creation": "2023-02-1109:28:20","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 3,"parentTermId": 2,"layer": 3,"rootTermId": -1,"creation": "2023-02-1109:28:46","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 10,"parentTermId": 3,"layer": 4,"rootTermId": -1,"creation": "2023-03-0120:27:44","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 14,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-03-0620:30:34","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 12,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-03-0217:36:41","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 21,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-04-0812:27:38","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 52,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-07-2404:04:17","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 30,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-04-2720:29:49","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 57,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2024-02-2820:13:03","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 58,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2024-02-2820:16:27","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 67,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2024-03-0111:19:24","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 68,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2024-11-2611:29:29","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 69,"parentTermId": 2,"layer": 3,"rootTermId": -1,"creation": "2025-02-2019:46:23","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 70,"parentTermId": 69,"layer": 4,"rootTermId": -1,"creation": "2025-02-2019:46:45","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 71,"parentTermId": 70,"layer": 5,"rootTermId": -1,"creation": "2025-02-2019:47:05","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}],"terms-linked-to-tags": [{"termId": 57,"tagId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-07-07 20:33:39","onUpdate": "2024-07-07 20:33:39"}, {"termId": 68,"tagId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-11-2611:34:41","onUpdate": "2024-11-26 11:34:41"}, {"termId": 30,"tagId": 2,"deleted_at": null,"deleted_by": null,"creation": "2025-02-0813:05:11","onUpdate": null}, {"termId": 71,"tagId": 1,"deleted_at": null,"deleted_by": null,"creation": "2025-02-2019:48:04","onUpdate": null}],"terms-tags": [{"id": 1,"name": "\u0641\u064a\u062f\u064a\u0648\u0647\u0627\u062a","addNewLabel": "\u0625\u0636\u0627\u0641\u0629 \u0641\u064a\u062f\u064a\u0648 \u062c\u062f\u064a\u062f","ordering": 0,"creation": "2023-02-04 16:51:42","onUpdate": "2023-02-0416:51:22"}, {"id": 2,"name": "\u0641\u0644\u0627\u0634 \u0643\u0627\u0631\u062f\u0632","addNewLabel": "\u0625\u0636\u0627\u0641\u0629\u0641\u0644\u0627\u0634 \u0643\u0627\u0631\u062f \u062c\u062f\u064a\u062f","ordering": 0,"creation": "2023-02-04 16:51:42","onUpdate": "2023-02-0416:51:22"}],"terms-linked-to-labels": [{"termId": 30,"labelId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-03-0412:17:48","onUpdate": "0000-00-00 00:00:00"}, {"termId": 57,"labelId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-03-0412:17:48","onUpdate": "0000-00-00 00:00:00"}, {"termId": 10,"labelId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-03-0412:18:38","onUpdate": "0000-00-00 00:00:00"}],"terms-labels": [{"id": 1,"name": "Label","creation": "2024-03-02 08:35:36","onUpdate": "2024-03-0208:35:25"}],"result": "success","message": ""}''';
      dioAdapter.onPost(
          ApiConstant.linkCouponWithTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString()),
          (server) => server.reply(200, response),
          data: FormData.fromMap({
            'terms': jsonEncode(linkedTerms.map((e) => e.toJson()).toList()),
            'termQuestions': '[]'
          }));
      dioAdapter.onPost(
          ApiConstant.linkCouponWithTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString()),
          (server) => server.reply(200, response2),
          data: FormData.fromMap({
            'terms': jsonEncode(linkedTerms.map((e) => e.toJson()).toList()),
            'termQuestions': jsonEncode([
              {'id': 1, 'answer': '2'}
            ])
          }));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.byType(TermQuestionsForm), findsOneWidget);
      await widgetTester.tap(find.text('selection 1 title'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('selection 2 title'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byKey(const Key(StringConstant.ok)));
      await widgetTester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await widgetTester.pumpAndSettle();
      expect(find.byType(TermQuestionsForm), findsNothing);
    });

    testWidgets(
        'ok button click shows term question form when recieving questions and submits first answer by default',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      List<TermData> linkedTerms = [
        TermData.fromJson(jsonDecode(
            r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
      ];
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: linkedTerms, couponType: couponType));
      String response =
          r'''{"termQuestions":[{"id":1,"termId":1,"title":"question title","type":1,"multi_selections":[{"id":1,"title":"selection 1 title","term_question_id":1},{"id":2,"title":"selection 2 title","term_question_id":1}]}],"result":"success","message":""}''';
      String response2 =
          r'''{"terms": [{"id": 1,"uuid": "8c4adac26d7538aafdc06742b91c73ff","ordering": 1,"name": "studio","type": 0,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-02-04 19:39:27","onUpdate": "2024-07-0720:34:04","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 2,"uuid": "39c4aa2edfacba7ab51ee41d11afe673","ordering": 2,"name": "\u0645\u0633\u062a\u0648\u0649\u0623\u0648\u0644","type": 0,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-02-11 09:28:20","onUpdate": "2024-02-2815:19:59","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 3,"uuid": "96cdb4388f33aa7c9cc32cc094a8a61f","ordering": 3,"name": "\u0623\u0633\u062a\u0627\u0630\u0631\u062c\u0628-3-3","type": 0,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-02-11 09:28:46","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 12,"uuid": "2d3d2e9704b5c590671d11c69023848e","ordering": 12,"name": "\u0643\u062a\u0627\u0628\u064a-12-12","type": 2,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-03-02 17:36:41","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 10,"uuid": "aaf8a58ed66271383b17f90dd497af61","ordering": 10,"name": "\u0648\u062d\u062f\u0629-10-10","type": 0,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-03-0120:27:44","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 14,"uuid": "7e2d74d5a3af8a442c012f35cd6a9943","ordering": 14,"name": "\u0641\u064a\u062f\u064a\u0648-14-14","type": 4,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-03-06 20:30:34","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 21,"uuid": "498390cf0506f6f31f288930e077a39d","ordering": 21,"name": "object3","type": 3,"visible": 1,"innerNote": "","outerNote": "","free": 0,"captureable": 0,"minimumSupportedVersion": 0,"text": "","creation": "2023-04-0812:27:38","onUpdate": "2024-02-2820:12:21","deleted_at": null,"deleted_by": null,"enabled": 0}, {"id": 52,"uuid": "13d0a26c18682d3e8dc751f52e7bf4f0","ordering": 52,"name": "under thetree-52-52","type": 6,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-07-2404:04:17","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}],"coupon": {"id": 310,"serial": "943ca9a7-af81-6b1e-f0c6-5827a57ed7ba","ordering": 1000,"type": 1,"deviceId": 25,"used": 1,"prePaid": 0,"free": 1,"price": 0,"logId": 0,"note": null,"expirationDays": -1,"activationDate": "2025-04-27T08:00:49.584135Z","termPrintId": 0,"creation": "2025-04-27 07:44:04","onUpdate": null,"coupon_type": {"id": 1,"name": "\u0645\u0646\u0647\u0627\u062c\u0645\u062c\u0627\u0646\u064a","layer": 1,"numberOfObjects": 1,"rootTermId": -1,"defaultExpirationDays": 730,"allowedTermsTags": "[0]","excludedTerms": "[]","creation": "2021-02-15 13:53:24","onUpdate": "2024-07-0616:17:42"}},"related-terms": [{"termId": 30,"anotherTermId": 26,"created_at": "-000001-11-30T00:00:00.000000Z","deleted_at": null,"deleted_by": null}, {"termId": 30,"anotherTermId": 5000,"created_at": "-000001-11-30T00:00:00.000000Z","deleted_at": null,"deleted_by": null}, {"termId": 58,"anotherTermId": 57,"created_at": "2024-03-01T19:53:45.000000Z","deleted_at": null,"deleted_by": null}],"terms-with-questions-levelling-enabled": [{"termId": 10,"creation": "2024-03-04T15:01:10.000000Z","onUpdate": "2024-03-04T15:01:10.000000Z","deleted_at": null,"deleted_by": null}],"terms-with-homework-enabled": [],"terms-parents": [{"termId": 1,"parentTermId": -1,"layer": 1,"rootTermId": -1,"creation": "2023-02-04 19:39:52","onUpdate": "2023-02-0419:43:01","deleted_at": null,"deleted_by": null}, {"termId": 2,"parentTermId": 1,"layer": 2,"rootTermId": -1,"creation": "2023-02-1109:28:20","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 3,"parentTermId": 2,"layer": 3,"rootTermId": -1,"creation": "2023-02-1109:28:46","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 10,"parentTermId": 3,"layer": 4,"rootTermId": -1,"creation": "2023-03-0120:27:44","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 14,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-03-0620:30:34","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 12,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-03-0217:36:41","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 21,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-04-0812:27:38","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 52,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-07-2404:04:17","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 30,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-04-2720:29:49","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 57,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2024-02-2820:13:03","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 58,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2024-02-2820:16:27","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 67,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2024-03-0111:19:24","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 68,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2024-11-2611:29:29","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 69,"parentTermId": 2,"layer": 3,"rootTermId": -1,"creation": "2025-02-2019:46:23","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 70,"parentTermId": 69,"layer": 4,"rootTermId": -1,"creation": "2025-02-2019:46:45","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 71,"parentTermId": 70,"layer": 5,"rootTermId": -1,"creation": "2025-02-2019:47:05","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}],"terms-linked-to-tags": [{"termId": 57,"tagId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-07-07 20:33:39","onUpdate": "2024-07-07 20:33:39"}, {"termId": 68,"tagId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-11-2611:34:41","onUpdate": "2024-11-26 11:34:41"}, {"termId": 30,"tagId": 2,"deleted_at": null,"deleted_by": null,"creation": "2025-02-0813:05:11","onUpdate": null}, {"termId": 71,"tagId": 1,"deleted_at": null,"deleted_by": null,"creation": "2025-02-2019:48:04","onUpdate": null}],"terms-tags": [{"id": 1,"name": "\u0641\u064a\u062f\u064a\u0648\u0647\u0627\u062a","addNewLabel": "\u0625\u0636\u0627\u0641\u0629 \u0641\u064a\u062f\u064a\u0648 \u062c\u062f\u064a\u062f","ordering": 0,"creation": "2023-02-04 16:51:42","onUpdate": "2023-02-0416:51:22"}, {"id": 2,"name": "\u0641\u0644\u0627\u0634 \u0643\u0627\u0631\u062f\u0632","addNewLabel": "\u0625\u0636\u0627\u0641\u0629\u0641\u0644\u0627\u0634 \u0643\u0627\u0631\u062f \u062c\u062f\u064a\u062f","ordering": 0,"creation": "2023-02-04 16:51:42","onUpdate": "2023-02-0416:51:22"}],"terms-linked-to-labels": [{"termId": 30,"labelId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-03-0412:17:48","onUpdate": "0000-00-00 00:00:00"}, {"termId": 57,"labelId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-03-0412:17:48","onUpdate": "0000-00-00 00:00:00"}, {"termId": 10,"labelId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-03-0412:18:38","onUpdate": "0000-00-00 00:00:00"}],"terms-labels": [{"id": 1,"name": "Label","creation": "2024-03-02 08:35:36","onUpdate": "2024-03-0208:35:25"}],"result": "success","message": ""}''';
      dioAdapter.onPost(
          ApiConstant.linkCouponWithTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString()),
          (server) => server.reply(200, response),
          data: FormData.fromMap({
            'terms': jsonEncode(linkedTerms.map((e) => e.toJson()).toList()),
            'termQuestions': '[]'
          }));
      dioAdapter.onPost(
          ApiConstant.linkCouponWithTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString()),
          (server) => server.reply(200, response2),
          data: FormData.fromMap({
            'terms': jsonEncode(linkedTerms.map((e) => e.toJson()).toList()),
            'termQuestions': jsonEncode([
              {'id': 1, 'answer': '1'}
            ])
          }));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.byType(TermQuestionsForm), findsOneWidget);
      await widgetTester.tap(find.byKey(const Key(StringConstant.ok)));
      await widgetTester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await widgetTester.pumpAndSettle();
      expect(find.byType(TermQuestionsForm), findsNothing);
    });

    testWidgets('ok button click pops screen when data is successfully sent',
        (widgetTester) async {
      String response =
          r'''{"terms": [{"id": 1,"uuid": "8c4adac26d7538aafdc06742b91c73ff","ordering": 1,"name": "studio","type": 0,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-02-04 19:39:27","onUpdate": "2024-07-0720:34:04","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 2,"uuid": "39c4aa2edfacba7ab51ee41d11afe673","ordering": 2,"name": "\u0645\u0633\u062a\u0648\u0649\u0623\u0648\u0644","type": 0,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-02-11 09:28:20","onUpdate": "2024-02-2815:19:59","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 3,"uuid": "96cdb4388f33aa7c9cc32cc094a8a61f","ordering": 3,"name": "\u0623\u0633\u062a\u0627\u0630\u0631\u062c\u0628-3-3","type": 0,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-02-11 09:28:46","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 12,"uuid": "2d3d2e9704b5c590671d11c69023848e","ordering": 12,"name": "\u0643\u062a\u0627\u0628\u064a-12-12","type": 2,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-03-02 17:36:41","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 10,"uuid": "aaf8a58ed66271383b17f90dd497af61","ordering": 10,"name": "\u0648\u062d\u062f\u0629-10-10","type": 0,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-03-0120:27:44","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 14,"uuid": "7e2d74d5a3af8a442c012f35cd6a9943","ordering": 14,"name": "\u0641\u064a\u062f\u064a\u0648-14-14","type": 4,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-03-06 20:30:34","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}, {"id": 21,"uuid": "498390cf0506f6f31f288930e077a39d","ordering": 21,"name": "object3","type": 3,"visible": 1,"innerNote": "","outerNote": "","free": 0,"captureable": 0,"minimumSupportedVersion": 0,"text": "","creation": "2023-04-0812:27:38","onUpdate": "2024-02-2820:12:21","deleted_at": null,"deleted_by": null,"enabled": 0}, {"id": 52,"uuid": "13d0a26c18682d3e8dc751f52e7bf4f0","ordering": 52,"name": "under thetree-52-52","type": 6,"visible": 1,"innerNote": "","outerNote": "","free": 1,"captureable": 1,"minimumSupportedVersion": 0,"text": "","creation": "2023-07-2404:04:17","onUpdate": "2024-02-1320:27:50","deleted_at": null,"deleted_by": null,"enabled": 1}],"coupon": {"id": 310,"serial": "943ca9a7-af81-6b1e-f0c6-5827a57ed7ba","ordering": 1000,"type": 1,"deviceId": 25,"used": 1,"prePaid": 0,"free": 1,"price": 0,"logId": 0,"note": null,"expirationDays": -1,"activationDate": "2025-04-27T08:00:49.584135Z","termPrintId": 0,"creation": "2025-04-27 07:44:04","onUpdate": null,"coupon_type": {"id": 1,"name": "\u0645\u0646\u0647\u0627\u062c\u0645\u062c\u0627\u0646\u064a","layer": 1,"numberOfObjects": 1,"rootTermId": -1,"defaultExpirationDays": 730,"allowedTermsTags": "[0]","excludedTerms": "[]","creation": "2021-02-15 13:53:24","onUpdate": "2024-07-0616:17:42"}},"related-terms": [{"termId": 30,"anotherTermId": 26,"created_at": "-000001-11-30T00:00:00.000000Z","deleted_at": null,"deleted_by": null}, {"termId": 30,"anotherTermId": 5000,"created_at": "-000001-11-30T00:00:00.000000Z","deleted_at": null,"deleted_by": null}, {"termId": 58,"anotherTermId": 57,"created_at": "2024-03-01T19:53:45.000000Z","deleted_at": null,"deleted_by": null}],"terms-with-questions-levelling-enabled": [{"termId": 10,"creation": "2024-03-04T15:01:10.000000Z","onUpdate": "2024-03-04T15:01:10.000000Z","deleted_at": null,"deleted_by": null}],"terms-with-homework-enabled": [],"terms-parents": [{"termId": 1,"parentTermId": -1,"layer": 1,"rootTermId": -1,"creation": "2023-02-04 19:39:52","onUpdate": "2023-02-0419:43:01","deleted_at": null,"deleted_by": null}, {"termId": 2,"parentTermId": 1,"layer": 2,"rootTermId": -1,"creation": "2023-02-1109:28:20","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 3,"parentTermId": 2,"layer": 3,"rootTermId": -1,"creation": "2023-02-1109:28:46","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 10,"parentTermId": 3,"layer": 4,"rootTermId": -1,"creation": "2023-03-0120:27:44","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 14,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-03-0620:30:34","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 12,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-03-0217:36:41","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 21,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-04-0812:27:38","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 52,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-07-2404:04:17","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 30,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2023-04-2720:29:49","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 57,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2024-02-2820:13:03","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 58,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2024-02-2820:16:27","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 67,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2024-03-0111:19:24","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 68,"parentTermId": 10,"layer": 5,"rootTermId": -1,"creation": "2024-11-2611:29:29","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 69,"parentTermId": 2,"layer": 3,"rootTermId": -1,"creation": "2025-02-2019:46:23","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 70,"parentTermId": 69,"layer": 4,"rootTermId": -1,"creation": "2025-02-2019:46:45","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}, {"termId": 71,"parentTermId": 70,"layer": 5,"rootTermId": -1,"creation": "2025-02-2019:47:05","onUpdate": "0000-00-0000:00:00","deleted_at": null,"deleted_by": null}],"terms-linked-to-tags": [{"termId": 57,"tagId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-07-07 20:33:39","onUpdate": "2024-07-07 20:33:39"}, {"termId": 68,"tagId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-11-2611:34:41","onUpdate": "2024-11-26 11:34:41"}, {"termId": 30,"tagId": 2,"deleted_at": null,"deleted_by": null,"creation": "2025-02-0813:05:11","onUpdate": null}, {"termId": 71,"tagId": 1,"deleted_at": null,"deleted_by": null,"creation": "2025-02-2019:48:04","onUpdate": null}],"terms-tags": [{"id": 1,"name": "\u0641\u064a\u062f\u064a\u0648\u0647\u0627\u062a","addNewLabel": "\u0625\u0636\u0627\u0641\u0629 \u0641\u064a\u062f\u064a\u0648 \u062c\u062f\u064a\u062f","ordering": 0,"creation": "2023-02-04 16:51:42","onUpdate": "2023-02-0416:51:22"}, {"id": 2,"name": "\u0641\u0644\u0627\u0634 \u0643\u0627\u0631\u062f\u0632","addNewLabel": "\u0625\u0636\u0627\u0641\u0629\u0641\u0644\u0627\u0634 \u0643\u0627\u0631\u062f \u062c\u062f\u064a\u062f","ordering": 0,"creation": "2023-02-04 16:51:42","onUpdate": "2023-02-0416:51:22"}],"terms-linked-to-labels": [{"termId": 30,"labelId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-03-0412:17:48","onUpdate": "0000-00-00 00:00:00"}, {"termId": 57,"labelId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-03-0412:17:48","onUpdate": "0000-00-00 00:00:00"}, {"termId": 10,"labelId": 1,"deleted_at": null,"deleted_by": null,"creation": "2024-03-0412:18:38","onUpdate": "0000-00-00 00:00:00"}],"terms-labels": [{"id": 1,"name": "Label","creation": "2024-03-02 08:35:36","onUpdate": "2024-03-0208:35:25"}],"result": "success","message": ""}''';
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      List<TermData> linkedTerms = [
        TermData.fromJson(jsonDecode(
            r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
      ];
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: linkedTerms, couponType: couponType));
      dioAdapter.onPost(
          ApiConstant.linkCouponWithTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString()),
          (server) => server.reply(200, response),
          data: FormData.fromMap({
            'terms': jsonEncode(linkedTerms.map((e) => e.toJson()).toList()),
            'termQuestions': '[]'
          }));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      ChooseTermScreenController controller = Get.find();
      expect(controller.finished, true);
    });

    testWidgets('ok buttons shows a message when a message recieved',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      List<TermData> linkedTerms = [
        TermData.fromJson(jsonDecode(
            r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
      ];
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: linkedTerms, couponType: couponType));
      String response = r'''{"result":"failed","message":"an error message"}''';
      dioAdapter.onPost(
          ApiConstant.linkCouponWithTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString()),
          (server) => server.reply(200, response),
          data: FormData.fromMap({
            'terms': jsonEncode(linkedTerms.map((e) => e.toJson()).toList()),
            'termQuestions': '[]'
          }));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.text('an error message'), findsOneWidget);
    });

    testWidgets(
        'ok buttons shows a no connection message when there is no connection',
        (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      List<TermData> linkedTerms = [
        TermData.fromJson(jsonDecode(
            r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
      ];
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: linkedTerms, couponType: couponType));
      dioAdapter.onPost(
          ApiConstant.linkCouponWithTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString()),
          (server) => server.throws(
              200,
              DioException.connectionError(
                  requestOptions: RequestOptions(), reason: 'no connection')),
          data: FormData.fromMap({
            'terms': jsonEncode(linkedTerms.map((e) => e.toJson()).toList()),
            'termQuestions': '[]'
          }));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.noConnection), findsOneWidget);
    });

    testWidgets('ok buttons shows a loading widget', (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      List<TermData> linkedTerms = [
        TermData.fromJson(jsonDecode(
            r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
      ];
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon, terms: linkedTerms, couponType: couponType));
      dioAdapter.onPost(
          ApiConstant.linkCouponWithTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString()),
          (server) => server.throws(
              200,
              DioException.connectionError(
                  requestOptions: RequestOptions(), reason: 'no connection'),
              delay: const Duration(seconds: 1)),
          data: FormData.fromMap({
            'terms': jsonEncode(linkedTerms.map((e) => e.toJson()).toList()),
            'termQuestions': '[]'
          }));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await widgetTester.pumpAndSettle();
    });
  });

  group('confirmation dialogue tests', () {
    testWidgets('about to link text exists', (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon,
          terms: [
            TermData.fromJson(jsonDecode(
                r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
          ],
          couponType: couponType));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.aboutToCouponWithTerms), findsOneWidget);
    });

    testWidgets('do you want to proceed text exists', (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon,
          terms: [
            TermData.fromJson(jsonDecode(
                r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
          ],
          couponType: couponType));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.doYouWantToProceed), findsOneWidget);
    });

    testWidgets('term path exists', (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon,
          terms: [
            TermData.fromJson(jsonDecode(
                r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"path","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
          ],
          couponType: couponType));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.text('path'), findsOneWidget);
    });

    testWidgets('term name exists', (widgetTester) async {
      dynamic data = jsonDecode(r'''
    {"coupon":{"id":10121793,"serial":"fab9d088-9e54-19e6-f3f2-2a17dac52164","ordering":1000,"type":10000033,"deviceId":10027892,"used":1,"prePaid":0,"free":0,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-2313:31:49","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027892,"result":"success","message":""}
    ''');
      Coupon coupon = Coupon.fromJson(data['coupon']);
      CouponType couponType =
          CouponType.fromJson(data['coupon']['coupon_type']);
      Get.delete<ChooseTermScreenArgument>();
      Get.put(ChooseTermScreenArgument(
          coupon: coupon,
          terms: [
            TermData.fromJson(jsonDecode(
                r'''{"id":10002058,"uuid":"35dde817-cb5c-11ed-94ac-00e5d7377621","ordering":10002058,"name":"term 1","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","path":"path","creation":"2023-03-25T22:27:21.000000Z","onUpdate":"2025-04-18T21:09:43.000000Z","deleted_at":null,"deleted_by":null,"numberOfSubTerms":4}''')),
          ],
          couponType: couponType));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ChooseTermScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.text('term 1'), findsOneWidget);
    });
  });
}
