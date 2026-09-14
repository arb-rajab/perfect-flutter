import 'dart:io';

import 'package:beta/application/services/homework_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/domain/homework_submission_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:path/path.dart' as p;

import '../../common/tests.dart';

void main() {
  late HomeworkService homeworkService;
  late String submissionsUrl;

  setUp(() async {
    await initTests();
    homeworkService = Get.find();
    submissionsUrl = ApiConstant.homework.replaceFirst('(TERM_ID)', '1');
  });

  group('getSubmissions', () {
    test('parses the submissions returned on success', () async {
      dioAdapter.onGet(
          submissionsUrl,
          (server) => server.reply(200, r'''{"submissions":[
            {"id":1,"uuid":"uuid","termId":1,"title":"my homework","note":"note",
             "status":"pending","reviewNote":null,"mark":null,
             "submitted_at":"2026-01-01 10:00:00","reviewed_at":null}
          ],"result":"success","message":""}'''));

      List<HomeworkSubmissionData>? submissions;
      await homeworkService.getSubmissions(
        termId: const Id(1),
        onPreConnect: () {},
        onPostConnect: () {},
        onSuccess: (data) async => submissions = data,
        onConnectionFailed: () => fail('should not be called'),
        onMessageReceived: (_) => fail('should not be called'),
      );

      expect(submissions, isNotNull);
      expect(submissions!.length, equals(1));
      expect(submissions!.first.title, equals('my homework'));
      expect(submissions!.first.isPending, isTrue);
    });

    test('calls onMessageReceived when the server responds with a failure',
        () async {
      dioAdapter.onGet(
          submissionsUrl,
          (server) => server.reply(200,
              r'''{"result":"failed","message":"term not found","code":1}'''));

      FailureResponse? received;
      await homeworkService.getSubmissions(
        termId: const Id(1),
        onPreConnect: () {},
        onPostConnect: () {},
        onSuccess: (_) async => fail('should not be called'),
        onConnectionFailed: () => fail('should not be called'),
        onMessageReceived: (message) => received = message,
      );

      expect(received, isNotNull);
      expect(received!.content, equals('term not found'));
    });

    test('calls onConnectionFailed when there is no connection', () async {
      mockNoConnection(route: submissionsUrl);

      bool connectionFailed = false;
      await homeworkService.getSubmissions(
        termId: const Id(1),
        onPreConnect: () {},
        onPostConnect: () {},
        onSuccess: (_) async => fail('should not be called'),
        onConnectionFailed: () => connectionFailed = true,
        onMessageReceived: (_) => fail('should not be called'),
      );

      expect(connectionFailed, isTrue);
    });
  });

  group('upload', () {
    late String filePath;

    setUp(() async {
      final file = File(
          '${Directory.systemTemp.path}/homework_service_test_${DateTime.now().microsecondsSinceEpoch}.pdf');
      await file.writeAsBytes([1, 2, 3]);
      filePath = file.path;
    });

    Future<FormData> expectedFormData({String? title, String? note}) async =>
        FormData.fromMap({
          'file': await MultipartFile.fromFile(filePath,
              filename: p.basename(filePath)),
          if (title != null && title.isNotEmpty) 'title': title,
          if (note != null && note.isNotEmpty) 'note': note,
        });

    test('posts the file and its metadata, then reports success', () async {
      dioAdapter.onPost(
          submissionsUrl,
          (server) => server
              .reply(200, r'''{"result":"success","message":""}'''),
          data: await expectedFormData(title: 'my homework', note: 'a note'));

      bool succeeded = false;
      await homeworkService.upload(
        termId: const Id(1),
        filePath: filePath,
        title: 'my homework',
        note: 'a note',
        onPreConnect: () {},
        onPostConnect: () {},
        onSuccess: (_) async => succeeded = true,
        onConnectionFailed: () => fail('should not be called'),
        onMessageReceived: (_) => fail('should not be called'),
      );

      expect(succeeded, isTrue);
    });

    test('uploads successfully without optional title and note', () async {
      dioAdapter.onPost(
          submissionsUrl,
          (server) => server
              .reply(200, r'''{"result":"success","message":""}'''),
          data: await expectedFormData());

      bool succeeded = false;
      await homeworkService.upload(
        termId: const Id(1),
        filePath: filePath,
        onPreConnect: () {},
        onPostConnect: () {},
        onSuccess: (_) async => succeeded = true,
        onConnectionFailed: () => fail('should not be called'),
        onMessageReceived: (_) => fail('should not be called'),
      );

      expect(succeeded, isTrue);
    });

    test('calls onMessageReceived when the server rejects the upload',
        () async {
      dioAdapter.onPost(
          submissionsUrl,
          (server) => server.reply(200,
              r'''{"result":"failed","message":"invalid file","code":1}'''),
          data: await expectedFormData());

      FailureResponse? received;
      await homeworkService.upload(
        termId: const Id(1),
        filePath: filePath,
        onPreConnect: () {},
        onPostConnect: () {},
        onSuccess: (_) async => fail('should not be called'),
        onConnectionFailed: () => fail('should not be called'),
        onMessageReceived: (message) => received = message,
      );

      expect(received, isNotNull);
      expect(received!.content, equals('invalid file'));
    });

    test('calls onConnectionFailed when there is no connection', () async {
      mockNoConnection(
          route: submissionsUrl,
          method: 'post',
          data: await expectedFormData());

      bool connectionFailed = false;
      await homeworkService.upload(
        termId: const Id(1),
        filePath: filePath,
        onPreConnect: () {},
        onPostConnect: () {},
        onSuccess: (_) async => fail('should not be called'),
        onConnectionFailed: () => connectionFailed = true,
        onMessageReceived: (_) => fail('should not be called'),
      );

      expect(connectionFailed, isTrue);
    });
  });
}
