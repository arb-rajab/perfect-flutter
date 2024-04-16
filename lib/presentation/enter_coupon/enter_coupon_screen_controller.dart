// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/application/services/user_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/coupon_type.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/presentation/choose_term/choose_term_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';

class EnterCouponScreenController {
  final State<StatefulWidget> state;
  EnterCouponScreenController(this.state);

  final TextEditingController nameController = TextEditingController();
  String? nameError;
  final TextEditingController couponController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool okClicked = false;
  bool activateFreeVersionClicked = false;

  bool loading = false;
  String message = '';

  //TODO apply test
  void onOkclick() {
    if (formKey.currentState!.validate()) {
      NetworkService(state.context,
          onPreConnect: () => state.setState(() {
                loading = true;
                okClicked = true;
                activateFreeVersionClicked = false;
                message = '';
              }),
          onPostConnect: () => state.setState(() {
                loading = false;
                message = '';
                okClicked = false;
                activateFreeVersionClicked = false;
              }),
          onConnectionSucceed: (body) =>
              _processResponse(free: false, body: body),
          onConnectionFailed: () => state.setState(() {
                message = StringConstant.noConnection.tr();
              }),
          onMessageReceived: (FailureResponse message) => state.setState(() {
                this.message = message.content;
              })).post(
          url: ApiConstant.checkCoupon
              .replaceAll('(SERIAL)', couponController.text),
          body: {'name': nameController.text});
    }
  }

  void dismissMessage() => state.setState(() {
        message = '';
      });

  void _processResponse({required bool free, required dynamic body}) {
    UserService userService = Get.find();
    userService.setId(body['deviceId']);
    coupons coupon = coupons.fromJson(body['coupon']);
    CouponType couponType = CouponType.fromJson(body['coupon']['coupon_type']);
    List<TermData> terms =
        (body['terms'] as List).map((e) => TermData.fromJson(e)).toList();
    Navigator.pushNamed(state.context, ChooseTermScreen.route,
        arguments: ChooseTermScreenArgument(
            coupon: coupon, terms: terms, free: true, couponType: couponType));
  }

  //TODO apply test
  void onActivateFreeVersionClick() {
    if (nameController.text.isNotEmpty) {
      state.setState(() {
        nameError = null;
      });
      NetworkService(state.context,
          onPreConnect: () => state.setState(() {
                loading = true;
                message = '';
                okClicked = false;
                activateFreeVersionClicked = true;
              }),
          onPostConnect: () => state.setState(() {
                loading = false;
                message = '';
                okClicked = false;
                activateFreeVersionClicked = false;
              }),
          onConnectionSucceed: (body) =>
              _processResponse(free: true, body: body),
          onConnectionFailed: () => state.setState(() {
                message = StringConstant.noConnection.tr();
              }),
          onMessageReceived: (FailureResponse message) => state.setState(() {
                this.message = message.content;
              })).post(
          url: ApiConstant.activateFreeVersion,
          body: {'name': nameController.text});
    } else {
      state.setState(() {
        nameError = StringConstant.pleaseFillThisField.tr();
      });
    }
  }

  void setCoupon(String coupon) {
    state.setState(() {
      couponController.text = coupon;
    });
  }
}
