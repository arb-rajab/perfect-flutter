import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FormMessageWidget extends StatelessWidget {
  final Function onDismiss;
  final String message;

  const FormMessageWidget(
      {super.key, required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    if (message.isNotEmpty) {
      return OpacityAnimation(
        child: SingleChildScrollView(
          child: MaterialBanner(
            actions: [
              OutlinedButton(
                onPressed: () => onDismiss.call(),
                child: Text(StringConstant.ok.tr()),
              )
            ],
            content: Text(
              message,
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
