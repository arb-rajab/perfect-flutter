import 'dart:convert';

import 'package:beta/helper/failure_response.dart';
import 'package:beta/infrastructure/device_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class NetworkService {
  /// show loading dialogue, hide old results or errors, etc
  Function() onPreConnect;

  /// Hide loading dialogue, etc
  Function() onPostConnect;

  /// Show results, show no results
  Function(dynamic body) onConnectionSucceed;

  /// Show no network connection
  Function() onConnectionFailed;

  /// Show the [message]
  Function(FailureResponse message) onMessageReceived;

  BuildContext context;

  static Dio dio = Dio(BaseOptions(connectTimeout: const Duration(minutes: 1)));

  NetworkService(
    this.context, {
    required this.onPreConnect,
    required this.onPostConnect,
    required this.onConnectionSucceed,
    required this.onConnectionFailed,
    required this.onMessageReceived,
  });

  Map<String, String> getHeaders() {
    String info = '';
    DeviceRepository deviceRepository = Get.find();
    // if (keyValue.getString('deviceInfo') != null) {
    //   info = keyValue.getString('deviceInfo')!;
    // } else {
    info = deviceRepository.getFullInfo(context);
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
        onConnectionSucceed(body);
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
          onConnectionSucceed(body).call();
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
    response = await dio.post(url, data: body);
    onPostConnect.call();
    if (response.statusCode == 200) {
      _handleResponse(response);
      return;
    }
    onConnectionFailed.call();
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
    response = await dio.get(url, queryParameters: query);
    onPostConnect.call();
    if (response.statusCode == 200) {
      _handleResponse(response);
      return;
    }
    onConnectionFailed.call();
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
    response = await dio.put(url, data: body);
    onPostConnect.call();
    if (response.statusCode == 200) {
      _handleResponse(response);
      return;
    }
    onConnectionFailed.call();
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
    response = await dio.patch(url, data: body);
    onPostConnect.call();
    if (response.statusCode == 200) {
      _handleResponse(response);
      return;
    }
    onConnectionFailed.call();
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
    response = await dio.delete(url, queryParameters: query);
    onPostConnect.call();
    if (response.statusCode == 200) {
      _handleResponse(response);
      return;
    }
    onConnectionFailed.call();
  }
}
