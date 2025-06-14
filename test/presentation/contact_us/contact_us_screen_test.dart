import 'package:beta/configs/links.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/url_launcher_repository.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() {
  setUp(() async {
    await initTests();
  });

  // dioAdapter.onGet(ApiConstant.frequentQuestions, (server) {
  //   server.reply(200,
  //       '{"frequent-questions":[{"id":1,"title":"\u0645\u0646 \u0646\u062d\u0646","description":"\u0645\u0624\u0633\u0633\u0629 \u063a\u064a\u0631 \u0631\u0628\u062d\u064a\u0629","appId":1,"creation":"2023-05-04 14:56:01"},{"id":2,"title":"\u0639\u0646\u0648\u0627\u0646\u0646\u0627 \u0627\u0644\u062c\u062f\u064a\u062f","description":"\u0627\u0644\u0645\u0632\u0629 \u0641\u064a\u0644\u0627\u062a","appId":1,"creation":"2023-05-04 14:56:17"}],"result":"success","message":""}');
  // });

  group('rendering tests', () {
    testWidgets('screen title is rendered', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, StringConstant.contactUs),
          findsOneWidget);
    });

    testWidgets('frequent questions tile is rendered', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(FrequesntQuestionsTile), findsOneWidget);
    });

    testWidgets(
        'telegram channel tile is rendered if telegram link is not empty',
        (widgetTester) async {
      telegramChannelLink = 'some link';
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(TelegramChannelTile), findsOneWidget);
    });

    testWidgets(
        'telegram channel tile is not rendered if telegram link is empty',
        (widgetTester) async {
      telegramChannelLink = '';
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(TelegramChannelTile), findsNothing);
    });

    testWidgets('telegram chat tile is rendered if link is not empty',
        (widgetTester) async {
      telegramChatLink = 'some link';
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(TelegramChatTile), findsOneWidget);
    });

    testWidgets('telegram chat tile is not rendered if link is empty',
        (widgetTester) async {
      telegramChatLink = '';
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(TelegramChatTile), findsNothing);
    });

    testWidgets('facebook page tile is rendered if link is not empty',
        (widgetTester) async {
      facebookPageLink = 'some link';
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(FacebookPageTile), findsOneWidget);
    });

    testWidgets('facebook page tile is not rendered if link is empty',
        (widgetTester) async {
      facebookPageLink = '';
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(FacebookPageTile), findsNothing);
    });
  });

  group('frequent questions tile tests', () {
    testWidgets('title is rendered', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.text(FrequentQuestionsScreen.title), findsOneWidget);
    });

    testWidgets('subtitle is rendered', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.frequentlyAskedQuestionsExplanation),
          findsOneWidget);
    });

    testWidgets('tapping opens frequent questions screen',
        (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byType(FrequesntQuestionsTile));
      await widgetTester.pumpAndSettle();

      expect(find.byType(FrequentQuestionsScreen), findsOneWidget);
    });
  });

  group('telegram channel tile tests', () {
    setUpAll(() => telegramChannelLink = 'some link');
    testWidgets('title is rendered', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.telegram), findsOneWidget);
    });

    testWidgets('subtitle is rendered', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.telegramExplanation), findsOneWidget);
    });

    testWidgets('tapping opens telegram channel link', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byType(TelegramChannelTile));
      await widgetTester.pumpAndSettle();

      UrlLauncherRepository urlLauncherRepository = Get.find();
      expect(urlLauncherRepository.openedUrl, telegramChannelLink);
    });
  });

  group('telegram chat tile tests', () {
    setUpAll(() => telegramChatLink = 'some link');
    testWidgets('title is rendered', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.widgetWithText(TelegramChatTile, StringConstant.telegram),
          findsOneWidget);
    });

    testWidgets('subtitle is rendered', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(
          find.widgetWithText(
              TelegramChatTile, StringConstant.telegramChatExplanation),
          findsOneWidget);
    });

    testWidgets('tapping opens telegram chat link', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byType(TelegramChatTile));
      await widgetTester.pumpAndSettle();

      UrlLauncherRepository urlLauncherRepository = Get.find();
      expect(urlLauncherRepository.openedUrl, telegramChatLink);
    });
  });

  group('facebook page tile tests', () {
    setUpAll(() => facebookPageLink = 'some link');
    testWidgets('title is rendered', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.widgetWithText(FacebookPageTile, StringConstant.facebook),
          findsOneWidget);
    });

    testWidgets('subtitle is rendered', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();
      expect(
          find.widgetWithText(
              FacebookPageTile, StringConstant.facebookExplanation),
          findsOneWidget);
    });

    testWidgets('tapping opens facebook page link', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: ContactUsScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byType(FacebookPageTile));
      await widgetTester.pumpAndSettle();

      UrlLauncherRepository urlLauncherRepository = Get.find();
      expect(urlLauncherRepository.openedUrl, facebookPageLink);
    });
  });
}
