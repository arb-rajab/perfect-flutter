import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/voice_note_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/helper/encryption.dart';
import 'package:beta/helper/in_memory_audio_source.dart';
import 'package:beta/presentation/voice_note/voice_note_screen_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future configurePlayer() async {
  VoiceNoteService voiceNoteService = Get.find();
  VoiceNoteScreenController voiceNoteScreenController = Get.find();
  VoiceNote voiceNote = await voiceNoteService
      .getVoiceNote(voiceNoteScreenController.argument.term);
  String password = Encryption.decryptEncryptionKey(voiceNote.encryptionKey);
  VoiceNoteScreenArgument argument = Get.find();
  
  AudioPlayer audioPlayer = Get.find();

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
