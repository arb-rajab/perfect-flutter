import 'package:beta/configs/links.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/url_launcher_repository.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class ContactUsScreen extends StatelessWidget {
  static const route = '/contact-us';
  static String title = StringConstant.contactUs.tr();
  static const IconData icon = Icons.phone;

  const ContactUsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        titleText: title,
        icon: icon,
        child: ListView(children: [
          const FrequesntQuestionsTile(),
          if (telegramChannelLink.isNotEmpty) _TelegramChannelTile(),
          if (telegramChatLink.isNotEmpty) _TelegramChatTile(),
          if (facebookPageLink.isNotEmpty) _FacebookPageTile()
        ]));
  }
}

class FrequesntQuestionsTile extends StatelessWidget {
  const FrequesntQuestionsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(FrequentQuestionsScreen.icon),
        title: Hero(
            tag: FrequentQuestionsScreen.title,
            child: Text(FrequentQuestionsScreen.title)),
        subtitle: Text(StringConstant.frequentlyAskedQuestionsExplanation.tr()),
          onTap: () => context.go(FrequentQuestionsScreen.route)
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
          onTap: () =>
              Get.find<UrlLauncherRepository>().openUrl(telegramChannelLink)),
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
            onTap: () =>
                Get.find<UrlLauncherRepository>().openUrl(telegramChatLink)));
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
            onTap: () =>
                Get.find<UrlLauncherRepository>().openUrl(facebookPageLink))
    );
  }
}
