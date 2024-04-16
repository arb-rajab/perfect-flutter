import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showYesNoDialogueDialog(BuildContext context,
    {required Function onYesClicked,
    required Function onNoClicked,
    required String title,
    required String description}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to dismiss
    builder: (BuildContext context) => YesNoDialogue(
      onNoClicked: onNoClicked,
      onYesClicked: onYesClicked,
      title: title,
      description: description,
    ),
  );
}

class YesNoDialogue extends StatelessWidget {
  final Function onYesClicked;
  final Function onNoClicked;
  final String title;
  final String description;
  const YesNoDialogue(
      {super.key,
      required this.onYesClicked,
      required this.onNoClicked,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(description),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(StringConstant.no.tr()),
            onPressed: () {
              Navigator.of(context).pop();
              onNoClicked.call();
            },
          ),
          TextButton(
            child: Text(StringConstant.yes.tr()),
            onPressed: () {
              Navigator.of(context).pop();
              onYesClicked.call();
            },
          ),
        ],
      ),
    );
  }
}
