import 'package:beta/configs/style.dart';
import 'package:beta/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OpacityAnimation extends StatefulWidget {
  final Widget child;
  const OpacityAnimation({super.key, required this.child});

  @override
  State<OpacityAnimation> createState() => _OpacityAnimationState();
}

class _OpacityAnimationState extends State<OpacityAnimation> {
  double _opacity = 0;

  @override
  void initState() {
    if (!MainController.testing) {
      Future.delayed(Duration.zero, () {
        if (mounted) setState(() => _opacity = 1);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (MainController.testing) return widget.child;
    return AnimatedOpacity(
        opacity: _opacity, duration: animationDuration, child: widget.child);
  }
}
