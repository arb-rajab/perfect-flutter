import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/main_controller.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

late DioAdapter dioAdapter;
late DatabaseService databaseService;

// MyApp.initState fires off app_links calls unconditionally (regardless of
// MainController.testing), so every widget test that pumps MyApp needs
// these channels mocked or the plugin's MissingPluginException can surface
// mid-test and fail it once the test runs long enough for the async error
// to unwind within the test's own zone.
//
// initTests() itself is called both before any test starts and, in some
// test files, from inside a running test - so this can't use
// setMockStreamHandler for the event channel, since it registers a
// tearDown internally and tearDown/addTearDown require an active test
// context. Since our handler never actually emits stream events, it's
// enough to just ack the EventChannel's 'listen'/'cancel' handshake calls
// as a plain MethodChannel, without setMockStreamHandler's stream plumbing.
const _appLinksMethodChannel = MethodChannel('com.llfbandit.app_links/messages');
const _appLinksEventChannel = EventChannel('com.llfbandit.app_links/events');

Future initTests() async {
  MainController.testing = true;
  Get.deleteAll(force: true);
  TestWidgetsFlutterBinding.ensureInitialized();
  WidgetController.hitTestWarningShouldBeFatal = true;
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(_appLinksMethodChannel, (call) async => null);
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
          MethodChannel(_appLinksEventChannel.name, _appLinksEventChannel.codec),
          (call) async => null);
  await MainController.initServices();
  dioAdapter = DioAdapter(dio: NetworkService.dio);
  EasyLocalization.logger.enableLevels = [];
  databaseService = Get.find();
  await databaseService.deleteAllTables();
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
}

void mockNoConnection(
    {required String route, String method = 'get', dynamic data}) {
  if (method == 'get') {
    dioAdapter.onGet(
        route,
        (server) => server.throws(
            200,
            DioException.connectionError(
                requestOptions: RequestOptions(), reason: 'no connection'),
            delay: const Duration(seconds: 1)));
  }
  if (method == 'post') {
    dioAdapter.onPost(
        route,
        data: data,
        (server) => server.throws(
            200,
            DioException.connectionError(
                requestOptions: RequestOptions(), reason: 'no connection'),
            delay: const Duration(seconds: 1)));
  }
}

void mockMessageRecieved(
    {required String route, String method = 'get', dynamic data}) {
  if (method == 'get') {
    dioAdapter.onGet(
        route,
        (server) => server.reply(
            200, r'''{"result":"failed","message":"a message recieved"}'''));
  }
  if (method == 'post') {
    dioAdapter.onPost(
        route,
        data: data,
        (server) => server.reply(
            200, r'''{"result":"failed","message":"a message recieved"}'''));
  }
}

final testSizes = {
  'small': const Size(300, 600), // Small mobile
  'medium': const Size(600, 800), // Tablet portrait
  'large': const Size(800, 600), // Tablet landscape
  'desktop': const Size(1200, 800), // Desktop
};

Finder widgetWithTextAndIcon(Type widgetType, String text, IconData icon) {
  return find.byWidgetPredicate((widget) {
    // Check ONLY within this widget's subtree
    final textInWidget = find
        .descendant(
          of: find.byWidget(widget),
          matching: find.text(text),
        )
        .evaluate()
        .isNotEmpty;

    final iconInWidget = find
        .descendant(
          of: find.byWidget(widget),
          matching: find.byIcon(icon),
        )
        .evaluate()
        .isNotEmpty;

    return textInWidget && iconInWidget && widget.runtimeType == widgetType;
  });
}

Finder widgetWithTextAndKey(Type widgetType, String text, Key key) {
  return find.byWidgetPredicate((widget) {
    // Check ONLY within this widget's subtree
    final textInWidget = find
        .descendant(
          of: find.byWidget(widget),
          matching: find.text(text),
        )
        .evaluate()
        .isNotEmpty;

    final keyInWidget = find
        .descendant(
          of: find.byWidget(widget),
          matching: find.byKey(key),
        )
        .evaluate()
        .isNotEmpty;

    return textInWidget && keyInWidget && widget.runtimeType == widgetType;
  });
}

Finder widgetWithTextAndWidget(
    Type widgetType, String text, Type subWidgetType) {
  return find.byWidgetPredicate((widget) {
    // Check ONLY within this widget's subtree
    final textInWidget = find
        .descendant(
          of: find.byWidget(widget),
          matching: find.text(text),
        )
        .evaluate()
        .isNotEmpty;

    final subWidgetInWidget = find
        .descendant(
          of: find.byWidget(widget),
          matching: find.byType(subWidgetType),
        )
        .evaluate()
        .isNotEmpty;

    return textInWidget &&
        subWidgetInWidget &&
        widget.runtimeType == widgetType;
  });
}

void setDesktopDevice(WidgetTester widgetTester) {
  widgetTester.view.physicalSize = testSizes['desktop']!;
  widgetTester.view.devicePixelRatio = 1;
  addTearDown(widgetTester.view.resetPhysicalSize);
}
