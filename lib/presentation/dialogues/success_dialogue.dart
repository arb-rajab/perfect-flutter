import 'package:beta/constants/string_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showSuccessDialogue(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(StringConstant.success.tr()),
      showCloseIcon: true,
    ),
  );
}
