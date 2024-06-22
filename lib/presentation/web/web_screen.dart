import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class WebScreen extends StatefulWidget {
  static const String route = '/web';
  const WebScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  WebScreenArgument webScreenArgument = Get.find();
  final GlobalKey webViewKey = GlobalKey();

  double progress = 0;
  bool error = false;

  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      cacheMode: Get.find<WebScreenArgument>().connected
          ? CacheMode.LOAD_NO_CACHE
          : CacheMode.LOAD_CACHE_ONLY);

  InAppWebViewController? webViewController;

  @override
  void dispose() {
    Get.delete<WebScreenArgument>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      titleText: webScreenArgument.title.value,
      child: Column(
        children: [
          if (progress != 1)
            LinearProgressIndicator(
              value: progress,
            ),
          if (!error)
            Expanded(
                child: InAppWebView(
              key: webViewKey,
              initialUrlRequest:
                  URLRequest(url: WebUri(webScreenArgument.uri.toString())),
              initialSettings: settings,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onReceivedError: (controller, request, error) {
                showOkDialogue(
                    context, context.pop,
                    content: error.description);
                setState(() {
                  this.error = true;
                });
              },
              onProgressChanged: (controller, progress) {
                setState(() => this.progress = progress.toDouble() / 100.0);
              },
              onConsoleMessage: (controller, consoleMessage) {
                if (kDebugMode) {
                  print(consoleMessage);
                }
              },
            )),
        ],
      ),
    );
  }
}

class WebScreenArgument {
  final Uri uri;
  final t.Title title;
  final bool connected;

  WebScreenArgument(
      {required this.connected, required this.uri, required this.title});
}
