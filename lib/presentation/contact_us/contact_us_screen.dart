import 'package:beta/configs/links.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  static const route = '/contact-us';
  static String title = StringConstant.contactUs.tr();
  static const IconData icon = Icons.phone;

  const ContactUsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        title: title,
        icon: icon,
        child: ListView(
      children: [
            _FrequesntQuestionsTile(),
            if (telegramChannelLink.isNotEmpty) _TelegramChannelTile(),
            if (telegramChatLink.isNotEmpty) _TelegramChatTile(),
            if (facebookPageLink.isNotEmpty) _FacebookPageTile()
      ],
    ));
  }
}

//TODO apply test
class _FrequesntQuestionsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(Icons.question_answer_sharp),
        title: Text(StringConstant.frequentlyAskedQuestions.tr()),
        subtitle: Text(StringConstant.frequentlyAskedQuestionsExplanation.tr()),
        onTap: () => Navigator.pushNamed(context, FrequentQuestions.route),
      ),
    );
  }
}

class _TelegramChannelTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
          leading: const Icon(Icons.telegram),
          title: Text(StringConstant.telegram.tr()),
          subtitle: Text(StringConstant.telegramExplanation.tr()),
          onTap: () async => {
                if (!await launchUrl(Uri.parse(telegramChannelLink)))
                  {throw Exception('Could not launch $telegramChannelLink')}
              }),
    );
  }
}

class _TelegramChatTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
          leading: const Icon(Icons.telegram),
          title: Text(StringConstant.telegram.tr()),
          subtitle: Text(StringConstant.telegramChatExplanation.tr()),
          onTap: () async => {
                if (!await launchUrl(Uri.parse(telegramChatLink)))
                  {throw Exception('Could not launch $telegramChatLink')}
              }),
    );
  }
}

class _FacebookPageTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
          leading: const Icon(Icons.facebook),
          title: Text(StringConstant.facebook.tr()),
          subtitle: Text(StringConstant.facebookExplanation.tr()),
          onTap: () async => {
                if (!await launchUrl(Uri.parse(facebookPageLink)))
                  {throw Exception('Could not launch $facebookPageLink')}
              }),
    );
  }
}
