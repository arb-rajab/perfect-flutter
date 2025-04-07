import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/helper/in_memory_audio_source.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

Future configurePlayer(
    {required BuildContext context,
    required String password,
    required AudioPlayer audioPlayer}) async {
  // Use a network-based or alternative way to get the file
  //TODO
  String fileUrl = 'your_file_url_here'; // File should be accessible via a URL
  return NetworkService(context, onPreConnect: () {}, onPostConnect: () {},
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
  }, onConnectionFailed: () {}, onMessageReceived: (FailureResponse message) {})
      .get(url: fileUrl);
}
