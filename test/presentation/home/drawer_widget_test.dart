import 'package:beta/application/services/database_service.dart';
import 'package:beta/configs/app.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/home/drawer_widget.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future<void> main() async {
  await initTests();

  tearDown(() async {
    DatabaseService databaseService = Get.find();
    for (var table in databaseService.allTables) {
      await table.deleteAll();
    }
  });

  group('rendering widgets tests', () {
    testWidgets('logo is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        child: DrawerWidget(),
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(NoBackgroundLogo), findsOneWidget);
    });

    testWidgets('coupons tile is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        child: DrawerWidget(),
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(CouponsTile), findsOneWidget);
    });

    testWidgets('import backup tile is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        child: DrawerWidget(),
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ImportBackupTile), findsOneWidget);
    });

    testWidgets('export backup tile is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        child: DrawerWidget(),
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ExportBackupTile), findsOneWidget);
    });

    testWidgets('contact us tile is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        child: DrawerWidget(),
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.scrollUntilVisible(find.byType(ContactUsTile), 100);
      expect(find.byType(ContactUsTile), findsOneWidget);
    });

    testWidgets('frequent questions tile is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        child: DrawerWidget(),
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.scrollUntilVisible(
          find.byType(FrequestQuestionsTile), 100);
      expect(find.byType(FrequestQuestionsTile), findsOneWidget);
    });

    testWidgets('whats new tile is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        child: DrawerWidget(),
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.scrollUntilVisible(find.byType(WhatsNewTile), 100);
      expect(find.byType(WhatsNewTile), findsOneWidget);
    });
  });

  testWidgets('coupons tile navigates to coupon screen', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byIcon(Icons.menu));
    await widgetTester.pumpAndSettle();
    expect(find.byType(CouponsScreen), findsNothing);
    await widgetTester.tap(find.byType(CouponsTile));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CouponsScreen), findsOneWidget);

    await widgetTester.dragFrom(const Offset(300, 300), const Offset(-300, 0));
    await widgetTester.pumpAndSettle();
  });

  testWidgets('contact us tile navigates to coupon screen',
      (widgetTester) async {
    widgetTester.view.physicalSize = testSizes['desktop']!;
    widgetTester.view.devicePixelRatio = 1;
    addTearDown(widgetTester.view.resetPhysicalSize);
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byIcon(Icons.menu));
    await widgetTester.pumpAndSettle();
    expect(find.byType(ContactUsScreen), findsNothing);
    await widgetTester.tap(find.byType(ContactUsTile));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ContactUsScreen), findsOneWidget);
  });

  testWidgets(
      'frequent asked questions tile navigates to frequent asked questions screen',
      (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byIcon(Icons.menu));
    await widgetTester.pumpAndSettle();
    expect(find.byType(FrequentQuestionsScreen), findsNothing);
    // await widgetTester.scrollUntilVisible(
    //     find.byType(FrequestQuestionsTile), 100);
    await widgetTester.tap(find.byType(FrequestQuestionsTile));
    await widgetTester.pumpAndSettle();

    expect(find.byType(FrequentQuestionsScreen), findsOneWidget);
  });

  testWidgets('whats new tile shows whats new dialogue', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byIcon(Icons.menu));
    await widgetTester.pumpAndSettle();
    expect(find.byType(WhatsNewDialogue), findsNothing);
    // await widgetTester.scrollUntilVisible(find.byType(WhatsNewTile), 100);
    await widgetTester.tap(find.byType(WhatsNewTile));
    await widgetTester.pumpAndSettle();

    expect(find.byType(WhatsNewDialogue), findsOneWidget);
  });

  group('whats new dialogue tests', () {
    testWidgets('whats new in version text is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        child: WhatsNewDialogue(),
      ));
      await widgetTester.pumpAndSettle();
      expect(find.textContaining(StringConstant.whatsNewInVersion),
          findsOneWidget);
    });

    // testWidgets('version name text is rendered', (widgetTester) async {
    //   await widgetTester.pumpWidget(const MyApp(
    //     child: WhatsNewDialogue(),
    //   ));
    //   await widgetTester.pumpAndSettle();
    //   String versionName = Get.find<PackageRepository>().getVersionName();
    //   expect(find.textContaining(versionName), findsOneWidget);
    // });

    testWidgets('new features text is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        child: WhatsNewDialogue(),
      ));
      await widgetTester.pumpAndSettle();
      for (String feature in newFeatures) {
        expect(find.textContaining(feature), findsOneWidget);
      }
    });

    testWidgets('ok button is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        child: WhatsNewDialogue(),
      ));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.ok), findsOneWidget);
    });

    testWidgets('ok button click pops the dialogue', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byIcon(Icons.menu));
      await widgetTester.pumpAndSettle();
      expect(find.byType(WhatsNewDialogue), findsNothing);
      // await widgetTester.scrollUntilVisible(find.byType(WhatsNewTile), 100);
      await widgetTester.tap(find.byType(WhatsNewTile));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.text(StringConstant.ok));
      await widgetTester.pumpAndSettle();

      expect(find.byType(WhatsNewDialogue), findsNothing);
    });
  });
}
