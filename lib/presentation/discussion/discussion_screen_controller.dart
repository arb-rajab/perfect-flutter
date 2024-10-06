import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/comment.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/presentation/discussion/discuss_widget.dart';
import 'package:beta/presentation/widgets/list_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class DiscussionScreenController extends ListController {
  DiscussionScreenArgument argument=Get.find();
  TextEditingController submitController = TextEditingController();
  bool submitting = false;

  DiscussionScreenController(State state, String type, String id)
      : super(
          itemBuilder: (context, index) => const Center(),
          state: state,
          plural: 'comments',
          indexUrl: '',
          fetch: null,
          fromJson: Comment.fromJson,
        ) ;

  @override
  Widget Function(BuildContext p1, int p2) get itemBuilder => (context, index) {
        return DiscussWidget(comment: items[index]);
      };

  @override
  String? get indexUrl => ApiConstant.getComments
      .replaceFirst('(ITEM_TYPE)', argument.itemType)
      .replaceFirst('(ITEM_ID)', argument.itemId.toString());

  void submitComment() {
    if (submitController.text.isEmpty) return;
    if (submitting) return;
    NetworkService(
      state.context,
      onPreConnect: () => state.setState(() => submitting = true),
      onPostConnect: () => state.setState(() => submitting = false),
      onMessageReceived: (FailureResponse message) =>
          state.context.showErrorBar(content: Text(message.content)),
      onConnectionFailed: () => state.context
          .showErrorBar(content: Text(StringConstant.noConnection.tr())),
      onConnectionSucceed: (body) {
        Comment comment = Comment.fromJson(body['comment']);
        state.setState(() {
          items.add(comment);
          submitController.clear();
        });
      },
    ).post(url: ApiConstant.submitComment, body: {
      'content': submitController.text,
      'itemId': argument.itemId,
      'itemType': argument.itemType
    });
  }
}
