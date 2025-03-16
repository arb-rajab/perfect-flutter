import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:beta/constants/arguments.dart';
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
  File temp;
  File file = File(join((await getApplicationSupportDirectory()).path,
      'term$separator${argument.term.term.id}'));
  InputFileStream inputStream = InputFileStream(file.path);
  Archive archive = ZipDecoder().decodeBuffer(inputStream, password: password);
  ArchiveFile archiveFile = archive.first;
  temp = File('${(await getApplicationCacheDirectory()).path}${separator}temp');
  if (temp.existsSync()) await temp.delete();
  OutputFileStream outputFileStream = OutputFileStream(temp.path);
  archiveFile.writeContent(outputFileStream);
  await audioPlayer.setFilePath(
    temp.path,
  );
}
