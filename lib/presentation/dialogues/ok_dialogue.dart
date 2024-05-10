import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showOkDialogue(
    BuildContext context, Function onConfirm, String content,
    {String? okText}) async {
  // Show dialog returns a Future that completes when the dialog is dismissed.
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to dismiss
    builder: (BuildContext context) =>
        OKDialogue(onConfirm: onConfirm, content: content, okText: okText),
  );
}

//TODO add test
class OKDialogue extends StatelessWidget {
  final Function onConfirm;
  final String content;
  final String? okText;
  const OKDialogue(
      {super.key,
      required this.onConfirm,
      required this.content,
      required this.okText});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: AlertDialog(
          // title: Text(StringConstant.confirmAction.tr()),
          content: SingleChildScrollView(
              child: ListBody(children: <Widget>[Text(content)])),
          actions: <Widget>[
            TextButton(
                child: Text(okText ?? StringConstant.ok.tr()),
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm.call();
                })
          ]),
    );
  }
}
