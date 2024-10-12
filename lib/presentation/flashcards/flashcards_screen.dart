import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/flashcards/flashcards_screen_controller.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/instance_manager.dart';

class FlashcardsScreen extends StatefulWidget {
  static const String route = '/flashcards';
  const FlashcardsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  late FlashcardsScreenController controller;

  @override
  void initState() {
    Get.delete<FlashcardsScreenController>();
    controller = Get.put(FlashcardsScreenController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        titleText: controller.argument.title,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${controller.currentIndex + 1}/${controller.flashcards.length}',
              style: const TextStyle(fontSize: 20.0),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.flashcards.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  bool isFront = controller.flashcards[index].isFront;
                  return GestureDetector(
                    onTap: () => controller.flipCard(index),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return RotationYTransition(
                            turns: animation, child: child);
                      },
                      child: isFront
                          ? Card(
                              key: ValueKey<bool>(isFront),
                              child: Center(
                                  child: Text(controller
                                      .flashcards[index].flashcard.head)),
                            )
                          : Card(
                              key: ValueKey<bool>(isFront),
                              child: Center(
                                  child: Html(
                                      data: controller
                                          .flashcards[index].flashcard.tail)),
                            ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (controller.previousButtonVisible())
                  ElevatedButton(
                    onPressed: controller.previousFlashcard,
                    child: Text(StringConstant.previous.tr()),
                  )
                else
                  const SizedBox(),
                if (controller.nextFlashcardVisible())
                  ElevatedButton(
                    onPressed: controller.nextFlashcard,
                    child: Text(StringConstant.next.tr()),
                  )
                else
                  const SizedBox(),
              ],
            ),
          ],
        ));
  }
}

class RotationYTransition extends AnimatedWidget {
  const RotationYTransition(
      {super.key, required Animation<double> turns, this.child})
      : super(listenable: turns);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Transform(
      transform: Matrix4.rotationY((animation.value - 1) * 3.1415927), // pi
      alignment: Alignment.center,
      child: child,
    );
  }
}
