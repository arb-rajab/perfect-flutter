import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showOkDialogue(BuildContext context, 
    {String? content,
    Function? onConfirm,
    Widget? contentWidget,
    String? okText,
    String? title}) async {
  // Show dialog returns a Future that completes when the dialog is dismissed.
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to dismiss
    builder: (BuildContext context) => OKDialogue(
        onConfirm: onConfirm,
        content: content,
        okText: okText,
        title: title,
        contentWidget: contentWidget),
  );
}

//TODO add test
class OKDialogue extends StatelessWidget {
  final Function? onConfirm;
  final String? content;
  final Widget? contentWidget;
  final String? okText;
  final String? title;
  const OKDialogue(
      {super.key,
      this.onConfirm,
      this.content,
      required this.okText,
      this.title,
      this.contentWidget});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: AlertDialog(
          title: title != null ? Text(title!) : null,
          content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
            content != null ? Text(content!) : contentWidget!
          ])),
          actions: <Widget>[
            TextButton(
                key: const Key('ok'),
                child: Text(okText ?? StringConstant.ok.tr()),
                onPressed: () {
                  context.pop();
                  onConfirm?.call();
                })
          ]),
    );
  }
}
