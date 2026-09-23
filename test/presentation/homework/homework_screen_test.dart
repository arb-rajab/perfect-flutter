import 'dart:io';

import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/homework/homework_screen.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import '../../common/tests.dart';
import 'common.dart';

class FakeFileSelectorPlatform extends FileSelectorPlatform {
  XFile? fileToReturn;

  @override
  Future<XFile?> openFile({
    List<XTypeGroup>? acceptedTypeGroups,
    String? initialDirectory,
    String? confirmButtonText,
  }) async =>
      fileToReturn;
}

Future main() async {
  await initTests();
  await initData();

  String submissionsUrl =
      ApiConstant.homework.replaceFirst('(TERM_ID)', '1');

  final fakeFileSelector = FakeFileSelectorPlatform();
  FileSelectorPlatform.instance = fakeFileSelector;

  // Uses the synchronous API rather than `await file.writeAsBytes(...)`
  // because this runs directly in the testWidgets body, outside
  // tester.runAsync - a real (non-Timer) Future awaited there never
  // completes, since FakeAsync queues its completion microtask and nothing
  // ever flushes it before the await needs a result.
  //
  // Creates a fresh temp directory per call (rather than one shared temp
  // dir) so every test can use the same basename, "my homework.pdf" -
  // cross_file's io XFile ignores the `name:` constructor argument and
  // always derives the picked file's name from the path's basename, so the
  // uploaded title the app actually sends is this file's basename, not
  // whatever name is passed to XFile(...).
  String createTempHomeworkFile() {
    final dir = Directory.systemTemp.createTempSync('homework_screen_test_');
    final file = File(p.join(dir.path, 'my homework.pdf'));
    file.writeAsBytesSync([1, 2, 3]);
    return file.path;
  }

  // HomeworkScreenController.pickAndUploadFile always sends the picked
  // file's name as the 'title' field and never sends a 'note'.
  //
  // Uses MultipartFile.fromBytes (sync-friendly, no real I/O Future) rather
  // than MultipartFile.fromFile because this runs directly in the
  // testWidgets body, outside tester.runAsync - see createTempHomeworkFile.
  // FormDataMatcher only compares filename/contentType/length, not content,
  // so this still matches the fromFile-built FormData sent by the app.
  FormData expectedUploadFormData(String filePath, String title) =>
      FormData.fromMap({
        'file': MultipartFile.fromBytes(File(filePath).readAsBytesSync(),
            filename: p.basename(filePath)),
        'title': title,
      });

  // pickAndUploadFile does real file I/O (via file_selector and
  // MultipartFile.fromFile), which the fake-time zone that testWidgets
  // pumps run in cannot progress on its own - it has to run in a real zone
  // via runAsync, then be pumped once the real work has completed.
  Future<void> tapUploadAndSettle(WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.tap(find.byKey(const Key('uploadHomework')));
      for (var i = 0; i < 50; i++) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    });
    await tester.pumpAndSettle();
  }

  testWidgets('HomeworkScreen shows empty state when there are no submissions',
      (WidgetTester tester) async {
    dioAdapter.onGet(
        submissionsUrl,
        (server) => server.reply(
            200, r'''{"submissions":[],"result":"success","message":""}'''));

    await tester.pumpWidget(const MyApp(defaultRoute: HomeworkScreen.route));
    await tester.pumpAndSettle();

    expect(find.byType(HomeworkScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'name'), findsWidgets);
    expect(find.text(StringConstant.noHomeworkSubmissionsYet.tr()),
        findsOneWidget);
  });

  testWidgets('HomeworkScreen shows a submission with its status and review note',
      (WidgetTester tester) async {
    dioAdapter.onGet(
        submissionsUrl,
        (server) => server.reply(200, r'''{"submissions":[
          {"id":1,"uuid":"uuid","termId":1,"title":"my homework","note":null,
           "status":"rejected","reviewNote":"please redo question 2","mark":null,
           "submitted_at":"2026-01-01 10:00:00","reviewed_at":"2026-01-02 10:00:00"}
        ],"result":"success","message":""}'''));

    await tester.pumpWidget(const MyApp(defaultRoute: HomeworkScreen.route));
    await tester.pumpAndSettle();

    expect(find.text('my homework'), findsOneWidget);
    expect(find.text(StringConstant.homeworkStatusRejected.tr()),
        findsOneWidget);
    expect(
        find.text(
            '${StringConstant.homeworkReviewNote.tr()}: please redo question 2'),
        findsOneWidget);
  });

  testWidgets('HomeworkScreen shows the mark next to the review note when set',
      (WidgetTester tester) async {
    dioAdapter.onGet(
        submissionsUrl,
        (server) => server.reply(200, r'''{"submissions":[
          {"id":1,"uuid":"uuid","termId":1,"title":"my homework","note":null,
           "status":"approved","reviewNote":"well done","mark":"85",
           "submitted_at":"2026-01-01 10:00:00","reviewed_at":"2026-01-02 10:00:00"}
        ],"result":"success","message":""}'''));

    await tester.pumpWidget(const MyApp(defaultRoute: HomeworkScreen.route));
    await tester.pumpAndSettle();

    expect(find.text('my homework'), findsOneWidget);
    expect(find.text('${StringConstant.homeworkMark.tr()}: 85'),
        findsOneWidget);
  });

  testWidgets('HomeworkScreen shows an upload button',
      (WidgetTester tester) async {
    dioAdapter.onGet(
        submissionsUrl,
        (server) => server.reply(
            200, r'''{"submissions":[],"result":"success","message":""}'''));

    await tester.pumpWidget(const MyApp(defaultRoute: HomeworkScreen.route));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('uploadHomework')), findsOneWidget);
    expect(find.text(StringConstant.uploadHomework.tr()), findsOneWidget);
  });

  testWidgets(
      'HomeworkScreen shows a no connection dialogue when submissions fail to load',
      (WidgetTester tester) async {
    mockNoConnection(route: submissionsUrl);

    await tester.pumpWidget(const MyApp(defaultRoute: HomeworkScreen.route));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(OKDialogue, StringConstant.noConnection.tr()),
        findsOneWidget);
  });

  testWidgets(
      'HomeworkScreen shows the server message when loading submissions fails',
      (WidgetTester tester) async {
    mockMessageRecieved(route: submissionsUrl);

    await tester.pumpWidget(const MyApp(defaultRoute: HomeworkScreen.route));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(OKDialogue, 'a message recieved'),
        findsOneWidget);
  });

  testWidgets(
      'tapping the upload button without picking a file does not upload anything',
      (WidgetTester tester) async {
    fakeFileSelector.fileToReturn = null;
    dioAdapter.onGet(
        submissionsUrl,
        (server) => server.reply(
            200, r'''{"submissions":[],"result":"success","message":""}'''));

    await tester.pumpWidget(const MyApp(defaultRoute: HomeworkScreen.route));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('uploadHomework')));
    await tester.pumpAndSettle();

    expect(find.byType(OKDialogue), findsNothing);
    expect(find.text(StringConstant.noHomeworkSubmissionsYet.tr()),
        findsOneWidget);
  });

  testWidgets('picking and uploading a file shows a success dialogue',
      (WidgetTester tester) async {
    final filePath = createTempHomeworkFile();
    fakeFileSelector.fileToReturn = XFile(filePath, name: 'my homework.pdf');
    dioAdapter.onGet(
        submissionsUrl,
        (server) => server.reply(
            200, r'''{"submissions":[],"result":"success","message":""}'''));
    dioAdapter.onPost(
        submissionsUrl,
        (server) =>
            server.reply(200, r'''{"result":"success","message":""}'''),
        data: expectedUploadFormData(filePath, 'my homework.pdf'));

    await tester.pumpWidget(const MyApp(defaultRoute: HomeworkScreen.route));
    await tester.pumpAndSettle();

    await tapUploadAndSettle(tester);

    expect(
        find.widgetWithText(
            OKDialogue, StringConstant.homeworkUploadedSuccessfully.tr()),
        findsOneWidget);
  });

  testWidgets(
      'uploading a file shows the server message when the upload is rejected',
      (WidgetTester tester) async {
    final filePath = createTempHomeworkFile();
    fakeFileSelector.fileToReturn = XFile(filePath, name: 'my homework.pdf');
    dioAdapter.onGet(
        submissionsUrl,
        (server) => server.reply(
            200, r'''{"submissions":[],"result":"success","message":""}'''));
    mockMessageRecieved(
        route: submissionsUrl,
        method: 'post',
        data: expectedUploadFormData(filePath, 'my homework.pdf'));

    await tester.pumpWidget(const MyApp(defaultRoute: HomeworkScreen.route));
    await tester.pumpAndSettle();

    await tapUploadAndSettle(tester);

    expect(find.widgetWithText(OKDialogue, 'a message recieved'),
        findsOneWidget);
  });

  testWidgets(
      'uploading a file shows a no connection dialogue when there is no connection',
      (WidgetTester tester) async {
    final filePath = createTempHomeworkFile();
    fakeFileSelector.fileToReturn = XFile(filePath, name: 'my homework.pdf');
    dioAdapter.onGet(
        submissionsUrl,
        (server) => server.reply(
            200, r'''{"submissions":[],"result":"success","message":""}'''));
    mockNoConnection(
        route: submissionsUrl,
        method: 'post',
        data: expectedUploadFormData(filePath, 'my homework.pdf'));

    await tester.pumpWidget(const MyApp(defaultRoute: HomeworkScreen.route));
    await tester.pumpAndSettle();

    await tapUploadAndSettle(tester);

    expect(find.widgetWithText(OKDialogue, StringConstant.noConnection.tr()),
        findsOneWidget);
  });
}
