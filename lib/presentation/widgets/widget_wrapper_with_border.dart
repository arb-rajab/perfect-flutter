import 'package:beta/configs/style.dart';
import 'package:beta/presentation/widgets/widget_wrapper.dart';
import 'package:flutter/material.dart';

class WidgetWrapperWithBorder extends StatelessWidget {
  final Widget child;
  const WidgetWrapperWithBorder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    BorderSide borderSide = BorderSide(color: Theme.of(context).primaryColor);
    return WidgetWrapper(
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context)
                    .primaryColor
                    .withOpacity(opacity as double),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border(
                top: borderSide,
                bottom: borderSide,
                left: borderSide,
                right: borderSide)),
        child: child,
      ),
    );
  }
}
