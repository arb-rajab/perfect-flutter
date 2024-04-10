import 'package:beta/configs/style.dart';
import 'package:flutter/material.dart';

//TODO apply test
class WarningWidget extends StatelessWidget {
  final String text;

  const WarningWidget({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(margin),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
