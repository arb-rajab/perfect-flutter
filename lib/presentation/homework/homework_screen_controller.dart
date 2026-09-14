// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/homework_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/homework_submission_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class HomeworkScreenController {
  final State state;
  final HomeworkScreenArgument argument = Get.find();
  HomeworkService homeworkService = Get.find();
  List<HomeworkSubmissionData> submissions = [];
  bool loading = true;
  bool uploading = false;

  HomeworkScreenController(this.state) {
    WidgetsBinding.instance.addPostFrameCallback((_) => loadSubmissions());
  }

  void _onConnectionFailed() {
    if (state.mounted) {
      showOkDialogue(state.context, content: StringConstant.noConnection.tr());
    }
  }

  void _onMessageReceived(FailureResponse message) {
    if (state.mounted) {
      showOkDialogue(state.context, content: message.content);
    }
  }

  Future loadSubmissions() {
    return homeworkService.getSubmissions(
      termId: Id(argument.term.term.id),
      onPreConnect: () {
        if (state.mounted) state.setState(() => loading = true);
      },
      onPostConnect: () {
        if (state.mounted) state.setState(() => loading = false);
      },
      onSuccess: (data) async {
        if (state.mounted) state.setState(() => submissions = data);
      },
      onConnectionFailed: _onConnectionFailed,
      onMessageReceived: _onMessageReceived,
    );
  }

  Future pickAndUploadFile() async {
    const typeGroup = XTypeGroup(label: 'pdf', extensions: ['pdf']);
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file == null) return;

    await homeworkService.upload(
      termId: Id(argument.term.term.id),
      filePath: file.path,
      title: file.name,
      onPreConnect: () {
        if (state.mounted) state.setState(() => uploading = true);
      },
      onPostConnect: () {
        if (state.mounted) state.setState(() => uploading = false);
      },
      onSuccess: (_) async {
        if (state.mounted) {
          showOkDialogue(state.context,
              content: StringConstant.homeworkUploadedSuccessfully.tr());
        }
        await loadSubmissions();
      },
      onConnectionFailed: _onConnectionFailed,
      onMessageReceived: _onMessageReceived,
    );
  }
}
