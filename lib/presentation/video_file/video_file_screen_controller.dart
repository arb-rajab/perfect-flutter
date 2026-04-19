import 'dart:async';

import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/presentation/video_file/platforms/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:video_player/video_player.dart';

typedef ConfigurePlayerFn = Future<ConfigurePlayerResult> Function();

/// Returned by [configurePlayer] on all platforms.
typedef ConfigurePlayerResult = ({
  VideoPlayerController controller,
  dynamic tempFile, // File on native, null on web
});

class VideoFileScreenController {
  final State state;
  final VideoFileScreenArgument argument = Get.find();
  final TermLastAccessService termLastAccessService = Get.find();

  VideoPlayerController? videoPlayerController;
  dynamic _tempVideoFile; // File on native, null on web

  bool loading = true;
  bool isPlaying = false;
  bool isFullScreen = false;
  double playbackSpeed = 1.0;

  final List<double> playbackSpeeds = [
    0.25,
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    1.75,
    2.0,
  ];

  // Broadcasts the current playback position every ~200 ms.
  final StreamController<Duration> _positionController =
      StreamController<Duration>.broadcast();
  Stream<Duration> get positionStream => _positionController.stream;

  Timer? _positionTimer;

  // -------------------------------------------------------------------------
  // Construction / initialisation
  // -------------------------------------------------------------------------

  VideoFileScreenController(this.state) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  Future<void> _init() async {
    _setLoading(true);
    try {
      final result = await configurePlayer();
      videoPlayerController = result.controller;
      _tempVideoFile = result.tempFile;

      // Restore last position
      final lastSecond = await getLastSecond();
      if (lastSecond != null && lastSecond > 0) {
        await videoPlayerController!.seekTo(Duration(seconds: lastSecond));
      }

      await videoPlayerController!.setPlaybackSpeed(playbackSpeed);

      // Listen for natural completion
      videoPlayerController!.addListener(_onPlayerStateChanged);

      // Start position polling
      _positionTimer = Timer.periodic(const Duration(milliseconds: 200), (_) {
        if (videoPlayerController != null) {
          _positionController.add(videoPlayerController!.value.position);
        }
      });

      _setLoading(false);
      play();
    } catch (e) {
      _setLoading(false);
      debugPrint('VideoFileScreenController._init error: $e');
    }
  }

  // -------------------------------------------------------------------------
  // Playback controls
  // -------------------------------------------------------------------------

  void play() {
    videoPlayerController?.play();
    _setPlaying(true);
  }

  Future<void> pause() async {
    await videoPlayerController?.pause();
    _setPlaying(false);
    await _savePosition();
  }

  void rewind() {
    if (videoPlayerController == null) return;
    final cur = videoPlayerController!.value.position;
    final next = cur - const Duration(seconds: 10);
    videoPlayerController!.seekTo(next < Duration.zero ? Duration.zero : next);
  }

  void forward() {
    if (videoPlayerController == null) return;
    final cur = videoPlayerController!.value.position;
    final dur = videoPlayerController!.value.duration;
    final next = cur + const Duration(seconds: 10);
    videoPlayerController!.seekTo(next > dur ? dur : next);
  }

  void seek(Duration position) {
    videoPlayerController?.seekTo(position);
  }

  void changeSpeed(double speed) {
    // ignore: invalid_use_of_protected_member
    state.setState(() {
      playbackSpeed = speed;
      videoPlayerController?.setPlaybackSpeed(speed);
    });
  }

  void toggleFullScreen() {
    // ignore: invalid_use_of_protected_member
    state.setState(() => isFullScreen = !isFullScreen);
  }

  // -------------------------------------------------------------------------
  // Last-position persistence
  // -------------------------------------------------------------------------

  Future<int?> getLastSecond() async {
    final termsLastAccess =
        await termLastAccessService.getTermLastAccess(argument.term.term.id);
    return termsLastAccess?.childId;
  }

  Future<void> _savePosition() async {
    if (videoPlayerController == null) return;
    final seconds = videoPlayerController!.value.position.inSeconds;
    await termLastAccessService.addTermLastAccessed(
      Id(argument.term.term.id),
      seconds,
    );
  }

  // -------------------------------------------------------------------------
  // Internal helpers
  // -------------------------------------------------------------------------

  void _onPlayerStateChanged() {
    final vpc = videoPlayerController;
    if (vpc == null) return;

    // Sync isPlaying flag with the actual player state
    if (isPlaying != vpc.value.isPlaying) {
      _setPlaying(vpc.value.isPlaying);
    }

    // Auto-save when playback finishes naturally
    if (vpc.value.position >= vpc.value.duration && !vpc.value.isPlaying) {
      _savePosition();
    }
  }

  void _setLoading(bool value) {
    // ignore: invalid_use_of_protected_member
    state.setState(() => loading = value);
  }

  void _setPlaying(bool value) {
    // ignore: invalid_use_of_protected_member
    state.setState(() => isPlaying = value);
  }

  // -------------------------------------------------------------------------
  // Cleanup
  // -------------------------------------------------------------------------

  Future<void> dispose() async {
    _positionTimer?.cancel();
    await _savePosition();
    videoPlayerController?.removeListener(_onPlayerStateChanged);
    await videoPlayerController?.dispose();
    await (_tempVideoFile?.delete() as Future?);
    await _positionController.close();
  }
}
