import 'package:beta/application/services/database_service.dart';
import 'package:beta/presentation/question_medias/media_widget.dart';
import 'package:beta/presentation/question_medias/question_media_controller.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class QuestionMediasScreen extends StatefulWidget {
  static const String route = '/question-medias';
  const QuestionMediasScreen({super.key});

  @override
  State<QuestionMediasScreen> createState() => _QuestionMediasScreenState();
}

class _QuestionMediasScreenState extends State<QuestionMediasScreen> {
  late QuestionMediaController questionMediaController;
  @override
  void initState() {
    questionMediaController = Get.put(QuestionMediaController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        titleText:
            "${questionMediaController.page + 1}/${questionMediaController.questionMediasScreenArgument.questionMedias.length}",
        child: PageView.builder(
          itemCount: questionMediaController
              .questionMediasScreenArgument.questionMedias.length,
          itemBuilder: (context, index) {
            return MediaWidget(
                questionMedia: questionMediaController
                    .questionMediasScreenArgument.questionMedias[index]);
          },
          onPageChanged: questionMediaController.onPageChanged,
        ));
  }
}

class QuestionMediasScreenArgument {
  final List<QuestionMedia> questionMedias;

  QuestionMediasScreenArgument({required this.questionMedias});
}
