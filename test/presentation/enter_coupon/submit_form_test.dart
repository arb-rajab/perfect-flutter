import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/choose_term/choose_term_screen.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/enter_coupon/submit_form.dart';
import 'package:beta/presentation/widgets/form_message_widget.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

Future<void> main() async {
  MainController.testing = true;
  TestWidgetsFlutterBinding.ensureInitialized();
  await MainController.initServices();
  final DioAdapter dioAdapter = DioAdapter(dio: NetworkService.dio);

  group('rendering tests', () {
    testWidgets('enter name text field is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(EnterNameInput), findsOneWidget);
    });

    testWidgets('enter coupon text field is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(EnterCouponInput), findsOneWidget);
    });

    testWidgets('`or you can instead` text is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.youCanInstead), findsOneWidget);
    });
  });

  group('ok button tests', () {
    testWidgets('ok button is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(
          find.widgetWithText(SubmitButton, StringConstant.ok), findsOneWidget);
    });

    testWidgets('name input can not be empty', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester
          .tap(find.widgetWithText(SubmitButton, StringConstant.ok));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.pleaseFillThisField), findsOneWidget);
    });

    testWidgets('coupon input can not be empty', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(EnterNameInput), 'Random name');
      await widgetTester
          .tap(find.widgetWithText(SubmitButton, StringConstant.ok));
      await widgetTester.pumpAndSettle();
      expect(find.textContaining(StringConstant.pleaseFillThisField),
          findsOneWidget);
    });

    testWidgets('coupon input must match md5', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(EnterNameInput), 'Random name');
      await widgetTester.enterText(
          find.byType(EnterCouponInput), 'Random coupon');
      await widgetTester
          .tap(find.widgetWithText(SubmitButton, StringConstant.ok));
      await widgetTester.pumpAndSettle();
      expect(find.textContaining(StringConstant.notValidMD5Format),
          findsOneWidget);
    });

    testWidgets('message is shown when recieving message from server',
        (widgetTester) async {
      String coupon = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';
      String message = 'a random message';
      String randomName = 'Random name';
      dioAdapter.onPost(
          ApiConstant.checkCoupon.replaceAll(
            '(SERIAL)',
            coupon,
          ), (server) {
        server.reply(200, '{"result":"failed","code":1,"message":"$message"}');
      }, data: FormData.fromMap({'name': randomName}));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(EnterNameInput), randomName);
      await widgetTester.enterText(find.byType(EnterCouponInput), coupon);
      await widgetTester
          .tap(find.widgetWithText(SubmitButton, StringConstant.ok));
      await widgetTester.pumpAndSettle();
      expect(find.widgetWithText(FormMessageWidget, message), findsOneWidget);
    });

    testWidgets('navigaion to choose term screen when data recieved',
        (widgetTester) async {
      String coupon = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';
      String randomName = 'Random name';
      dioAdapter.onPost(
          ApiConstant.checkCoupon.replaceAll(
            '(SERIAL)',
            coupon,
          ), (server) {
        String response = r'''
        {"coupon":{"id":10121738,"serial":"abdb8c99-73c0-5e47-6825-edfa24e871c3","ordering":1000,"type":10000033,"deviceId":10027871,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-1603:51:30","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027871,"result":"success","message":""}''';
        server.reply(200, response);
      }, data: FormData.fromMap({'name': randomName}));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(EnterNameInput), randomName);
      await widgetTester.enterText(find.byType(EnterCouponInput), coupon);
      await widgetTester
          .tap(find.widgetWithText(SubmitButton, StringConstant.ok));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ChooseTermScreen), findsOneWidget);
    });

    testWidgets('no connection message is shown when there is no connection',
        (widgetTester) async {
      String coupon = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';
      String randomName = 'Random name';
      dioAdapter.onPost(
          ApiConstant.checkCoupon.replaceAll(
            '(SERIAL)',
            coupon,
          ), (server) {
        server.throws(
            200,
            DioException.connectionError(
                requestOptions: RequestOptions(), reason: 'no connection'));
      }, data: FormData.fromMap({'name': randomName}));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(EnterNameInput), randomName);
      await widgetTester.enterText(find.byType(EnterCouponInput), coupon);
      await widgetTester
          .tap(find.widgetWithText(SubmitButton, StringConstant.ok));
      await widgetTester.pumpAndSettle();
      expect(
          find.widgetWithText(FormMessageWidget, StringConstant.noConnection),
          findsOneWidget);
    });
  });

  group('activate free version button tests', () {
    testWidgets('activate free version button is rendered',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(
          find.widgetWithText(SubmitButton, StringConstant.activateFreeVersion),
          findsOneWidget);
    });

    testWidgets('name input can not be empty', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.widgetWithText(
          SubmitButton, StringConstant.activateFreeVersion));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.pleaseFillThisField), findsOneWidget);
    });

    testWidgets('message is shown when recieving message from server',
        (widgetTester) async {
      String coupon = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';
      String message = 'a random message';
      String randomName = 'Random name';
      dioAdapter.onPost(ApiConstant.activateFreeVersion, (server) {
        server.reply(200, '{"result":"failed","code":1,"message":"$message"}');
      }, data: FormData.fromMap({'name': randomName}));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(EnterNameInput), randomName);
      await widgetTester.enterText(find.byType(EnterCouponInput), coupon);
      await widgetTester.tap(find.widgetWithText(
          SubmitButton, StringConstant.activateFreeVersion));
      await widgetTester.pumpAndSettle();
      expect(find.widgetWithText(FormMessageWidget, message), findsOneWidget);
    });

    testWidgets('navigaion to choose term screen when data recieved',
        (widgetTester) async {
      String randomName = 'Random name';
      dioAdapter.onPost(ApiConstant.activateFreeVersion, (server) {
        String response = r'''
        {"coupon":{"id":10121738,"serial":"abdb8c99-73c0-5e47-6825-edfa24e871c3","ordering":1000,"type":10000033,"deviceId":10027871,"used":1,"prePaid":0,"free":1,"price":0,"logId":0,"note":null,"expirationDays":-1,"activationDate":null,"termPrintId":0,"creation":"2025-04-1603:51:30","onUpdate":null,"coupon_type":{"id":10000033,"name":"\u0643\u062a\u0644\u0629 \u0645\u062c\u0627\u0646\u064a\u0629\u0644\u0641\u0631\u064a\u0642MRI","layer":2,"numberOfObjects":1,"rootTermId":9999988,"defaultExpirationDays":730,"allowedTermsTags":"[0]","excludedTerms":"[]","creation":"2023-02-27 18:14:36","onUpdate":"2024-01-01 10:38:39"}},"terms":[],"deviceId":10027871,"result":"success","message":""}''';
        server.reply(200, response);
      }, data: FormData.fromMap({'name': randomName}));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(EnterNameInput), randomName);
      await widgetTester.tap(find.widgetWithText(
          SubmitButton, StringConstant.activateFreeVersion));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ChooseTermScreen), findsOneWidget);
    });

    testWidgets('no connection message is shown when there is no connection',
        (widgetTester) async {
      String coupon = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';
      String randomName = 'Random name';
      dioAdapter.onPost(ApiConstant.activateFreeVersion, (server) {
        server.throws(
            200,
            DioException.connectionError(
                requestOptions: RequestOptions(), reason: 'no connection'));
      }, data: FormData.fromMap({'name': randomName}));
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(EnterNameInput), randomName);
      await widgetTester.enterText(find.byType(EnterCouponInput), coupon);
      await widgetTester.tap(find.widgetWithText(
          SubmitButton, StringConstant.activateFreeVersion));
      await widgetTester.pumpAndSettle();
      expect(
          find.widgetWithText(FormMessageWidget, StringConstant.noConnection),
          findsOneWidget);
    });
  });

  group('`do you need help` button tests', () {
    testWidgets('`do you need help` button is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(DoYouNeedHelp), findsOneWidget);
    });

    testWidgets('`do you need help` button navicates to contact us screen',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.tap(find.byType(DoYouNeedHelp));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ContactUsScreen), findsOneWidget);
    });
  });
}
