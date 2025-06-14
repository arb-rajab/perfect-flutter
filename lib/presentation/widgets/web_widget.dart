import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

class WebWidget extends StatefulWidget {
  final Uri uri;
  final bool connected;
  const WebWidget({super.key, required this.uri, required this.connected});

  @override
  State<WebWidget> createState() => WebWidgetState();
}

class WebWidgetState extends State<WebWidget> {
  final GlobalKey webViewKey = GlobalKey();

  double progress = 0;
  bool error = false;

  InAppWebViewController? webViewController;

  late InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      disableContextMenu: true,
      cacheMode: widget.connected
          ? CacheMode.LOAD_NO_CACHE
          : CacheMode.LOAD_CACHE_ONLY);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (progress != 1)
          LinearProgressIndicator(
            value: progress,
          ),
        if (!error)
          Expanded(
              child: InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: WebUri(widget.uri.toString())),
            initialSettings: settings,
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onReceivedError: (controller, request, error) {
              showOkDialogue(context,
                  onConfirm: context.pop, content: error.description);
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
    );
  }
}
