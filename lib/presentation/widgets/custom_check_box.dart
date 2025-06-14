import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String? label;
  final Widget? labelWidget;
  final bool checked;
  final void Function(bool? value) onChanged;

  const CustomCheckbox(
      {super.key,
      this.label,
      required this.checked,
      this.labelWidget,
      required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Checkbox(
          value: checked,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Flexible(
            child: GestureDetector(
          onTap: () => onChanged(!checked),
          child: label != null ? Text(label!) : labelWidget!,
        ))
      ],
    );
  }
}
