import 'package:beta/domain/value/title.dart' as t;
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
        child: WebWidget(
          uri: webScreenArgument.uri,
          connected: webScreenArgument.connected,
        ));
  }
}

class WebScreenArgument {
  final Uri uri;
  final t.Title title;
  final bool connected;

  WebScreenArgument(
      {required this.connected, required this.uri, required this.title});
}
