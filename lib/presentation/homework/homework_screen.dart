import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/homework_submission_data.dart';
import 'package:beta/presentation/homework/homework_screen_controller.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class HomeworkScreen extends StatefulWidget {
  static const String route = '/homework';

  const HomeworkScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  late HomeworkScreenController controller;

  @override
  void initState() {
    Get.delete<HomeworkScreenController>();
    controller = Get.put(HomeworkScreenController(this));
    super.initState();
  }

  String _statusLabel(HomeworkSubmissionData submission) {
    if (submission.isApproved) return StringConstant.homeworkStatusApproved.tr();
    if (submission.isRejected) return StringConstant.homeworkStatusRejected.tr();
    return StringConstant.homeworkStatusPending.tr();
  }

  Color _statusColor(HomeworkSubmissionData submission, BuildContext context) {
    if (submission.isApproved) return Colors.green;
    if (submission.isRejected) return Theme.of(context).colorScheme.error;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      titleText: controller.argument.term.term.name,
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('uploadHomework'),
        onPressed: controller.uploading ? null : controller.pickAndUploadFile,
        icon: controller.uploading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2))
            : const Icon(Icons.upload_file),
        label: Text(StringConstant.uploadHomework.tr()),
      ),
      child: controller.loading
          ? const LoadingWidget()
          : controller.submissions.isEmpty
              ? Center(
                  child: Text(StringConstant.noHomeworkSubmissionsYet.tr()))
              : ListView.builder(
                  itemCount: controller.submissions.length,
                  itemBuilder: (context, index) {
                    HomeworkSubmissionData submission =
                        controller.submissions[index];
                    final hasReviewNote = submission.reviewNote != null &&
                        submission.reviewNote!.isNotEmpty;
                    final hasMark =
                        submission.mark != null && submission.mark!.isNotEmpty;
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(submission.title ??
                            'homework-${submission.id}'),
                        subtitle: !hasReviewNote && !hasMark
                            ? null
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (hasReviewNote)
                                    Text(
                                        '${StringConstant.homeworkReviewNote.tr()}: ${submission.reviewNote}'),
                                  if (hasMark)
                                    Text(
                                        '${StringConstant.homeworkMark.tr()}: ${submission.mark}'),
                                ],
                              ),
                        trailing: Chip(
                          label: Text(_statusLabel(submission)),
                          backgroundColor:
                              _statusColor(submission, context).withValues(alpha: 0.15),
                          labelStyle:
                              TextStyle(color: _statusColor(submission, context)),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
