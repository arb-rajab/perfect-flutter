import 'package:beta/configs/style.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:flutter/material.dart';

class RectangleWidget extends StatelessWidget {
  final Widget child;
  final int opacity;

  const RectangleWidget({super.key, required this.child, this.opacity = 255});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: Container(
          padding: const EdgeInsets.all(margin),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color:
                  Theme.of(context).scaffoldBackgroundColor.withAlpha(opacity)),
          child: child),
    );
  }
}
