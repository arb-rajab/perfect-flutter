import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/widgets/input_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showUserNoteDialogue(
    BuildContext context, QuestionData questionData) async {
  // Show dialog returns a Future that completes when the dialog is dismissed.
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => UserNoteDialogue(questionData),
  );
}

class UserNoteDialogue extends StatelessWidget {
  final QuestionData questionData;
  const UserNoteDialogue(
    this.questionData, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController =
        TextEditingController(text: questionData.getUserNote());
    return OpacityAnimation(
      child: AlertDialog(
          content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
            InputWidget(
              label: StringConstant.enterNote.tr(),
              controller: textEditingController,
              maxLines: 3,
            ),
          ])),
          actions: <Widget>[
            TextButton(
                child: ListTile(
                    leading: const Icon(Icons.save),
                    title: Text(StringConstant.save.tr())),
                onPressed: () async {
                  await questionData.setUserNote(textEditingController.text);
                  if (context.mounted) context.pop();
                }),
            TextButton(
                child: ListTile(
                    tileColor: Theme.of(context).colorScheme.secondary,
                    leading: const Icon(Icons.delete),
                    title: Text(StringConstant.delete.tr())),
                onPressed: () async {
                  await questionData.deleteUserNote();
                  if (context.mounted) context.pop();
                })
          ]),
    );
  }
}
