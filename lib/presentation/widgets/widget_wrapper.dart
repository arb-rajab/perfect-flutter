import 'package:beta/configs/style.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:flutter/material.dart';

class WidgetWrapper extends StatelessWidget {
  final Widget child;
  const WidgetWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
        child: Padding(padding: const EdgeInsets.all(margin), child: child));
  }
}
