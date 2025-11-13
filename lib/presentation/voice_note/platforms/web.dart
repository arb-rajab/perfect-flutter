// ignore_for_file: invalid_use_of_protected_member

import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/voice_note_data.dart';
import 'package:beta/helper/encryption.dart';
import 'package:beta/helper/in_memory_audio_source.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/voice_note/voice_note_screen_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';

Future configurePlayer() async {
  VoiceNoteScreenController voiceNoteScreenController = Get.find();
  State state = voiceNoteScreenController.state;
  AudioPlayer audioPlayer = voiceNoteScreenController.audioPlayer;
  return NetworkService(
      onPreConnect: () =>
          state.setState(() => voiceNoteScreenController.loading = true),
      onPostConnect: () =>
          state.setState(() => voiceNoteScreenController.loading = false),
      onConnectionSucceed: (body) {
        VoiceNoteData voiceNoteData = VoiceNoteData.fromJson(body['voice']);
        String password = Encryption.decryptEncryptionKey(
            voiceNoteData.voiceNote.encryptionKey);
        String url = voiceNoteData.url!.toString();
        return NetworkService(
            onPreConnect: () =>
                state.setState(() => voiceNoteScreenController.loading = true),
            onPostConnect: () =>
                state.setState(() => voiceNoteScreenController.loading = false),
            onConnectionSucceed: (body) async {
              // Decode the archive in memory
              Uint8List fileBytes = body;
              InputStream inputStream = InputStream(fileBytes);
              Archive archive =
                  ZipDecoder().decodeBuffer(inputStream, password: password);
              ArchiveFile archiveFile = archive.first;

              // Use the archiveFile content directly
              Uint8List audioData = archiveFile.content as Uint8List;

              // Create a Blob URL to handle in-memory data for Web
              // Use modern web APIs for Blob and Object URL
              // final blob = Blob([audioData]);
              // final url = createObjectURL(blob);

              // Initialize the audio player
              // AudioPlayer audioPlayer = AudioPlayer();
              // Play the audio using an in-memory approach
              // Ensure your audio player supports in-memory playback
              final audioSource = InMemoryAudioSource(audioData);

              await audioPlayer.setAudioSource(audioSource);
              await audioPlayer.play();

              // revokeObjectURL(url);
            },
            onConnectionFailed: () => showOkDialogue(state.context,
                content: StringConstant.noConnection.tr()),
            onMessageReceived: (failureResponse) => showOkDialogue(
                state.context,
                content: failureResponse.content)).get(url: url);
      },
      onConnectionFailed: () => showOkDialogue(state.context,
          content: StringConstant.noConnection.tr()),
      onMessageReceived: (failureResponse) =>
          showOkDialogue(state.context, content: failureResponse.content)).get(
      url: ApiConstant.getVoice.replaceFirst('(TERM_ID)',
          voiceNoteScreenController.argument.term.term.id.toString()));
}
