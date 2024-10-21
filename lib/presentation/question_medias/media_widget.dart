import 'package:beta/application/services/database_service.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

class MediaWidget extends StatefulWidget {
  final QuestionMedia questionMedia;
  const MediaWidget({super.key, required this.questionMedia});

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  double progress = 0;
  bool error = false;
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
            initialUrlRequest:
                URLRequest(url: WebUri(widget.questionMedia.url)),
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
