import 'package:beta/application/services/database_service.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/path_widget.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();
  DatabaseService databaseService = Get.find();

  tearDown(() async {
    await databaseService.deleteAllTables();
  });

  testWidgets('terms path widget is rendered when navigating between terms',
      (widgetTester) async {
    await databaseService.seedTermsData();

    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();

    // tap the parent term
    await widgetTester.tap(find.text('parent'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(PathWidget, 'parent'), findsOneWidget);
    expect(find.widgetWithText(PathWidget, 'child'), findsNothing);
    expect(find.widgetWithText(TermWidget, 'parent'), findsNothing);
    expect(find.widgetWithText(TermWidget, 'child'), findsOneWidget);

    expect(find.byIcon(Icons.navigate_next), findsNWidgets(2));
  });

  testWidgets('terms path widget is navigating to path item',
      (widgetTester) async {
    await databaseService.seedTermsData();

    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();

    // tap the parent term
    await widgetTester.tap(find.text('parent'));
    await widgetTester.pumpAndSettle();

    //tap the child term
    await widgetTester.tap(find.text('child'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(PathWidget, 'parent'), findsOneWidget);
    expect(find.widgetWithText(PathWidget, 'child'), findsOneWidget);
    expect(find.widgetWithText(TermWidget, 'grand child'), findsOneWidget);

    //tap the parent listing item
    await widgetTester.tap(find.widgetWithText(PathWidget, 'parent'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(PathWidget, 'parent'), findsOneWidget);
    expect(find.widgetWithText(PathWidget, 'child'), findsNothing);
    expect(find.widgetWithText(TermWidget, 'child'), findsOneWidget);
    expect(find.widgetWithText(TermWidget, 'grand child'), findsNothing);
  });
}
