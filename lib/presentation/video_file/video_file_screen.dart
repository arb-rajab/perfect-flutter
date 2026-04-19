import 'package:beta/presentation/video_file/video_file_screen_controller.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:video_player/video_player.dart';

class VideoFileScreen extends StatefulWidget {
  static const String route = '/video-file';

  const VideoFileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _VideoFileScreenState();
}

class _VideoFileScreenState extends State<VideoFileScreen> {
  late VideoFileScreenController controller;

  @override
  void initState() {
    super.initState();
    Get.delete<VideoFileScreenController>();
    controller = Get.put(VideoFileScreenController(this));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      titleText: controller.argument.term.term.name,
      child: controller.loading
          ? const Center(child: LoadingWidget())
          : controller.isFullScreen
              ? _VideoPreview(controller: controller)
              : Column(
                  children: [
                    Expanded(
                      child: _VideoPreview(controller: controller),
                    ),
                    _VideoControls(controller: controller),
                  ],
                ),
    );
  }
}

// ---------------------------------------------------------------------------
// Video preview
// ---------------------------------------------------------------------------

class _VideoPreview extends StatelessWidget {
  final VideoFileScreenController controller;

  const _VideoPreview({required this.controller});

  @override
  Widget build(BuildContext context) {
    final vpc = controller.videoPlayerController;
    if (vpc == null || !vpc.value.isInitialized) {
      return const Center(child: NoBackgroundLogo());
    }
    return GestureDetector(
      onTap: controller.toggleFullScreen,
      child: Center(
        child: AspectRatio(
          aspectRatio: vpc.value.aspectRatio,
          child: VideoPlayer(vpc),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Controls: slider + time + buttons + speed
// ---------------------------------------------------------------------------

class _VideoControls extends StatelessWidget {
  final VideoFileScreenController controller;

  const _VideoControls({required this.controller});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: controller.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final duration =
            controller.videoPlayerController?.value.duration ?? Duration.zero;
        final maxSeconds = duration.inSeconds.toDouble();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Seek slider
            if (maxSeconds > 0)
              Slider(
                value: position.inSeconds.toDouble().clamp(0.0, maxSeconds),
                max: maxSeconds,
                onChanged: (v) => controller.seek(Duration(seconds: v.toInt())),
              )
            else
              const LinearProgressIndicator(),

            // Time label
            Text(
              '${_fmt(position)} / ${_fmt(duration)}',
              style: const TextStyle(fontSize: 13),
            ),

            const SizedBox(height: 8),

            // Transport buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.replay_10),
                  onPressed: controller.rewind,
                ),
                IconButton(
                  iconSize: 48,
                  icon: Icon(
                    controller.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                  ),
                  onPressed:
                      controller.isPlaying ? controller.pause : controller.play,
                ),
                IconButton(
                  icon: const Icon(Icons.forward_10),
                  onPressed: controller.forward,
                ),
                IconButton(
                  icon: const Icon(Icons.fullscreen),
                  onPressed: controller.toggleFullScreen,
                ),
              ],
            ),

            // Speed selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: controller.playbackSpeeds.map((speed) {
                  final selected = controller.playbackSpeed == speed;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text('${speed}x'),
                      selected: selected,
                      onSelected: (_) => controller.changeSpeed(speed),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  String _fmt(Duration d) =>
      '${d.inMinutes}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}';
}
