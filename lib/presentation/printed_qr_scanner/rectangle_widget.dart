import 'package:beta/configs/style.dart';
import 'package:flutter/material.dart';

//TODO add test to check child exists
class RectangleWidget extends StatelessWidget {
  final Widget child;

  const RectangleWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(margin),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color:
                Theme.of(context).scaffoldBackgroundColor.withAlpha(opacity)),
        child: child);
  }
}
