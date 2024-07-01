import 'package:beta/configs/style.dart';
import 'package:beta/constants/color_constant.dart';
import 'package:flutter/material.dart';

class QuizDetailWidget extends StatelessWidget {
  final String? parentTitle, title;
  final int correct, wrong, unanswered;

  const QuizDetailWidget(
      {super.key,
      required this.parentTitle,
      required this.title,
      required this.correct,
      required this.wrong,
      required this.unanswered});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            leading: const Icon(Icons.assessment),
            title: parentTitle != null || title != null
                ? Text(
                    parentTitle != null
                        ? parentTitle!
                        : title != null
                            ? title!
                            : '',
                    style: Theme.of(context).textTheme.headlineSmall)
                : null,
            subtitle: title != null
                ? Text(
                    title!,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                : null),
        Padding(
          padding: const EdgeInsets.all(halfMargin),
          child: Row(
            children: [
              Expanded(
                  flex: correct,
                  child: Text(
                    correct.toString(),
                    style: TextStyle(color: ColorConstant.darkGreen),
                  )),
              Expanded(
                  flex: wrong,
                  child: Text(
                    wrong.toString(),
                    style: const TextStyle(color: Colors.red),
                  )),
              Expanded(
                  flex: unanswered,
                  child: Text(
                    unanswered.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(halfMargin),
          child: Row(
            children: [
              Expanded(
                  flex: correct,
                  child: Container(
                    height: halfMargin,
                    color: ColorConstant.darkGreen,
                  )),
              Expanded(
                  flex: wrong,
                  child: Container(
                    height: halfMargin,
                    color: Colors.red,
                  )),
              Expanded(
                  flex: unanswered,
                  child: Container(
                    height: halfMargin,
                    color: Colors.grey,
                  ))
            ],
          ),
        )
      ],
    );
  }
}
