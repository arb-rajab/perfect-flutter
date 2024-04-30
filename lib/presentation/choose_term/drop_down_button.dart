import 'package:beta/domain/multi_select_selection.dart';
import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:flutter/material.dart';

class DropDownButton extends StatelessWidget {
  final String label;
  final int selectionId;
  final List<MultiSelectSelection> selections;
  final Function(dynamic) onChanged;
  const DropDownButton(
      {super.key,
      required this.label,
      required this.selectionId,
      required this.selections,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          WidgetWrapperWithBorder(
              child: DropdownButton(
            value: selectionId,
            items: selections
                .map((e) => DropdownMenuItem(
                    value: e.id.value, child: Text(e.title.value!)))
                .toList(),
            onChanged: onChanged,
          )),
          const SizedBox(
            height: 30,
          ),
        ]);
  }
}
