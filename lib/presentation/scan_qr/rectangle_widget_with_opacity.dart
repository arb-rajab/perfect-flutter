import 'package:beta/configs/style.dart';
import 'package:beta/presentation/widgets/rectangle_widget.dart';
import 'package:flutter/material.dart';

//TODO add test to check child exists
class RectangleWidgetWithOpacity extends StatelessWidget {
  final Widget child;

  const RectangleWidgetWithOpacity({super.key, required this.child});

  @override
  Widget build(BuildContext context) =>
      RectangleWidget(opacity: opacity, child: child);
}
