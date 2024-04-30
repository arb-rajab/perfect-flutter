import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/route_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/home/drawer_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  final DioAdapter dioAdapter = DioAdapter(dio: NetworkService.dio);

  dioAdapter.onGet(ApiConstant.frequentQuestions, (server) {
    server.reply(200,
        '{"frequent-questions":[{"id":1,"title":"\u0645\u0646 \u0646\u062d\u0646","description":"\u0645\u0624\u0633\u0633\u0629 \u063a\u064a\u0631 \u0631\u0628\u062d\u064a\u0629","appId":1,"creation":"2023-05-04 14:56:01"},{"id":2,"title":"\u0639\u0646\u0648\u0627\u0646\u0646\u0627 \u0627\u0644\u062c\u062f\u064a\u062f","description":"\u0627\u0644\u0645\u0632\u0629 \u0641\u064a\u0644\u0627\u062a","appId":1,"creation":"2023-05-04 14:56:17"}],"result":"success","message":""}');
  });

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

  testWidgets('contact us tile navigates to coupon screen',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      routes: routes,
      home: const Scaffold(body: ContactUsTile()),
    ));
    expect(find.byType(ContactUsScreen), findsNothing);
    await widgetTester.tap(find.byType(ContactUsTile));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ContactUsScreen), findsOneWidget);
  });

  testWidgets(
      'frequent asked questions tile navigates to frequent asked questions screen',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      routes: routes,
      home: const Scaffold(body: FrequestQuestionsTile()),
    ));
    expect(find.byType(FrequentQuestionsScreen), findsNothing);
    await widgetTester.tap(find.byType(FrequestQuestionsTile));
    await widgetTester.pumpAndSettle();

    expect(find.byType(FrequentQuestionsScreen), findsOneWidget);
  });

  testWidgets('whats new tile shows whats new dialogue', (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      routes: routes,
      home: const Scaffold(body: WhatsNewTile()),
    ));
    expect(find.byType(WhatsNewDialogue), findsNothing);
    await widgetTester.tap(find.byType(WhatsNewTile));
    await widgetTester.pumpAndSettle();

    expect(find.byType(WhatsNewDialogue), findsOneWidget);
  });
}
