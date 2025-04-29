import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showConfirmationDialog(BuildContext context, Function onConfirm,
    {Widget? content}) async {
  // Show dialog returns a Future that completes when the dialog is dismissed.
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to dismiss
    builder: (BuildContext context) => ConfirmDialogue(
      onConfirm: onConfirm,
      content: content,
    ),
  );
}

class ConfirmDialogue extends StatelessWidget {
  final Function onConfirm;
  final Widget? content;
  const ConfirmDialogue({super.key, required this.onConfirm, this.content});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: AlertDialog(
        title: Text(StringConstant.confirmAction.tr()),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              if (content == null)
                Text(StringConstant.confirmActionExplanation.tr())
              else
                content!
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: context.pop,
            child: Text(StringConstant.cancel.tr()),
          ),
          TextButton(
            key: const Key('ok'),
            onPressed: () {
              context.pop();
              onConfirm.call();
            },
            child: Text(StringConstant.ok.tr()),
          ),
        ],
      ),
    );
  }
}
