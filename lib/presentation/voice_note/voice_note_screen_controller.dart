import 'package:audio_service/audio_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/path/shared.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/application/services/voice_note_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/presentation/voice_note/platforms/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';

class VoiceNoteScreenController {
  final State state;
  final VoiceNoteScreenArgument argument = Get.find();
  AudioHandler audioHandler = Get.find();
  AudioPlayer audioPlayer = Get.find();
  double playbackSpeed = 1.0;
  final List<double> playbackSpeeds = [
    0.25,
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    1.75,
    2.0
  ];

  PackageRepository packageRepository = Get.find();
  TermLastAccessService termLastAccessService = Get.find();

  VoiceNoteScreenController(this.state) {
    _initAudioService();
  }

  Future<void> _initAudioService() async {
    VoiceNoteService voiceNoteService = Get.find();
    VoiceNote voiceNote = await voiceNoteService.getVoiceNote(argument.term);
    String password = _decryptEncryptionKey(voiceNote.encryptionKey);

    if (state.mounted) {
      await configurePlayer(
          context: state.context, password: password, audioPlayer: audioPlayer);
    }
    int second = await getLastSecond() ?? 0;
    audioHandler.play();
    audioHandler.seek(Duration(seconds: second));
    // state.setState(() {});
  }

  void rewind() {
    final newPosition = audioPlayer.position - const Duration(seconds: 10);
    audioPlayer.seek(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  void forward() {
    final newPosition = audioPlayer.position + const Duration(seconds: 10);
    audioPlayer.seek(newPosition > audioPlayer.duration!
        ? audioPlayer.duration!
        : newPosition);
  }

  void changeSpeed(double speed) {
    state.setState(() {
      playbackSpeed = speed;
      audioPlayer.setSpeed(playbackSpeed);
    });
  }

  Future<int?> getLastSecond() async {
    VoiceNoteScreenController voiceNoteScreenController = Get.find();
    TermsLastAccess? termsLastAccess = await voiceNoteScreenController
        .termLastAccessService
        .getTermLastAccess(voiceNoteScreenController.argument.term.term.id);
    if (termsLastAccess == null) return null;
    return termsLastAccess.childId;
  }

  void play() => audioHandler.play();

  void pause() => audioHandler.pause();

  String _decryptEncryptionKey(String encryptionKey) {
    List<int> fibonacci = [];
    fibonacci.add(1);
    fibonacci.add(2);
    String password = "";
    if (encryptionKey.isNotEmpty) {
      while (fibonacci[fibonacci.length - 1] < encryptionKey.length - 1) {
        fibonacci.add(
            fibonacci[fibonacci.length - 1] + fibonacci[fibonacci.length - 2]);
      }
      for (int c = 0; c < fibonacci.length; c++) {
        password = "$password${encryptionKey[fibonacci[c]]}";
      }
    }
    return password;
  }
}

class AudioPlayerHandler extends BaseAudioHandler {
  final AudioPlayer _audioPlayer;
  TermLastAccessService termLastAccessService = Get.find();

  AudioPlayerHandler(this._audioPlayer) {
    _init();
  }

  Future<void> _init() async {
    _audioPlayer.playbackEventStream.listen((event) {
      playbackState.add(_transformEvent(event));
    });
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        _audioPlayer.playing ? MediaControl.pause : MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward
      ],
      systemActions: {
        MediaAction.seek,
      },
      androidCompactActionIndices: [0, 1, 2],
      processingState: {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_audioPlayer.processingState]!,
      playing: _audioPlayer.playing,
      updatePosition: _audioPlayer.position,
      bufferedPosition: _audioPlayer.bufferedPosition,
      speed: _audioPlayer.speed,
      queueIndex: 0,
    );
  }

  @override
  Future<void> play() => _audioPlayer.play();

  @override
  Future<void> pause() async {
    VoiceNoteScreenController voiceNoteScreenController = Get.find();
    await _audioPlayer.pause();
    await termLastAccessService.addTermLastAccessed(
        Id(voiceNoteScreenController.argument.term.term.id),
        Id(_audioPlayer.position.inSeconds));
  }

  @override
  Future<void> stop() async {
    VoiceNoteScreenController voiceNoteScreenController = Get.find();
    await termLastAccessService.addTermLastAccessed(
        Id(voiceNoteScreenController.argument.term.term.id),
        Id(_audioPlayer.position.inSeconds));
    await _audioPlayer.stop();
    await super.stop();
  }

  @override
  Future<void> onTaskRemoved() async {
    await stop();
    super.onTaskRemoved();
  }

  @override
  Future<void> rewind() async {
    final newPosition = _audioPlayer.position - const Duration(seconds: 10);
    await _audioPlayer
        .seek(newPosition < Duration.zero ? Duration.zero : newPosition);
    // await super.rewind();
  }

  @override
  Future<void> fastForward() async {
    final newPosition = _audioPlayer.position + const Duration(seconds: 10);
    await _audioPlayer.seek(newPosition > _audioPlayer.duration!
        ? _audioPlayer.duration!
        : newPosition);
    await super.fastForward();
  }

  @override
  Future<void> seek(Duration position) => _audioPlayer.seek(position);
}
