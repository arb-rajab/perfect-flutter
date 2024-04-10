// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_print.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GiftWidgetController {
  final State<StatefulWidget> state;
  final String code;
  TermPrint? termPrint;
  String? coupon;
  bool loading = false;
  String message = '';

  GiftWidgetController({required this.state, required this.code});
  Future init() {
    return NetworkService(state.context, onConnectionSucceed: (data) {
      termPrint = TermPrint.fromJson(data['term-print']);
      if (data['coupon'] != null) coupon = data['coupon']['serial'];
    }, onPreConnect: () {
      state.setState(() {
        message = '';
        loading = true;
      });
    }, onPostConnect: () {
      state.setState(() {
        message = '';
        loading = false;
      });
    }, onConnectionFailed: () {
      state.setState(() {
        loading = false;
        message = StringConstant.noConnection.tr();
      });
    }, onMessageReceived: (FailureResponse message) {
      state.setState(() {
        loading = false;
        this.message = message.content;
      });
    }).patch(url: ApiConstant.termPrintQr.replaceFirst('(QR)', code));
  }
}
