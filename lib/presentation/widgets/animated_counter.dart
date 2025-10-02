import 'package:animated_number/animated_number.dart';
import 'package:beta/configs/style.dart';
import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final int value;
  const AnimatedCounter({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return AnimatedNumber(
        startValue: 0,
        endValue: value,
        duration: animationDuration,
        isFloatingPoint: false);
  }
}
