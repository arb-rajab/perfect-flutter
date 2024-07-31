import 'package:beta/presentation/dialogues/success_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyWidget extends StatelessWidget {
  final String content;

  const CopyWidget({super.key, required this.content});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: content));
        showSuccessDialogue(context);
      },
      icon: const Icon(
        Icons.copy,
      ),
    );
  }
}
