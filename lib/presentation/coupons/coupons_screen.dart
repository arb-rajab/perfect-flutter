import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/coupons/coupons_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class CouponsScreen extends StatefulWidget {
  static const route = '/coupons';
  static String title = StringConstant.coupons.tr();
  static const IconData icon = Icons.credit_card;

  const CouponsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  late CouponsListController _controller;

  @override
  void initState() {
    Get.delete<CouponsListController>();
    _controller = Get.put(CouponsListController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        titleText: CouponsScreen.title,
        icon: CouponsScreen.icon,
        child: ItemsList(controller: _controller));
  }
}
