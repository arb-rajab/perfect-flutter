import 'package:beta/application/services/user_service.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/comment.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/discussion/discussion_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class DiscussWidget extends StatelessWidget {
  final Comment comment;

  const DiscussWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    UserService userService = Get.find();
    bool isDeviceOwner() {
      return (comment.device != null &&
          userService.getId() != null &&
          comment.device!.id == Id(int.parse(userService.getId()!)));
    }

    return Container(
      margin: const EdgeInsets.all(margin),
      padding: const EdgeInsets.all(margin),
      child: Column(
        crossAxisAlignment:
            isDeviceOwner() ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.all(margin),
            padding: const EdgeInsets.all(margin),
            child: Text(
              isDeviceOwner()
                  ? StringConstant.you.tr()
                  : comment.device != null
                      ? comment.device!.name.name.value!
                      : comment.admin!.username.value!,
              style: TextStyle(
                  color: comment.admin != null
                      ? Theme.of(context).primaryColorDark
                      : null),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(halfMargin),
            padding: const EdgeInsets.all(margin),
            decoration: BoxDecoration(
                color: isDeviceOwner()
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(halfMargin)),
            child: Text(
              comment.content.value!,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.delete<DiscussionScreenArgument>();
              Get.put(DiscussionScreenArgument(
                  itemId: comment.id.value!,
                  itemType: "comment",
                  itemName: comment.content.value!,
                  commentEnabled: false));
              if (MainController.testing) return;
              context.push(DiscussionScreen.route
                  .replaceFirst(':itemType', 'comment')
                  .replaceFirst(':itemId', comment.id.value!.toString()));
            },
            child: Text(
              StringConstant.numberOfSubcomments.tr().replaceFirst(
                  'SUBCOMMENTS', comment.numberOfComments.value!.toString()),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }
}
