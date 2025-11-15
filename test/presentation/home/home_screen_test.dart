import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/configs/app.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen_controller.dart';
import 'package:beta/presentation/home/browse_terms_tab.dart';
import 'package:beta/presentation/home/drawer_widget.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/new_terms_tab.dart';
import 'package:beta/presentation/home/news_tab.dart';
import 'package:beta/presentation/home/recent_terms_tab.dart';
import 'package:beta/presentation/home/store_tab.dart';
import 'package:beta/presentation/home/unstudied_terms_tab.dart';
import 'package:beta/presentation/home/favorite_terms_tab.dart';
import 'package:beta/presentation/home/updateable_terms_tab.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

import '../../common/tests.dart';

void main() async {
  await initTests();

  void mockRefreshSucceed() {
    dioAdapter.onGet(ApiConstant.getTermsUpdates, (server) {
      server.reply(
        200,
        r'''{"updated-terms":[],"refreshed-terms-ids":[],"related-terms":[],"terms-with-questions-levelling-enabled":[],"terms-parents":[],"terms-linked-to-tags":[],"terms-tags":[],"terms-linked-to-labels":[],"terms-labels":[],"result":"success","message":""}''',
      );
    });
  }

  group('app bar widgets tests', () {
    group('refresh icon tests', () {
      testWidgets('refresh icon is not visible when app starts',
          (widgetTester) async {
        mockRefreshSucceed();
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pump();
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byIcon(Icons.refresh), findsNothing);
        await widgetTester.pumpAndSettle();
      });

      testWidgets('refresh icon is visible after loading succeed',
          (widgetTester) async {
        mockRefreshSucceed();
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pump(const Duration(milliseconds: 500));
        expect(
            find.text(StringConstant.dataLoadedSuccessfully), findsOneWidget);
        await widgetTester.pumpAndSettle();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byIcon(Icons.refresh), findsOneWidget);
      });

      testWidgets('error icon is visible after loading is failed',
          (widgetTester) async {
        mockNoConnection(route: ApiConstant.getTermsUpdates);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byIcon(Icons.refresh), findsNothing);
        expect(find.byIcon(Icons.warning), findsOneWidget);
        await widgetTester.pumpAndSettle(const Duration(seconds: 3));
      });

      testWidgets('tapping refresh icon shows loading', (widgetTester) async {
        mockRefreshSucceed();
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byIcon(Icons.refresh));
        await widgetTester.pump();
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byIcon(Icons.refresh), findsNothing);
        await widgetTester.pumpAndSettle();
      });

      testWidgets('tapping refresh shows refresh icon when data recieved',
          (widgetTester) async {
        mockRefreshSucceed();
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byIcon(Icons.refresh));
        await widgetTester.pump(const Duration(milliseconds: 500));
        expect(
            find.text(StringConstant.dataLoadedSuccessfully), findsOneWidget);
        await widgetTester.pumpAndSettle();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byIcon(Icons.refresh), findsOneWidget);
      });

      testWidgets('error icon is visible after loading is failed after tapping',
          (widgetTester) async {
        mockNoConnection(route: ApiConstant.getTermsUpdates);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byIcon(Icons.warning));
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byIcon(Icons.refresh), findsNothing);
        expect(find.byIcon(Icons.warning), findsOneWidget);
        await widgetTester.pumpAndSettle(const Duration(seconds: 3));
      });

      testWidgets('refresh icon is not visible when navigated to store tab',
          (widgetTester) async {
        mockRefreshSucceed();
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        expect(find.byIcon(Icons.refresh), findsNothing);
      });

      testWidgets('refresh icon is not visible when navigated to news tab',
          (widgetTester) async {
        mockRefreshSucceed();
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        expect(find.byIcon(Icons.refresh), findsNothing);
      });

      testWidgets(
          'refresh icon is  visible when turn back to educational tab after switching to store tab',
          (widgetTester) async {
        mockRefreshSucceed();
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.byIcon(Icons.refresh), findsOneWidget);
      });

      testWidgets(
          'refresh icon is  visible when turn back to educational tab after switching to news tab',
          (widgetTester) async {
        mockRefreshSucceed();
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.byIcon(Icons.refresh), findsOneWidget);
      });
    });

    group('notifications icon tests', () {
      testWidgets('notifications icon is rendered', (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        expect(find.byIcon(Icons.notifications), findsOneWidget);
      });

      testWidgets('notifications icon tap opens notifications screen',
          (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byIcon(Icons.notifications));
        await widgetTester.pumpAndSettle();
        expect(find.byType(NotificationsScreen), findsOneWidget);
      });
    });

    group('settings icon tests', () {
      testWidgets('settings icon is rendered', (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        expect(find.byIcon(Icons.settings), findsOneWidget);
      });

      testWidgets('settings icon tap opens settings screen',
          (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byIcon(Icons.settings));
        await widgetTester.pumpAndSettle();
        expect(find.byType(SettingsScreen), findsOneWidget);
      });
    });
  });

  group('drawwer tests', () {
    testWidgets('hamburger icon is rendered', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      // Check if Scaffold has a drawer
      Scaffold scaffold = widgetTester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.drawer, isNotNull); // Ensure drawer exists

      // Check if hamburger icon (IconButton with Icons.menu) is present
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('hamburger icon tapping shows drawer', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byIcon(Icons.menu));
      await widgetTester.pumpAndSettle();
      expect(find.byType(DrawerWidget), findsOneWidget);
    });

    testWidgets('Dragging from left edge opens the drawer',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await tester.pumpAndSettle();

      // Initially, drawer should be closed
      expect(find.byType(DrawerWidget), findsNothing);

      // Simulate a drag from the left edge to open the drawer
      await tester.dragFrom(const Offset(0, 300), const Offset(300, 300));
      await tester.pumpAndSettle(); // Wait for animations

      // Verify drawer is now open
      expect(find.byType(DrawerWidget), findsOneWidget);
    });

    testWidgets('Dragging drawer to the left closes it',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await tester.pumpAndSettle();

      // Open the drawer first (via icon or swipe)
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      expect(find.byType(DrawerWidget), findsOneWidget);

      // Simulate a drag to the left to close the drawer
      await tester.dragFrom(const Offset(300, 300), const Offset(-300, 0));
      await tester.pumpAndSettle();

      // Verify drawer is now closed
      expect(find.byType(DrawerWidget), findsNothing);
    });
  });

  group('add coupon fab tests', () {
    testWidgets('add coupon fab is rendered', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.text(EnterCouponScreen.title), findsOneWidget);
    });

    testWidgets('add coupon fab tap opens enter coupon screen',
        (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text(EnterCouponScreen.title));
      await widgetTester.pumpAndSettle();
      expect(find.byType(EnterCouponScreen), findsOneWidget);
    });

    testWidgets(
        'add coupon fab refreshed data after successfully adding a coupon',
        (widgetTester) async {
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      TermService termService = Get.find();
      TermsParentService termsParentService = Get.find();

      //opens enter coupon screen
      await widgetTester.tap(find.text(EnterCouponScreen.title));
      await widgetTester.pumpAndSettle();

      await termService.addTerms([
        TermData(
            const Term(
                name: 'parent',
                enabled: 1,
                id: 1,
                uuid: 'a',
                type: 0,
                creation: '2022-01-01 11:11:11',
                free: 1,
                ordering: 1,
                needsUpdate: 0,
                captureable: 1,
                textCulumn: '',
                outerNote: ''),
            deletedAt: const DeletedAt(null),
            visible: const Visible(1)),
        TermData(
            const Term(
                name: 'child',
                enabled: 1,
                id: 2,
                uuid: 'a',
                type: 0,
                creation: '2022-01-01 11:11:11',
                free: 1,
                ordering: 1,
                needsUpdate: 0,
                captureable: 1,
                textCulumn: '',
                outerNote: ''),
            deletedAt: const DeletedAt(null),
            visible: const Visible(1)),
      ]);
      await termsParentService.addTermsParents([
        TermsParentData(
            const TermsParent(
                termId: 1,
                parentTermId: -1,
                rootTermId: -1,
                creation: '2024-01-01 13:13:13'),
            deletedAt: const DeletedAt(null)),
        TermsParentData(
            const TermsParent(
                termId: 2,
                parentTermId: 1,
                rootTermId: -1,
                creation: '2024-01-01 13:13:13'),
            deletedAt: const DeletedAt(null))
      ]);

      EnterCouponScreenController controller = Get.find();
      controller.state.context.pop();
      await widgetTester.pumpAndSettle();

      expect(find.text('parent'), findsOneWidget);
      expect(find.text('child'), findsNothing);
    });
  });

  group('tabs tests', () {
    group('educational content tabs are visible by default', () {
      testWidgets('browse terms tab is rendered', (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.browseTerms), findsOneWidget);
      });

      testWidgets('rececnt terms tab is rendered', (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.recentTerms), findsOneWidget);
      });

      testWidgets('new terms tab is rendered', (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.newTerms), findsOneWidget);
      });

      testWidgets('unstudied terms tab is rendered', (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.unstudied), findsOneWidget);
      });

      testWidgets('favorite terms tab is rendered', (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.favorite), findsOneWidget);
      });

      testWidgets('updateable terms tab is rendered', (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.updateable), findsOneWidget);
      });
    });

    group(
        'educational content tabs are not visible when switching to the another page',
        () {
      testWidgets(
          'browse terms tab is not rendered when navigating to stores tab',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.browseTerms), findsNothing);
      });

      testWidgets(
          'browse terms tab is not rendered when navigating to news tab',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.browseTerms), findsNothing);
      });

      testWidgets(
          'rececnt terms tab is not rendered when navigating to stores tab',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.recentTerms), findsNothing);
      });

      testWidgets(
          'rececnt terms tab is not rendered when navigating to news tab',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.recentTerms), findsNothing);
      });

      testWidgets('new terms tab is not rendered when navigating to store tab',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.newTerms), findsNothing);
      });

      testWidgets('new terms tab is not rendered when navigating to news tab',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.newTerms), findsNothing);
      });

      testWidgets(
          'unstudied terms tab is not rendered when navigating to store tab',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.unstudied), findsNothing);
      });

      testWidgets(
          'favorite terms tab is not rendered when navigating to store tab',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.favorite), findsNothing);
      });

      testWidgets(
          'unstudied terms tab is not rendered when navigating to news tab',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.unstudied), findsNothing);
      });

      testWidgets(
          'favorite terms tab is not rendered when navigating to news tab',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.favorite), findsNothing);
      });

      testWidgets(
          'updateable terms tab is not rendered when navigating to store tab',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.updateable), findsNothing);
      });

      testWidgets(
          'updateable terms tab is not rendered when navigating to news tab',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.updateable), findsNothing);
      });
    });

    group(
        'educational content tabs are visible when switching to the educational content after switching to another page',
        () {
      testWidgets(
          'browse terms tab is rendered after switching from store page',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.browseTerms), findsOneWidget);
      });

      testWidgets('browse terms tab is rendered after switching from news page',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.browseTerms), findsOneWidget);
      });

      testWidgets(
          'rececnt terms tab is rendered after switching from store page',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.recentTerms), findsOneWidget);
      });

      testWidgets(
          'rececnt terms tab is rendered after switching from news page',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.recentTerms), findsOneWidget);
      });

      testWidgets(
          'new terms tab is not rendered when switching from store page',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.newTerms), findsOneWidget);
      });

      testWidgets('new terms tab is not rendered when switching from news page',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.newTerms), findsOneWidget);
      });

      testWidgets(
          'unstudied terms tab is not rendered after switching from store page',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.unstudied), findsOneWidget);
      });

      testWidgets(
          'favorite terms tab is not rendered after switching from store page',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.favorite), findsOneWidget);
      });

      testWidgets(
          'unstudied terms tab is not rendered after switching from news page',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.unstudied), findsOneWidget);
      });

      testWidgets(
          'favorite terms tab is not rendered after switching from news page',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.favorite), findsOneWidget);
      });

      testWidgets(
          'updateable terms tab is not rendered after switching from store page',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.updateable), findsOneWidget);
      });

      testWidgets(
          'updateable terms tab is not rendered after switching from news page',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.text(StringConstant.updateable), findsOneWidget);
      });
    });

    group('tabs headers clicking tests', () {
      testWidgets('browse terms tab page rendered by default',
          (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        expect(find.byType(BrowseTermsTab), findsOneWidget);
        expect(find.byType(RecentTermsTab), findsNothing);
        expect(find.byType(NewTermsTab), findsNothing);
        expect(find.byType(UnstudiedTermsTab), findsNothing);
        expect(find.byType(FavoriteTermsTab), findsNothing);
        expect(find.byType(UpdateableTermsTab), findsNothing);
        expect(find.byType(StoreTab), findsNothing);
        expect(find.byType(NewsTab), findsNothing);
      });

      testWidgets('recent terms tab page is rendered once tab is clicked',
          (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.recentTerms));
        await widgetTester.pumpAndSettle();
        expect(find.byType(BrowseTermsTab), findsNothing);
        expect(find.byType(RecentTermsTab), findsOneWidget);
        expect(find.byType(NewTermsTab), findsNothing);
        expect(find.byType(UnstudiedTermsTab), findsNothing);
        expect(find.byType(FavoriteTermsTab), findsNothing);
        expect(find.byType(UpdateableTermsTab), findsNothing);
        expect(find.byType(StoreTab), findsNothing);
        expect(find.byType(NewsTab), findsNothing);
      });

      testWidgets('new terms tab page is rendered once tab is clicked',
          (widgetTester) async {
        widgetTester.view.physicalSize = testSizes['desktop']!;
        widgetTester.view.devicePixelRatio = 1;
        addTearDown(widgetTester.view.resetPhysicalSize);
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.newTerms));
        await widgetTester.pumpAndSettle();
        expect(find.byType(BrowseTermsTab), findsNothing);
        expect(find.byType(RecentTermsTab), findsNothing);
        expect(find.byType(NewTermsTab), findsOneWidget);
        expect(find.byType(UnstudiedTermsTab), findsNothing);
        expect(find.byType(FavoriteTermsTab), findsNothing);
        expect(find.byType(UpdateableTermsTab), findsNothing);
        expect(find.byType(StoreTab), findsNothing);
        expect(find.byType(NewsTab), findsNothing);
      });

      testWidgets('unstudied terms tab page is rendered once tab is clicked',
          (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.unstudied));
        await widgetTester.pumpAndSettle();
        expect(find.byType(BrowseTermsTab), findsNothing);
        expect(find.byType(RecentTermsTab), findsNothing);
        expect(find.byType(NewTermsTab), findsNothing);
        expect(find.byType(UnstudiedTermsTab), findsOneWidget);
        expect(find.byType(FavoriteTermsTab), findsNothing);
        expect(find.byType(UpdateableTermsTab), findsNothing);
        expect(find.byType(StoreTab), findsNothing);
        expect(find.byType(NewsTab), findsNothing);
      });

      testWidgets('favorite terms tab page is rendered once tab is clicked',
          (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.favorite));
        await widgetTester.pumpAndSettle();
        expect(find.byType(BrowseTermsTab), findsNothing);
        expect(find.byType(RecentTermsTab), findsNothing);
        expect(find.byType(NewTermsTab), findsNothing);
        expect(find.byType(UnstudiedTermsTab), findsNothing);
        expect(find.byType(FavoriteTermsTab), findsOneWidget);
        expect(find.byType(UpdateableTermsTab), findsNothing);
        expect(find.byType(StoreTab), findsNothing);
        expect(find.byType(NewsTab), findsNothing);
      });

      testWidgets('updateable terms tab page is rendered once tab is clicked',
          (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.updateable));
        await widgetTester.pumpAndSettle();
        expect(find.byType(BrowseTermsTab), findsNothing);
        expect(find.byType(RecentTermsTab), findsNothing);
        expect(find.byType(NewTermsTab), findsNothing);
        expect(find.byType(UnstudiedTermsTab), findsNothing);
        expect(find.byType(FavoriteTermsTab), findsNothing);
        expect(find.byType(UpdateableTermsTab), findsOneWidget);
        expect(find.byType(StoreTab), findsNothing);
        expect(find.byType(NewsTab), findsNothing);
      });

      testWidgets('store page is rendered once bottom navigation is clicked',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        expect(find.byType(BrowseTermsTab), findsNothing);
        expect(find.byType(RecentTermsTab), findsNothing);
        expect(find.byType(NewTermsTab), findsNothing);
        expect(find.byType(UnstudiedTermsTab), findsNothing);
        expect(find.byType(FavoriteTermsTab), findsNothing);
        expect(find.byType(UpdateableTermsTab), findsNothing);
        expect(find.byType(StoreTab), findsOneWidget);
        expect(find.byType(NewsTab), findsNothing);
      });

      testWidgets('news page is rendered once bottom navigation is clicked',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        expect(find.byType(BrowseTermsTab), findsNothing);
        expect(find.byType(RecentTermsTab), findsNothing);
        expect(find.byType(NewTermsTab), findsNothing);
        expect(find.byType(UnstudiedTermsTab), findsNothing);
        expect(find.byType(FavoriteTermsTab), findsNothing);
        expect(find.byType(UpdateableTermsTab), findsNothing);
        expect(find.byType(NewsTab), findsOneWidget);
        expect(find.byType(StoreTab), findsNothing);
      });

      testWidgets(
          'browse terms tab page is rendered once changed back to educational content tab from store page',
          (widgetTester) async {
        hasStore = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.store));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.byType(BrowseTermsTab), findsOneWidget);
        expect(find.byType(RecentTermsTab), findsNothing);
        expect(find.byType(NewTermsTab), findsNothing);
        expect(find.byType(UnstudiedTermsTab), findsNothing);
        expect(find.byType(FavoriteTermsTab), findsNothing);
        expect(find.byType(UpdateableTermsTab), findsNothing);
        expect(find.byType(StoreTab), findsNothing);
        expect(find.byType(NewsTab), findsNothing);
      });

      testWidgets(
          'browse terms tab page is rendered once changed back to educational content tab from news page',
          (widgetTester) async {
        hasNews = true;
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.news));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.educationalContent));
        await widgetTester.pumpAndSettle();
        expect(find.byType(BrowseTermsTab), findsOneWidget);
        expect(find.byType(RecentTermsTab), findsNothing);
        expect(find.byType(NewTermsTab), findsNothing);
        expect(find.byType(UnstudiedTermsTab), findsNothing);
        expect(find.byType(FavoriteTermsTab), findsNothing);
        expect(find.byType(UpdateableTermsTab), findsNothing);
        expect(find.byType(NewsTab), findsNothing);
      });

      testWidgets(
          'browse terms tab page is rendered once changed back to its tab',
          (widgetTester) async {
        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.newTerms));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.text(StringConstant.browseTerms));
        await widgetTester.pumpAndSettle();
        expect(find.byType(BrowseTermsTab), findsOneWidget);
        expect(find.byType(RecentTermsTab), findsNothing);
        expect(find.byType(NewTermsTab), findsNothing);
        expect(find.byType(UnstudiedTermsTab), findsNothing);
        expect(find.byType(FavoriteTermsTab), findsNothing);
        expect(find.byType(UpdateableTermsTab), findsNothing);
        expect(find.byType(StoreTab), findsNothing);
        expect(find.byType(NewsTab), findsNothing);
      });
    });
  });

  group('bottom navigation bar tests', () {
    testWidgets(
        'if application has a store, the educational bottom navigation item is rendered',
        (widgetTester) async {
      hasStore = true;
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text(StringConstant.educationalContent), findsOneWidget);
    });

    testWidgets(
        'if application has a news, the educational bottom navigation item is rendered',
        (widgetTester) async {
      hasNews = true;
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text(StringConstant.educationalContent), findsOneWidget);
    });

    testWidgets(
        'if application has a store, the store bottom navigation item is rendered',
        (widgetTester) async {
      hasStore = true;
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text(StringConstant.store), findsOneWidget);
    });

    testWidgets(
        'if application has a news, the news bottom navigation item is rendered',
        (widgetTester) async {
      hasNews = true;
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text(StringConstant.news), findsOneWidget);
    });

    testWidgets(
        'if application has a news, and there are new news, the new badge is rendered',
        (widgetTester) async {
      KeyValue keyValue = Get.find();
      await keyValue.setBool(KeyValueConstant.newsRecieved, true);
      hasNews = true;
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.widgetWithIcon(Badge, CupertinoIcons.news), findsOneWidget);
    });

    testWidgets(
        'if application has a news, and there are no new news, the new badge is not rendered',
        (widgetTester) async {
      KeyValue keyValue = Get.find();
      await keyValue.setBool(KeyValueConstant.newsRecieved, false);
      hasNews = true;
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.widgetWithIcon(Badge, CupertinoIcons.news), findsNothing);
    });

    testWidgets(
        'if application does not have a store nur news, the educational bottom navigation item is not rendered',
        (widgetTester) async {
      hasStore = false;
      hasNews = false;
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(BottomNavigationBar), findsNothing);
      expect(find.text(StringConstant.educationalContent), findsNothing);
    });

    testWidgets(
        'if application does not have a store, the store bottom navigation item is not rendered',
        (widgetTester) async {
      hasStore = false;
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(BottomNavigationBar), findsNothing);
      expect(find.text(StringConstant.store), findsNothing);
    });

    testWidgets(
        'if application does not have a news, the news bottom navigation item is not rendered',
        (widgetTester) async {
      hasNews = false;
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();
      expect(find.byType(BottomNavigationBar), findsNothing);
      expect(find.text(StringConstant.news), findsNothing);
    });
  });
}
