import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/coupon_type.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/layer.dart';
import 'package:beta/domain/value/number_of_objects.dart';
import 'package:beta/domain/value/path.dart';
import 'package:beta/domain/value/root_term_id.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/choose_term/check_term_widget.dart';
import 'package:beta/presentation/choose_term/choose_term_screen.dart';
import 'package:beta/presentation/choose_term/choose_term_screen_controller.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:easy_localization/easy_localization.dart';
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

  testWidgets('confirmation dialogue widget displays checked term',
      (widgetTester) async {
    Get.put(ChooseTermScreenArgument(
      coupon: coupon,
      terms: [],
      free: false,
      couponType: couponType,
    ));
    await widgetTester.pumpWidget(const MaterialApp(home: ChooseTermScreen()));
    await widgetTester.pump(animationDuration);
    ChooseTermScreenController controller = Get.find();
    String termName = 'random name';
    Path path = const Path('termPath');
    controller.checkedTerms = [
      TermData(
          Term(
            id: 1,
            uuid: 'uuid',
            name: termName,
            type: 1,
            creation: DateTime.now(),
            enabled: 1,
            free: 0,
            ordering: 1,
            needsUpdate: 0,
            captureable: 1,
            textCulumn: '',
          ),
          path: path)
    ];
    await widgetTester
        .pumpWidget(const MaterialApp(home: ConfirmationDialogueWidget()));
    await widgetTester.pump(animationDuration);
    expect(
        find.textContaining(path.value!, findRichText: true), findsOneWidget);
    expect(find.textContaining(termName, findRichText: true), findsOneWidget);

    // await widgetTester.tap(find.text(StringConstant.ok.tr()));
    // await widgetTester.pumpAndSettle();
    // expect(find.byType(ConfirmationDialogueWidget), findsNothing);
  });

  testWidgets('confirmation dialogue is dismissed when ok is clicked',
      (widgetTester) async {
    Get.put(ChooseTermScreenArgument(
      coupon: coupon,
      terms: [],
      free: false,
      couponType: couponType,
    ));
    await widgetTester.pumpWidget(const MaterialApp(home: ChooseTermScreen()));
    await widgetTester.pump(animationDuration);
    await widgetTester.tap(find.byType(CheckTermWidget));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byType(SubmitButton));
    await widgetTester.pumpAndSettle();
    await widgetTester
        .tap(find.widgetWithText(TextButton, StringConstant.ok.tr()));
    await widgetTester.pumpAndSettle();
    expect(find.byType(ConfirmationDialogueWidget), findsNothing);
  });
}
