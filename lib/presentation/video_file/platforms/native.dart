import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/video_file_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/helper/encryption.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/video_file/video_file_screen_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

Future<ConfigurePlayerResult> configurePlayer() async {
  if (MainController.testing) {
    final mockFile = File(
        join(Directory.current.path, 'test', 'assets', 'videos', 'bee.mp4'));
    final vpc = VideoPlayerController.file(mockFile);
    return (controller: vpc, tempFile: null);
  }

  VideoFileService videoFileService = Get.find();
  VideoFileScreenController videoFileScreenController = Get.find();
  VideoFile videoFile = await videoFileService
      .getVideoFile(videoFileScreenController.argument.term);
  String password = Encryption.decryptEncryptionKey(videoFile.encryptionKey);
  VideoFileScreenArgument argument = Get.find();

  final supportDir = (await getApplicationSupportDirectory()).path;
  final extractedFile =
      File(join(supportDir, 'term', '${argument.term.term.id}_video'));

  File zipFile = File(join(supportDir, 'term', '${argument.term.term.id}'));
  InputFileStream inputStream = InputFileStream(zipFile.path);

  Archive archive = ZipDecoder().decodeBuffer(inputStream, password: password);
  ArchiveFile archiveFile = archive.files.firstWhere(
    (f) => f.isFile,
    orElse: () => throw Exception(
      'Zip archive is empty or contains no files. '
      'Entries found: ${archive.files.length}',
    ),
  );

  await extractedFile.writeAsBytes(archiveFile.content, flush: true);

  final videoPlayerController = VideoPlayerController.file(extractedFile);
  await videoPlayerController.initialize();

  return (
    controller: videoPlayerController,
    tempFile: extractedFile,
  );
}
