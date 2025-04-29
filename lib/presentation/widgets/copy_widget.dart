import 'package:beta/infrastructure/clipboard_repository.dart';
import 'package:beta/presentation/dialogues/success_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class CopyWidget extends StatelessWidget {
  final String content;

  const CopyWidget({super.key, required this.content});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ClipboardRepository clipboardRepository = Get.find();
        clipboardRepository.setText(content);
        showSuccessDialogue(context);
      },
      icon: const Icon(
        Icons.copy,
      ),
    );
  }
}
