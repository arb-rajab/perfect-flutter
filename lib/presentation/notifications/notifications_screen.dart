import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/notifications/notifications_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class NotificationsScreen extends StatefulWidget {
  static const route = '/notifications';
  static const icon = Icons.notifications;
  static final title = StringConstant.notifications.tr();

  const NotificationsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late NotificationsListController _controller;

  @override
  void initState() {
    Get.delete<NotificationsListController>();
    _controller = Get.put(NotificationsListController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        icon: NotificationsScreen.icon,
        title: NotificationsScreen.title,
        child: ItemsList(controller: _controller));
  }
}
