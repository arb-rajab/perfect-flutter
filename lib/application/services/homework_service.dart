import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/domain/homework_submission_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

class HomeworkService {
  Future getSubmissions({
    required Id termId,
    required Function() onPreConnect,
    required Function() onPostConnect,
    required Future<void> Function(List<HomeworkSubmissionData> submissions)
        onSuccess,
    required Function() onConnectionFailed,
    required Function(FailureResponse message) onMessageReceived,
  }) {
    return NetworkService(
      onPreConnect: onPreConnect,
      onPostConnect: onPostConnect,
      onConnectionFailed: onConnectionFailed,
      onMessageReceived: onMessageReceived,
      onConnectionSucceed: (body) async {
        List<HomeworkSubmissionData> submissions =
            (body['submissions'] as List)
                .map((e) => HomeworkSubmissionData.fromJson(e))
                .toList();
        await onSuccess(submissions);
      },
    ).get(
        url: ApiConstant.homework.replaceFirst(
            '(TERM_ID)', termId.value.toString()));
  }

  Future upload({
    required Id termId,
    required String filePath,
    String? title,
    String? note,
    required Function() onPreConnect,
    required Function() onPostConnect,
    required Future<void> Function(dynamic body) onSuccess,
    required Function() onConnectionFailed,
    required Function(FailureResponse message) onMessageReceived,
  }) async {
    return NetworkService(
      onPreConnect: onPreConnect,
      onPostConnect: onPostConnect,
      onConnectionFailed: onConnectionFailed,
      onMessageReceived: onMessageReceived,
      onConnectionSucceed: onSuccess,
    ).post(
      url: ApiConstant.homework
          .replaceFirst('(TERM_ID)', termId.value.toString()),
      fileUpload: true,
      body: {
        'file': await MultipartFile.fromFile(filePath,
            filename: p.basename(filePath)),
        if (title != null && title.isNotEmpty) 'title': title,
        if (note != null && note.isNotEmpty) 'note': note,
      },
    );
  }
}
