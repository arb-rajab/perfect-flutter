import 'package:beta/constants/arguments.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:beta/presentation/widgets/web_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class WebScreen extends StatefulWidget {
  static const String route = '/web';
  const WebScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  WebScreenArgument webScreenArgument = Get.find();

  @override
  void dispose() {
    Get.delete<WebScreenArgument>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      titleText: webScreenArgument.title.value,
        child: MainController.testing
            ? const Text('mock web')
            : WebWidget(
          uri: webScreenArgument.uri,
          connected: webScreenArgument.connected,
        ));
  }
}
