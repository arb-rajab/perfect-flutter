import 'package:beta/presentation/voice_note/player_buttons.dart';
import 'package:beta/presentation/voice_note/voice_note_screen_controller.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class VoiceNoteScreen extends StatefulWidget {
  static const String route = '/voice-note';

  const VoiceNoteScreen({super.key});

  @override
  State<StatefulWidget> createState() => _VoiceNoteScreenState();
}

class _VoiceNoteScreenState extends State<VoiceNoteScreen> {
  late VoiceNoteScreenController controller;

  @override
  void initState() {
    Get.delete<VoiceNoteScreenController>();
    controller = Get.put(VoiceNoteScreenController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      titleText: controller.argument.term.term.name,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Expanded(child: NoBackgroundLogo()),
            controller.loading
                ? const LoadingWidget()
                :
            StreamBuilder<Duration>(
              stream: controller.audioPlayer.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final duration =
                    controller.audioPlayer.duration ?? Duration.zero;
                return Column(
                  children: [
                    Slider(
                      value: position.inSeconds.toDouble(),
                      max: duration.inSeconds.toDouble(),
                      onChanged: (value) {
                        controller.audioPlayer
                            .seek(Duration(seconds: value.toInt()));
                      },
                    ),
                    Text(
                        '${position.inMinutes}:${position.inSeconds.remainder(60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}'),
                    PlayerButtons()
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
