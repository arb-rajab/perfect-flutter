import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/question_property_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:beta/presentation/dialogues/success_dialogue.dart';
import 'package:beta/presentation/settings/select_theme_widget.dart';
import 'package:beta/presentation/settings/text_scale_factor_widget.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        title: StringConstant.settings.tr(),
        child: ListView(
          children: const [
            SelectThemeWidget(),
            TextScaleFactorWidget(),
            Divider(),
            DeleteUserNotesWidget(),
            DeleteUserFavoriteQuestionsWidget(),
            DeleteUserAnswersWidget(),
            DeleteTermLastAccessWidget(),
            Divider(),
          ],
        ));
  }
}

class DeleteUserNotesWidget extends StatelessWidget {
  const DeleteUserNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.note),
        title: Text(StringConstant.deleteUserNotes.tr()),
        subtitle: Text(StringConstant.deleteUserNotesExplanation.tr()),
        onTap: () => showConfirmationDialog(context, () async {
              QuestionPropertyService questionPropertyService = Get.find();
              await questionPropertyService.deleteAllUserNotes();
              if (context.mounted) showSuccessDialogue(context);
            }));
  }
}

class DeleteUserFavoriteQuestionsWidget extends StatelessWidget {
  const DeleteUserFavoriteQuestionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.star),
        title: Text(StringConstant.deleteUserFavoriteQuestions.tr()),
        subtitle:
            Text(StringConstant.deleteUserFavoriteQuestionsExplanation.tr()),
        onTap: () => showConfirmationDialog(context, () async {
              QuestionPropertyService questionPropertyService = Get.find();
              await questionPropertyService.deleteAllUserFavoriteQuestions();
              if (context.mounted) showSuccessDialogue(context);
            }));
  }
}

class DeleteUserAnswersWidget extends StatelessWidget {
  const DeleteUserAnswersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.check),
        title: Text(StringConstant.deleteUserAnswers.tr()),
        subtitle: Text(StringConstant.deleteUserAnswersExplanation.tr()),
        onTap: () => showConfirmationDialog(context, () async {
              AnswerPropertyService answerPropertyService = Get.find();
              await answerPropertyService.deleteAllUserCheckedAnswers();
              if (context.mounted) showSuccessDialogue(context);
            }));
  }
}

class DeleteTermLastAccessWidget extends StatelessWidget {
  const DeleteTermLastAccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.timeline),
        title: Text(StringConstant.deleteTermLastAccess.tr()),
        subtitle: Text(StringConstant.deleteTermLastAccessExplanation.tr()),
        onTap: () => showConfirmationDialog(context, () async {
              TermLastAccessService termLastAccessService = Get.find();
              await termLastAccessService.deleteAllTermLastAccess();
              if (context.mounted) showSuccessDialogue(context);
            }));
  }
}
