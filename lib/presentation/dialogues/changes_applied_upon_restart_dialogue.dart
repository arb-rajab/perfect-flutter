import 'package:beta/constants/string_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showChangesAppliedUponRestartDialogue(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) =>
          const ChangesAppliedUponRestartDialogue());
}

class ChangesAppliedUponRestartDialogue extends StatelessWidget {
  const ChangesAppliedUponRestartDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(StringConstant.changesWillBeAppliedUponRestart.tr()),
      actions: [
        TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(StringConstant.ok.tr()))
      ],
    );
  }
}
