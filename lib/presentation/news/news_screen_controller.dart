// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/news.dart';
import 'package:beta/domain/value/id.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NewsScreenController {
  State state;
  Id id;
  bool loading = false;
  String message = '';
  News? news;

  NewsScreenController(this.state, this.id) {
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }

  Future getData() => NetworkService(onPreConnect: () {
        if (state.mounted) {
          state.setState(() {
            loading = true;
            message = '';
          });
        }
      }, onPostConnect: () {
        if (state.mounted) {
          state.setState(() {
            loading = false;
            message = '';
          });
        }
      }, onConnectionSucceed: (data) {
        if (state.mounted) {
          state.setState(() => news = News.fromJson(data['news']));
        }
        return Future.value();
      }, onConnectionFailed: () {
        if (state.mounted) {
          state.setState(() => message = StringConstant.noConnection.tr());
        }
      }, onMessageReceived: (failureResponse) {
        if (state.mounted) {
          state.setState(() => message = failureResponse.content);
        }
      }).get(
          url: ApiConstant.newss
              .replaceFirst('(NEWS_ID)', id.value!.toString()));
}
