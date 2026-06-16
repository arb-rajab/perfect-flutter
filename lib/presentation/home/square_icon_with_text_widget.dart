import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:flutter/material.dart';

class SquareIconWithTextWidget extends StatelessWidget {
  const SquareIconWithTextWidget({
    super.key,
    required this.iconData,
    required this.text,
    required this.onTap,
  });

  final IconData iconData;
  final String text;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: WidgetWrapperWithBorder(
        child: Center(
          child: Column(
            children: [
              Icon(iconData, color: Theme.of(context).primaryColor),
              Text(text, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
