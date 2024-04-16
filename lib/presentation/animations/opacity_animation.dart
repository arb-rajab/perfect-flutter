import 'package:beta/configs/style.dart';
import 'package:flutter/material.dart';

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
    Future.delayed(Duration.zero, () => setState(() => _opacity = 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: _opacity, duration: animationDuration, child: widget.child);
  }
}
