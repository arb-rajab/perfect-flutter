import 'package:beta/configs/colors.dart';
import 'package:beta/configs/style.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringLogo extends StatelessWidget {
  const ShimmeringLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: primaryColor,
          highlightColor: Colors.white,
          child: Container(
            margin: const EdgeInsets.all(halfMargin),
            child: Image.asset('images/no_background_logo.png'),
          )),
    );
  }
}
