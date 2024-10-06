import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/discussion/discussion_screen_controller.dart';
import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

// ignore: must_be_immutable
class AddCommentWidget extends StatelessWidget {
  final String type;
  final String id;
  AddCommentWidget({super.key, required this.type, required this.id});
  late DiscussionScreenController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.find(tag: type + id);
    return Container(
        padding: const EdgeInsets.all(halfMargin),
        margin: const EdgeInsets.all(halfMargin),
        color: Theme.of(context).primaryColorLight,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration:
                    InputDecoration(hintText: StringConstant.addComment.tr()),
                controller: controller.submitController,
              ),
            ),
            WidgetWrapperWithBorder(
              child: IconButton(
                  onPressed: controller.submitComment,
                  icon: controller.submitting
                      ? CircularProgressIndicator(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        )
                      : Icon(
                          Icons.send,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        )),
            )
          ],
        ));
  }
}
