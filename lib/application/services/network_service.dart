import 'dart:convert';

import 'package:beta/abstract/device_repository_base.dart';
import 'package:beta/application/services/network/shared.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/main_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';

class NetworkService {
  /// show loading dialogue, hide old results or errors, etc
  Function() onPreConnect;

  /// Hide loading dialogue, etc
  Function() onPostConnect;

  /// Show results, show no results
  Future<void> Function(dynamic body) onConnectionSucceed;

  /// Show no network connection
  Function() onConnectionFailed;

  /// Show the [message]
  Function(FailureResponse message) onMessageReceived;

  static Dio dio = Dio(BaseOptions(connectTimeout: const Duration(minutes: 1)));

  bool retryOnStartup = false;

  NetworkService({
    required this.onPreConnect,
    required this.onPostConnect,
    required this.onConnectionSucceed,
    required this.onConnectionFailed,
    required this.onMessageReceived,
  }) {
    setHttpOverrides();
  }

  Map<String, String> getHeaders() => deviceHeaders();

  /// The identity header the server expects on every request, also usable
  /// outside of [NetworkService] (e.g. for web views that load our own pages).
  static Map<String, String> deviceHeaders() {
    String info = '';
    DeviceRepositoryBase deviceRepository = Get.find();
    // if (keyValue.getString('deviceInfo') != null) {
    //   info = keyValue.getString('deviceInfo')!;
    // } else {
    info = deviceRepository.getFullInfo();
    //   keyValue.setString('deviceInfo', info);
    // }
    return {'deviceInfo': info};
  }

  ///Handle the [response] received from API
  ///So it is moved to a separate function instead of having the same code in both functions
  Future _handleResponse(Response response) async {
    dynamic body = response.data;
    if (kDebugMode) {
      print(body);
    }
    try {
      body = json.decode(body);
    } on FormatException {
      /// This exception is thrown when the server side returns HTML format response
      /// due to internal server error
      onMessageReceived(FailureResponse(
          type: MessageType.error, content: response.data, code: 1));
      return;
    }
    switch (body['result']) {
      case "success":
        await onConnectionSucceed(body);
        break;
      case "failed":
        try {
          onMessageReceived(FailureResponse(
                  type: MessageType.error,
                  content: body['message'],
                  code: body['code']))
              .call();
          // ignore: empty_catches
        } catch (e) {}
        break;
      case 2:
        await onConnectionSucceed(body);
        onMessageReceived(FailureResponse(
                type: MessageType.warning,
                content: body['message'],
                code: body['code']))
            .call();
        break;
    }
  }

  Future post(
      {required String url,
      required dynamic body,
      bool json = false,
      bool fileUpload = false}) async {
    if (kDebugMode) {
      print('url: $url');
      if (!fileUpload) print('body: ${jsonEncode(body)}');
    }
    onPreConnect.call();
    late Response response;
    var sentHeaders = getHeaders();
    if (json) sentHeaders['content-type'] = 'application/json';
    // sentHeaders.addIf(fileUpload, 'content-type', 'multipart/form-data');
    // if (fileUpload) {
    body = FormData.fromMap(body);
    // }
    dio.options.headers = sentHeaders;
    try {
      response = await dio.post(url, data: body);
      onPostConnect.call();
      if (response.statusCode == 200) {
        await _handleResponse(response);
        return;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);
      }
      onPostConnect.call();
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        onConnectionFailed.call();
      }
    }
  }

  Future get(
      {required String url,
      Map<String, dynamic>? query,
      bool json = false}) async {
    if (kDebugMode) {
      print('url: $url');
      print('body: ${jsonEncode(query)}');
    }
    onPreConnect.call();
    late Response response;
    var sentHeaders = getHeaders();
    if (json) sentHeaders['content-type'] = 'application/json';
    dio.options.headers = sentHeaders;
    try {
      response = await dio.get(url, queryParameters: query);
      onPostConnect.call();
      if (response.statusCode == 200) {
        await _handleResponse(response);
        return;
      }
    } on DioException catch (e) {
      onPostConnect.call();
      if (kDebugMode) {
        print(e.error);
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        onConnectionFailed.call();
      }
    }
  }

  Future put(
      {required String url,
      dynamic body,
      bool json = false,
      bool fileUpload = false}) async {
    if (kDebugMode) {
      print('url: $url');
      if (!fileUpload) print('body: ${jsonEncode(body)}');
    }
    onPreConnect.call();
    late Response response;
    var sentHeaders = getHeaders();
    if (json) sentHeaders['content-type'] = 'application/json';
    // sentHeaders.addIf(json, 'content-type', 'application/json');
    // if (fileUpload) {
    body = FormData.fromMap(body);
    // }
    dio.options.headers = sentHeaders;
    try {
      response = await dio.put(url, data: body);
      onPostConnect.call();
      if (response.statusCode == 200) {
        await _handleResponse(response);
        return;
      }
    } on DioException catch (e) {
      onPostConnect.call();
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        onConnectionFailed.call();
      }
    }
  }

  Future patch({required String url, dynamic body, bool json = false}) async {
    if (kDebugMode) {
      print('url: $url');
      print('body: ${jsonEncode(body)}');
    }
    onPreConnect.call();
    late Response response;
    var sentHeaders = getHeaders();
    if (json) sentHeaders['content-type'] = 'application/json';
    // sentHeaders.addIf(json, 'content-type', 'application/json');
    dio.options.headers = sentHeaders;
    try {
      response = await dio.patch(url, data: body);
      onPostConnect.call();
      if (response.statusCode == 200) {
        await _handleResponse(response);
        return;
      }
    } on DioException catch (e) {
      onPostConnect.call();
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        onConnectionFailed.call();
      }
    }
  }

  Future delete(
      {required String url,
      Map<String, dynamic>? query,
      bool json = false}) async {
    if (kDebugMode) {
      print('url: $url');
      print('body: ${jsonEncode(query)}');
    }
    onPreConnect.call();
    late Response response;
    var sentHeaders = getHeaders();
    // sentHeaders.addIf(json, 'content-type', 'application/json');
    if (json) sentHeaders['content-type'] = 'application/json';
    dio.options.headers = sentHeaders;
    try {
      response = await dio.delete(url, queryParameters: query);
      onPostConnect.call();
      if (response.statusCode == 200) {
        await _handleResponse(response);
        return;
      }
    } on DioException catch (e) {
      onPostConnect.call();
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        onConnectionFailed.call();
      }
    }
  }

  Future download(
      {required String url,
      required String filePath,
      required Function(int recieved, int total) onRecieveProgress}) async {
    onPreConnect.call();
    if (kIsWeb) {
      return dio.get(url);
    }
    if (MainController.testing) {
      await dio.get(url);
    } else {
      await dio.download(url, filePath, onReceiveProgress: onRecieveProgress);
    }
    onPostConnect.call();
    await onConnectionSucceed.call(null);
  }
}
