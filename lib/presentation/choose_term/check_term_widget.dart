import 'package:animated_digit/animated_digit.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/choose_term/choose_term_screen_controller.dart';
import 'package:beta/presentation/widgets/widget_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class CheckTermWidget extends StatelessWidget {
  final int index;

  const CheckTermWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    ChooseTermScreenController controller = Get.find();
    TermData termData = controller.items[index];
    BorderSide borderSide = BorderSide(color: Theme.of(context).primaryColor);
    return WidgetWrapper(
      child: Column(
        children: [
          if (controller.displayPath(index)) Text(termData.path!.value!),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border(
                    top: borderSide,
                    bottom: borderSide,
                    left: borderSide,
                    right: borderSide)),
            child: ListTile(
              onTap: !controller.itemsLoading[index]
                  ? () => controller.onTermClick(index)
                  : null,
              leading: const Icon(Icons.description),
              title: Text(termData.term.name),
              subtitle: termData.term.type == TermType.term
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          const Icon(Icons.description),
                          const Text('x'),
                          AnimatedDigitWidget(
                              value: termData.numberOfSubTerms!.value!)
                        ])
                  : null,
              trailing: controller.itemsLoading[index]
                  ? const CircularProgressIndicator()
                  : controller.showCheckBoxes()
                      ? Checkbox(
                          value: controller.isTermChecked(termData),
                          onChanged: (bool? value) =>
                              controller.checkTerm(termData, value))
                      : const Icon(Icons.navigate_next),
            ),
          )
        ],
      ),
    );
  }
}
