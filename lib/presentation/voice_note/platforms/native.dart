import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/helper/in_memory_audio_source.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future configurePlayer(
    {required BuildContext context,
    required String password,
    required AudioPlayer audioPlayer}) async {
  VoiceNoteScreenArgument argument = Get.find();

  // Fetch the file from the directory
  File file = File(join((await getApplicationSupportDirectory()).path,
      'term$separator${argument.term.term.id}'));
  InputFileStream inputStream = InputFileStream(file.path);

  // Decode the archive
  Archive archive = ZipDecoder().decodeBuffer(inputStream, password: password);
  ArchiveFile archiveFile = archive.first;

  // Use the content of the archive file as in-memory Uint8List
  Uint8List audioData = archiveFile.content as Uint8List;

  // Play the audio using an in-memory approach
  // Ensure your audio player supports in-memory playback
  final audioSource = InMemoryAudioSource(audioData);

  await audioPlayer.setAudioSource(audioSource);
  await audioPlayer.play();
}
