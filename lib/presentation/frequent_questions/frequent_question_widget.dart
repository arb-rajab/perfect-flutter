import 'package:beta/configs/style.dart';
import 'package:beta/domain/frequent_question.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/frequent_questions/frequest_questions_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FrequentQuestionWidget extends StatefulWidget {
  final int index;
  const FrequentQuestionWidget({super.key, required this.index});

  @override
  State<FrequentQuestionWidget> createState() => _FrequentQuestionWidgetState();
}

class _FrequentQuestionWidgetState extends State<FrequentQuestionWidget> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    FrequestQuestionsScreenController controller = Get.find();
    FrequentQuestion frequentQuestion =
        controller.items[widget.index];
    return OpacityAnimation(
      child: Padding(
        padding: const EdgeInsets.all(margin),
        child: ExpansionPanelList(
          expansionCallback: (index, isExpanded) =>
              setState(() => _isExpanded = isExpanded),
          children: [
            ExpansionPanel(
                isExpanded: _isExpanded,
                headerBuilder: (_, __) => Text(frequentQuestion.title.value!),
                body: Text(frequentQuestion.description.value!))
          ],
        ),
      ),
    );
  }
}
