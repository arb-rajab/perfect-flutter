import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/discussion/add_comment_widget.dart';
import 'package:beta/presentation/discussion/discussion_screen_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class DiscussionScreen extends StatefulWidget {
  static const String route = '/discussion/:itemType/:itemId';
  final String type;
  final String id;

  const DiscussionScreen({super.key, required this.type, required this.id});
  @override
  State<StatefulWidget> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  late DiscussionScreenController controller;

  @override
  void initState() {
    Get.delete<DiscussionScreenController>(tag: widget.type + widget.id);
    controller = Get.put(
        DiscussionScreenController(this, widget.type, widget.id),
        tag: widget.type + widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      titleText: StringConstant.commentsRelatedTo
          .tr()
          .replaceFirst('(TITLE)', controller.argument.itemName),
      child: Column(
        children: [
          Expanded(
            child: ItemsList(
              controller: controller,
            ),
          ),
          if (controller.argument.commentEnabled)
            AddCommentWidget(type: widget.type, id: widget.id)
        ],
      ),
    );
  }
}
