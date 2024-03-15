import 'package:beta/configs/style.dart';
import 'package:beta/constants/image_constant.dart';
import 'package:flutter/material.dart';

class NoBackgroundLogo extends StatelessWidget {
  const NoBackgroundLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(halfMargin),
        child: Image.asset(ImageConstant.noBackgroundImage));
  }
}
