import 'package:beta/presentation/voice_note/voice_note_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class PlayerButtons extends StatelessWidget {
  PlayerButtons({super.key});
  final VoiceNoteScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.replay_10),
          onPressed: controller.rewind,
        ),
        if (!controller.audioHandler.playbackState.value.playing)
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: controller.play,
          )
        else
          IconButton(
            icon: const Icon(Icons.pause),
            onPressed: controller.pause,
          ),
        IconButton(
          icon: const Icon(Icons.forward_10),
          onPressed: controller.forward,
        ),
        DropdownButton<double>(
          value: controller.playbackSpeed,
          items: controller.playbackSpeeds.map((double value) {
            return DropdownMenuItem<double>(
              value: value,
              child: Text('${value}x'),
            );
          }).toList(),
          onChanged: (double? newValue) {
            if (newValue != null) {
              controller.changeSpeed(newValue);
            }
          },
        ),
      ],
    );
  }
}
