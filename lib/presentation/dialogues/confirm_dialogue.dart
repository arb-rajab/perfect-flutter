import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showConfirmationDialog(
    BuildContext context, Function onConfirm) async {
  // Show dialog returns a Future that completes when the dialog is dismissed.
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to dismiss
    builder: (BuildContext context) => ConfirmDialogue(
      onConfirm: onConfirm,
    ),
  );
}

class ConfirmDialogue extends StatelessWidget {
  final Function onConfirm;
  const ConfirmDialogue({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: AlertDialog(
        title: Text(StringConstant.confirmAction.tr()),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(StringConstant.confirmActionExplanation.tr()),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(StringConstant.cancel.tr()),
            onPressed: () {
              // Dismiss the dialog and return false
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(StringConstant.ok.tr()),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm.call();
            },
          ),
        ],
      ),
    );
  }
}
