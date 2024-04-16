import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/frequent_questions/frequest_questions_screen_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FrequentQuestionsScreen extends StatefulWidget {
  static const route = '/frequent-questions';
  static const icon = Icons.question_answer_sharp;
  static String title = StringConstant.frequentlyAskedQuestions.tr();
  const FrequentQuestionsScreen({super.key});

  @override
  State<FrequentQuestionsScreen> createState() =>
      _FrequentQuestionsScreenState();
}

class _FrequentQuestionsScreenState extends State<FrequentQuestionsScreen> {
  late FrequestQuestionsScreenController _controller;
  @override
  void initState() {
    Get.delete<FrequestQuestionsScreenController>();
    _controller = Get.put(FrequestQuestionsScreenController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        title: FrequentQuestionsScreen.title,
        icon: FrequentQuestionsScreen.icon,
        child: ItemsList(controller: _controller));
  }
}
