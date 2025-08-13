import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:beta/presentation/youtube_video/youtube_video_screen_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/instance_manager.dart';

class YoutubeVideoScreen extends StatefulWidget {
  static const String route = '/youtubeVideo';
  const YoutubeVideoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _YoutubeVideoScreenState();
}

class _YoutubeVideoScreenState extends State<YoutubeVideoScreen> {
  late YoutubeVideoScreenController controller;

  @override
  void initState() {
    Get.delete<YoutubeVideoScreenController>();
    controller = Get.put(YoutubeVideoScreenController(this));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        titleText: controller.argument.termData.term.name,
        child: Column(
      children: [
        SizedBox(
          height: 400,
              child: MainController.testing
                  ? const Text('web view')
                  : InAppWebView(
            initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true, domStorageEnabled: true),
            onConsoleMessage: controller.onConsoleMessage,
            onProgressChanged: controller.onProgressChanged,
            onWebViewCreated: (c) {
              controller.controller = c;
              controller.getLastSecond();
            },
          ),
        ),
        const SizedBox(
          height: margin,
        ),
        GestureDetector(
          onTap: controller.loadMoreCommentsTap,
          child: Text(
            StringConstant.showComments.tr(),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(decoration: TextDecoration.underline),
          ),
        )
      ],
    ));
  }
}
