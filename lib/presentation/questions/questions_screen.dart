import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
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
  State<StatefulWidget> createState() => QuestionsScreenState();
}

class QuestionsScreenState extends State<QuestionsScreen> with RouteAware {
  late QuestionsController questionsController;
  @override
  void initState() {
    if (Get.isRegistered<QuestionsScreenArgument>()) {
      QuestionsScreenArgument questionsScreenArgument = Get.find();
      Get.delete<QuestionsController>(tag: questionsScreenArgument.query);
      questionsController = Get.put(
          QuestionsController(this)..questionUUID = widget.uuid,
          tag: questionsScreenArgument.query);
    } else {
      Get.delete<QuestionsController>();
      questionsController =
          Get.put(QuestionsController(this)..questionUUID = widget.uuid);
    }

    questionsController.init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() => questionsController.configureScreenShots();

  @override
  void dispose() {
    questionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: questionsController.canPop(),
      onPopInvokedWithResult: questionsController.onPopInvoked,
      child: ScreenWrapper(
        actions: [
          if (!questionsController.searchVisible)
            IconButton(
                onPressed: () => questionsController.setSearchVisible(true),
                icon: const Icon(Icons.search))
        ],
        title: questionsController.searchVisible
            ? TextFormField(
                decoration: InputDecoration(
                    hintText: StringConstant.search.tr(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: questionsController.clearSearch,
                    )),
                controller: questionsController.searchController,
                onChanged: questionsController.searchText,
              )
            : null,
        titleText: !questionsController.searchVisible &&
                questionsController.questionsScreenArgument != null
            ? questionsController.questionsScreenArgument!.title.value
            : null,
        floatingActionButton: questionsController.speedDialVisible()
            ? SpeedDial(
                switchLabelPosition: MainController.testing
                    ? false
                    : [
                        'ar', // Arabic
                        'fa', // Farsi
                        'he', // Hebrew
                        'ps', // Pashto
                        'ur', // Urdu
                      ].contains(context.locale.languageCode),
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
        child: questionsController.loading
            ? const LoadingWidget()
            : QuestionsList(
                questionsController: questionsController,
              ),
      ),
    );
  }
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
