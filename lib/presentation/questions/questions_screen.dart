import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/main.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/questions/questions_header.dart';
import 'package:beta/presentation/widgets/custom_list_view.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/instance_manager.dart';

import 'questions_list.dart';

class QuestionsScreen extends StatefulWidget {
  static const String route = '/questions';
  static const String uuidRoute = '/q/:uuid';
  final String? uuid;

  const QuestionsScreen({super.key, this.uuid});
  @override
  State<StatefulWidget> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> with RouteAware {
  late QuestionsController questionsController;
  @override
  void initState() {
    Get.delete<QuestionsController>();
    questionsController =
        Get.put(QuestionsController(this)..questionUUID = widget.uuid);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() => questionsController.configureScreenShots;

  @override
  void dispose() {
    questionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: questionsController.canPop(),
      onPopInvoked: questionsController.onPopInvoked,
      child: ScreenWrapper(
          title: SearchBar(
            onChanged: questionsController.searchText,
          ),
          floatingActionButton: questionsController.speedDialVisible()
              ? SpeedDial(
                  icon: Icons.sort,
                  children: [
                    SpeedDialChild(
                        child: const Icon(Icons.playlist_add_check),
                        label: StringConstant.solveQuestions.tr(),
                        onTap: questionsController.solveQuestions),
                    if (questionsController.correctable())
                      SpeedDialChild(
                          child: const Icon(Icons.spellcheck),
                          label: StringConstant.correctQuestions.tr(),
                          onTap: () => questionsController.correctQuestions(
                              showStatistics: true)),
                    SpeedDialChild(
                        child: const Icon(Icons.subject),
                        label: StringConstant.resetQuestions.tr(),
                        onTap: questionsController.resetQuestions),
                    if (questionsController.hasTemplate())
                      SpeedDialChild(
                          child: const Icon(Icons.timer),
                          label: StringConstant.timer.tr(),
                          onTap: questionsController.showTimer)
                  ],
                )
              : null,
          child: CustomListView(children: [
            const QuestionsHeader(),
            const QuestionsList(),
            if (questionsController.term != null &&
                questionsController.term!.type == TermType.template)
              SubmitButton(
                  text: StringConstant.correctQuestions.tr(),
                  onSubmit: questionsController.moveToQuestionsReportScreen)
          ])),
    );
  }
}

class QuestionsScreenArgument {
  final String? query;
  final QuestionScreenSource source;
  final Id? sourceId;
  final Id resourceTermId;
  final t.Title title;
  TermData? termData;

  QuestionsScreenArgument(
      {required this.query,
      required this.source,
      required this.sourceId,
      required this.resourceTermId,
      required this.title,
      this.termData});
}

enum QuestionScreenSource {
  questionTag,
  search,
  favorite,
  edited,
  easy,
  medium,
  difficult,
  wrong,
  term
}
