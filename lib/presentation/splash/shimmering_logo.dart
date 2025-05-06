import 'package:beta/main_controller.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringLogo extends StatelessWidget {
  const ShimmeringLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
          loop: MainController.testing ? 1 : 0,
          baseColor: Theme.of(context).primaryColor,
          highlightColor: Theme.of(context).primaryColorLight,
          child: const NoBackgroundLogo()),
    );
  }
}
