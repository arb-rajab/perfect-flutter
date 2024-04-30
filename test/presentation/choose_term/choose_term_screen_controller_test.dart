import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/domain/coupon_type.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/layer.dart';
import 'package:beta/domain/value/number_of_objects.dart';
import 'package:beta/domain/value/root_term_id.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/choose_term/check_term_widget.dart';
import 'package:beta/presentation/choose_term/choose_term_screen.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  final DioAdapter dioAdapter = DioAdapter(dio: NetworkService.dio);
  Coupon coupon = Coupon(
      free: 0,
      id: 1,
      serial: 'random serial',
      type: 1,
      creation: DateTime.now(),
      expirationDays: 12);
  CouponType couponType = CouponType(
      id: const Id(1),
      layer: const Layer(1),
      rootTermId: const RootTermId(-1),
      numberOfObjects: const NumberOfObjects(1));
  dioAdapter.onGet(
      ApiConstant.termSubTerms
          .replaceFirst('(COUPON_ID)', coupon.id.toString())
          .replaceFirst(
              '(ROOT_TERM_ID)', couponType.rootTermId.value.toString())
          .replaceFirst('(TERM_ID)', couponType.rootTermId.value.toString()),
      (server) {
    server.reply(200,
        '{"terms":[{"id":1,"uuid":"8c4adac26d7538aafdc06742b91c73ff","ordering":1,"name":"studiode","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","creation":"2023-02-04 19:39:27","onUpdate":"2024-02-28 15:16:23","deleted_at":null,"deleted_by":null,"numberOfSubTerms":1,"path":""}],"result":"success","message":""}');
  });
  tearDown(() => Get.delete<ChooseTermScreenArgument>());

  group('ok click', () {
    testWidgets('ok click shows confirm dialogue when coupon is not free',
        (widgetTester) async {
      Get.put(ChooseTermScreenArgument(
        coupon: coupon,
        terms: [],
        free: false,
        couponType: couponType,
      ));
      await widgetTester
          .pumpWidget(const MaterialApp(home: ChooseTermScreen()));
      await widgetTester.pump(animationDuration);
      await widgetTester.tap(find.byType(CheckTermWidget));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ConfirmationDialogueWidget), findsOneWidget);
    });

    testWidgets('ok click does not show confirm dialogue when coupon is free',
        (widgetTester) async {
      Get.put(ChooseTermScreenArgument(
        coupon: coupon,
        terms: [],
        free: true,
        couponType: couponType,
      ));
      await widgetTester
          .pumpWidget(const MaterialApp(home: ChooseTermScreen()));
      await widgetTester.pump(animationDuration);
      await widgetTester.tap(find.byType(CheckTermWidget));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ConfirmationDialogueWidget), findsNothing);
    });
  });

  /*group('send data', () {
    testWidgets(
        'send data shows terms questions form when questions are recieved',
        (widgetTester) async {
      dioAdapter.onPost(
          ApiConstant.linkCouponWithTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString()), (server) {
        server.reply(200,
            '{"termQuestions":[{"id":1,"termId":1,"title":"\u0627\u062e\u062a\u0631 \u062c\u0627\u0645\u0639\u062a\u0643","type":1,"multi_selections":[{"id":1,"title":"\u062c\u0627\u0645\u0639\u0629 \u062d\u0644\u0628","term_question_id":1},{"id":2,"title":"\u062c\u0627\u0645\u0639\u0629 \u062f\u0645\u0634\u0642","term_question_id":1}]}],"result":"success","message":""}');
      });
      Get.put(ChooseTermScreenArgument(
        coupon: coupon,
        terms: [],
        free: true,
        couponType: couponType,
      ));
      await widgetTester
          .pumpWidget(const MaterialApp(home: ChooseTermScreen()));
      await widgetTester.pump(animationDuration);
      await widgetTester.tap(find.byType(CheckTermWidget));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.pump(Duration(seconds: 30));
      expect(find.byType(TermQuestionsForm), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
    });
    testWidgets(
        'send data does not show terms questions form when no questions are recieved',
        (widgetTester) async {
      dioAdapter.onPost(
          ApiConstant.linkCouponWithTerms
              .replaceFirst('(COUPON_ID)', coupon.id.toString()), (server) {
        server.reply(200,
            '{"terms":[{"id":1,"uuid":"8c4adac26d7538aafdc06742b91c73ff","ordering":1,"name":"studiode","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","creation":"2023-02-04 19:39:27","onUpdate":"2024-02-28 15:16:23","deleted_at":null,"deleted_by":null,"enabled":1},{"id":2,"uuid":"39c4aa2edfacba7ab51ee41d11afe673","ordering":2,"name":"\u0645\u0633\u062a\u0648\u0649 \u0623\u0648\u0644","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","creation":"2023-02-11 09:28:20","onUpdate":"2024-02-28 15:19:59","deleted_at":null,"deleted_by":null,"enabled":1},{"id":3,"uuid":"96cdb4388f33aa7c9cc32cc094a8a61f","ordering":3,"name":"\u0623\u0633\u062a\u0627\u0630  \u0631\u062c\u0628-3-3","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","creation":"2023-02-11 09:28:46","onUpdate":"2024-02-13 20:27:50","deleted_at":null,"deleted_by":null,"enabled":1},{"id":12,"uuid":"2d3d2e9704b5c590671d11c69023848e","ordering":12,"name":"\u0643\u062a\u0627\u0628\u064a-12-12","type":2,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","creation":"2023-03-02 17:36:41","onUpdate":"2024-02-13 20:27:50","deleted_at":null,"deleted_by":null,"enabled":1},{"id":10,"uuid":"aaf8a58ed66271383b17f90dd497af61","ordering":10,"name":"\u0648\u062d\u062f\u0629-10-10","type":0,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","creation":"2023-03-01 20:27:44","onUpdate":"2024-02-13 20:27:50","deleted_at":null,"deleted_by":null,"enabled":1},{"id":14,"uuid":"7e2d74d5a3af8a442c012f35cd6a9943","ordering":14,"name":"\u0641\u064a\u062f\u064a\u0648-14-14","type":4,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","creation":"2023-03-06 20:30:34","onUpdate":"2024-02-13 20:27:50","deleted_at":null,"deleted_by":null,"enabled":1},{"id":18,"uuid":"e8c143a8d255d37fd911e8cc68d94fc8","ordering":18,"name":"\u062f\u0648\u0631\u0629 \u0645\u062f\u0641\u0648\u0639\u0629 \u0643\u0631\u062a\u0647\u0627 \u0635\u0627\u0644\u062d-18-18","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","creation":"2023-04-02 08:07:11","onUpdate":"2024-02-13 20:27:50","deleted_at":null,"deleted_by":null,"enabled":1},{"id":21,"uuid":"498390cf0506f6f31f288930e077a39d","ordering":21,"name":"object 3","type":3,"visible":1,"innerNote":"","outerNote":"","free":0,"captureable":0,"minimumSupportedVersion":0,"text":"","creation":"2023-04-08 12:27:38","onUpdate":"2024-02-28 20:12:21","deleted_at":null,"deleted_by":null,"enabled":0},{"id":52,"uuid":"13d0a26c18682d3e8dc751f52e7bf4f0","ordering":52,"name":"under the tree-52-52","type":6,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","creation":"2023-07-24 04:04:17","onUpdate":"2024-02-13 20:27:50","deleted_at":null,"deleted_by":null,"enabled":1},{"id":57,"uuid":"65b2c74b6cea890879e82f6a5c9289a7","ordering":57,"name":"\u0641\u064a\u062f\u064a\u0648 \u062c\u062f\u064a\u062f","type":1,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":1,"minimumSupportedVersion":0,"text":"","creation":"2024-02-28 20:13:03","onUpdate":"2024-03-04 14:57:59","deleted_at":null,"deleted_by":null,"enabled":1},{"id":58,"uuid":"706ed56b500e7254c0ff4e64073ecbe8","ordering":58,"name":"\u0641\u064a\u062f\u064a\u0648 2 \u062c\u062f\u064a\u062f","type":3,"visible":1,"innerNote":"","outerNote":"","free":1,"captureable":0,"minimumSupportedVersion":0,"text":"","creation":"2024-02-28 20:16:27","onUpdate":"2024-02-29 20:35:41","deleted_at":null,"deleted_by":null,"enabled":1},{"id":67,"uuid":"ef879a2d2cd3ff22c39bb9d0e719da39","ordering":67,"name":"\u0641\u0644\u0627\u0634","type":5,"visible":1,"innerNote":"","outerNote":"","free":0,"captureable":1,"minimumSupportedVersion":0,"text":"","creation":"2024-03-01 11:19:24","onUpdate":"2024-03-01 11:19:31","deleted_at":null,"deleted_by":null,"enabled":0}],"coupon":{"id":215,"serial":"9f186c84-04f8-a026-f8af-da6c88aa9191","ordering":1000,"type":1,"deviceId":11,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":"2024-04-28T14:24:12.965906Z","termPrintId":0,"creation":"2024-04-28 14:24:01","onUpdate":null,"coupon_type":{"id":1,"name":"\u0645\u0646\u0647\u0627\u062c \u0645\u062c\u0627\u0646\u064a","layer":1,"numberOfObjects":1,"rootTermId":-1,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[56, 30]","creation":"2021-02-15 13:53:24","onUpdate":"2024-02-28 19:36:58"}},"related-terms":[],"terms-with-questions-levelling-enabled":[{"termId":10,"creation":"2024-03-04T15:01:10.000000Z","onUpdate":"2024-03-04T15:01:10.000000Z","deleted_at":null,"deleted_by":null}],"terms-parents":[{"termId":1,"parentTermId":-1,"layer":1,"rootTermId":-1,"creation":"2023-02-04 19:39:52","onUpdate":"2023-02-04 19:43:01","deleted_at":null,"deleted_by":null},{"termId":2,"parentTermId":1,"layer":2,"rootTermId":-1,"creation":"2023-02-11 09:28:20","onUpdate":"0000-00-00 00:00:00","deleted_at":null,"deleted_by":null},{"termId":3,"parentTermId":2,"layer":3,"rootTermId":-1,"creation":"2023-02-11 09:28:46","onUpdate":"0000-00-00 00:00:00","deleted_at":null,"deleted_by":null},{"termId":10,"parentTermId":3,"layer":4,"rootTermId":-1,"creation":"2023-03-01 20:27:44","onUpdate":"0000-00-00 00:00:00","deleted_at":null,"deleted_by":null},{"termId":14,"parentTermId":10,"layer":5,"rootTermId":-1,"creation":"2023-03-06 20:30:34","onUpdate":"0000-00-00 00:00:00","deleted_at":null,"deleted_by":null},{"termId":12,"parentTermId":10,"layer":5,"rootTermId":-1,"creation":"2023-03-02 17:36:41","onUpdate":"0000-00-00 00:00:00","deleted_at":null,"deleted_by":null},{"termId":18,"parentTermId":10,"layer":5,"rootTermId":-1,"creation":"2023-04-02 08:07:11","onUpdate":"0000-00-00 00:00:00","deleted_at":null,"deleted_by":null},{"termId":21,"parentTermId":10,"layer":5,"rootTermId":-1,"creation":"2023-04-08 12:27:38","onUpdate":"0000-00-00 00:00:00","deleted_at":null,"deleted_by":null},{"termId":52,"parentTermId":10,"layer":5,"rootTermId":-1,"creation":"2023-07-24 04:04:17","onUpdate":"0000-00-00 00:00:00","deleted_at":null,"deleted_by":null},{"termId":57,"parentTermId":10,"layer":5,"rootTermId":-1,"creation":"2024-02-28 20:13:03","onUpdate":"0000-00-00 00:00:00","deleted_at":null,"deleted_by":null},{"termId":58,"parentTermId":10,"layer":5,"rootTermId":-1,"creation":"2024-02-28 20:16:27","onUpdate":"0000-00-00 00:00:00","deleted_at":null,"deleted_by":null},{"termId":67,"parentTermId":10,"layer":5,"rootTermId":-1,"creation":"2024-03-01 11:19:24","onUpdate":"0000-00-00 00:00:00","deleted_at":null,"deleted_by":null}],"terms-linked-to-tags":[{"termId":57,"tagId":1,"deleted_at":null,"deleted_by":null,"creation":"2024-03-04 14:59:36","onUpdate":"2024-03-04 14:59:36"}],"terms-tags":[{"id":1,"name":"\u0641\u064a\u062f\u064a\u0648\u0647\u0627\u062a","addNewLabel":"\u0625\u0636\u0627\u0641\u0629 \u0641\u064a\u062f\u064a\u0648 \u062c\u062f\u064a\u062f","ordering":0,"creation":"2023-02-04 16:51:42","onUpdate":"2023-02-04 16:51:22"}],"terms-linked-to-labels":[{"termId":18,"labelId":1,"deleted_at":null,"deleted_by":null,"creation":"2024-03-04 12:17:48","onUpdate":"0000-00-00 00:00:00"},{"termId":57,"labelId":1,"deleted_at":null,"deleted_by":null,"creation":"2024-03-04 12:17:48","onUpdate":"0000-00-00 00:00:00"},{"termId":10,"labelId":1,"deleted_at":null,"deleted_by":null,"creation":"2024-03-04 12:18:38","onUpdate":"0000-00-00 00:00:00"}],"terms-labels":[{"id":1,"name":"Label","creation":"2024-03-02 08:35:36","onUpdate":"2024-03-02 08:35:25"}],"result":"success","message":""}');
      });
      Get.put(ChooseTermScreenArgument(
        coupon: coupon,
        terms: [],
        free: true,
        couponType: couponType,
      ));
      await widgetTester
          .pumpWidget(const MaterialApp(home: ChooseTermScreen()));
      await widgetTester.pump(animationDuration);
      await widgetTester.tap(find.byType(CheckTermWidget));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SubmitButton));
      await widgetTester.pumpAndSettle();
      expect(find.byType(TermQuestionsForm), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
*/
}
