import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  static const route = '/contact-us';

  const ContactUsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        child: ListView(
      children: [
        SubmitButton(
          text: StringConstant.frequentlyAskedQuestions.tr(),
          icon: Icons.question_answer_sharp,
          onSubmit: () => Navigator.pushNamed(context, FrequentQuestions.route),
        )
      ],
    ));
  }
}
