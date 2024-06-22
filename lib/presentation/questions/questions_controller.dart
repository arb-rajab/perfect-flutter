// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/question_tag_property_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_with_questions_filtering_enabled_service.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/answer_data.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/dialogues/yes_no_dialogue.dart';
import 'package:beta/presentation/questions/questions_list.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/questions/statistics.dart';
import 'package:beta/presentation/questions_report/questions_report_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/parse_route.dart';
import 'package:get/instance_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class QuestionsController {
  State state;
  final String preQuery =
      'select q.*,t.name as parentTermName,(select count(*) from questions where id <q.id and parentTermId=q.parentTermId) as indexInTerm,(select count(*) from questionMedias where parentQuestionId =q.id) as numberOfMedias,case when q.note != '
      ' then 1 else 0 end as hasNote from questions q join terms t on t.id = q.parentTermId and t.enabled=1 where ';
  late String query;

  bool deepLinked = false;
  String? questionUUID;
  List<QuestionData> questions = [];
  bool templateExited = false;
  List<bool Function(QuestionData)> questionFilters = [];
  List<QuestionTag>? _questionTags;

  QuestionsScreenArgument questionsScreenArgument = Get.find();
  List<QuestionTag> selectedTags = [];
  Term? term;
  bool questionsFilteringEnabled = false;
  late Timer timer;
  Set<AnswerData> checkedAnswers = HashSet();
  late QuestionData firstVisibleQuestions;
  String? search;
  List<Buttons> pressedButtons = [];
  AnswerPropertyService answerPropertyService = Get.find();
  TermLastAccessService termLastAccessService = Get.find();
  QuestionTagPropertyService questionTagPropertyService = Get.find();

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  QuestionsController(this.state) {
    if (questionsScreenArgument.query != null) {
      query = preQuery + questionsScreenArgument.query!;
    }
    _configureArgument().then((v) => _configureScreenShots);
  }

  _configureScreenShots() {
    if (!kReleaseMode) return;
    if (questionsScreenArgument.source != QuestionScreenSource.term) {
      ScreenProtector.preventScreenshotOn();
    } else if (term!.captureable == 0) {
      ScreenProtector.preventScreenshotOn();
    }
  }

  Future _configureArgument() async {
    TermService termService = Get.find();
    if (questionsScreenArgument.source == QuestionScreenSource.term) {
      term = await termService.getTermById(questionsScreenArgument.sourceId!);
    }
    TermsWithQuestionsFilteringEnabledService
        termsWithQuestionsFilteringEnabledService = Get.find();
    questionsFilteringEnabled = await termsWithQuestionsFilteringEnabledService
        .isTermWithQuestionFilteringEnabled(
            questionsScreenArgument.resourceTermId);
    if (questionUUID != null) {
      query =
          '$preQuery q.parentTermId in (select parentTermId from questions where uuid = \'${questionUUID!}\') order by id asc';
      term = await termService.getTermByQuestionUuid(questionUUID!);
      state.setState(() {
        deepLinked = true;
      });
    }
    await _configureQuestions();
    _configureDeeplinkAndLastAccess();
  }

  bool favoriteFilter(QuestionData questionData) {
    for (QuestionProperty questionProperty in questionData.questionProperties) {
      if (questionProperty.name == 'favorite' &&
          questionProperty.value == 'true') return true;
    }
    return false;
  }

  bool searchFilter(QuestionData questionData) {
    if (questionData.question.title.contains(search!)) return true;
    for (AnswerData answerData in questionData.answers) {
      if (answerData.answer.title.contains(search!)) return true;
    }
    return false;
  }

  bool editedFilter(QuestionData questionData) =>
      questionData.question.edited == 1;

  bool easyQuestionsFilter(QuestionData questionData) {
    int maxCheckedAnswer = 0;
    int totalCheckedAnswers = 0;
    List<AnswerData> answers = questionData.answers;
    for (AnswerData answer in answers) {
      totalCheckedAnswers += answer.answer.checkedCount;
      if (answer.answer.checkedCount > maxCheckedAnswer) {
        maxCheckedAnswer = answer.answer.checkedCount;
      }
    }
    int minCheckedAnswer = totalCheckedAnswers;
    for (AnswerData answer in answers) {
      if (answer.answer.checkedCount < minCheckedAnswer) {
        minCheckedAnswer = answer.answer.checkedCount;
      }
    }
    if (totalCheckedAnswers <= 25) return false;
    for (AnswerData answer in answers) {
      if (answer.answer.isCorrect == 1 &&
          answer.answer.checkedCount == maxCheckedAnswer) return true;
    }
    return false;
  }

  bool difficultQuestionsFilter(QuestionData questionData) {
    int maxCheckedAnswer = 0;
    int totalCheckedAnswers = 0;
    List<AnswerData> answers = questionData.answers;
    for (AnswerData answerData in answers) {
      totalCheckedAnswers += answerData.answer.checkedCount;
      if (answerData.answer.checkedCount > maxCheckedAnswer) {
        maxCheckedAnswer = answerData.answer.checkedCount;
      }
    }
    int minCheckedAnswer = totalCheckedAnswers;
    for (AnswerData answerData in answers) {
      if (answerData.answer.checkedCount < minCheckedAnswer) {
        minCheckedAnswer = answerData.answer.checkedCount;
      }
    }
    if (totalCheckedAnswers <= 25) return false;
    for (AnswerData answerData in answers) {
      if (answerData.answer.isCorrect == 1 &&
          answerData.answer.checkedCount == minCheckedAnswer) return true;
    }
    return false;
  }

  bool mediumQuestionsFilter(QuestionData questionData) {
    int maxCheckedAnswer = 0;
    int totalCheckedAnswers = 0;
    List<AnswerData> answers = questionData.answers;
    for (AnswerData answerData in answers) {
      totalCheckedAnswers += answerData.answer.checkedCount;
      if (answerData.answer.checkedCount > maxCheckedAnswer) {
        maxCheckedAnswer = answerData.answer.checkedCount;
      }
    }
    int minCheckedAnswer = totalCheckedAnswers;
    for (AnswerData answerData in answers) {
      if (answerData.answer.checkedCount < minCheckedAnswer) {
        minCheckedAnswer = answerData.answer.checkedCount;
      }
    }
    if (totalCheckedAnswers <= 25) return false;
    for (AnswerData answerData in answers) {
      if (answerData.answer.isCorrect == 1 &&
              answerData.answer.checkedCount == maxCheckedAnswer ||
          answerData.answer.isCorrect == 1 &&
              answerData.answer.checkedCount == minCheckedAnswer) return false;
    }
    return true;
  }

  bool tagsQuestionFilter(QuestionData questionData) {
    for (QuestionTag selectedTag in selectedTags) {
      bool tagFound = false;
      for (QuestionTag tag in questionData.questionTags) {
        if (tag.name.trim() == selectedTag.name.trim()) {
          tagFound = true;
          break;
        }
      }
      if (!tagFound) {
        return false;
      }
    }
    return true;
  }

  List<QuestionTag> getQuestionTags() {
    if (_questionTags != null) return _questionTags!;
    List<QuestionTag> questionTags = [];
    for (var element in questions) {
      questionTags.addAll(element.questionTags);
    }
    _questionTags = questionTags.toSet().toList();
    return _questionTags!;
  }

  void setSelectedTags(List<QuestionTag> questionTags) {
    state.setState(() {
      selectedTags = questionTags;
    });
  }

  //TODO add test
  bool correctable() => !(term != null && term!.type == TermType.template);

  bool hasTemplate() => term != null && term!.type == TermType.template;

  bool speedDialVisible() => !deepLinked;

  Future solveQuestions() async {
    for (QuestionData questionData in questions) {
      for (AnswerData answerData in questionData.answers) {
        await answerData.setChecked(answerData.answer.isCorrect == 1);
      }
    }
    state.setState(() {});
  }

  //TODO implement
  void correctQuestions({showStatistics = false}) {
    for (QuestionData questionData in questions) {
      questionData.corrected = true;
      if (!questionData.isInitiallyChecked) {
        for (AnswerData answerData in questionData.answers) {
          if (answerData.isChecked()) checkedAnswers.add(answerData);
        }
      }
    }
    state.setState(() {});
    if (showStatistics) _showStatistics();
  }

  void _showStatistics() {
    int correctAnswers = 0, wrongAnswers = 0, answeredAnswers = 0;
    for (QuestionData questionData in questions) {
      bool correct = true, answered = false;
      for (AnswerData answerData in questionData.answers) {
        if (answerData.isChecked()) answered = true;
        if ((answerData.isChecked() && !(answerData.answer.isCorrect == 1)) ||
            (!answerData.isChecked() && answerData.answer.isCorrect == 1)) {
          correct = false;
        }
      }
      if (answered) answeredAnswers++;
      if (correct) {
        correctAnswers++;
      } else {
        wrongAnswers++;
      }
    }
    showOkDialogue(state.context, () {},
        contentWidget: Statistics(
            total: questions.length,
            answered: answeredAnswers,
            correct: correctAnswers,
            wrong: wrongAnswers));
  }

  Future resetQuestions() async {
    for (QuestionData questionData in questions) {
      for (AnswerData answerData in questionData.answers) {
        await answerData.setChecked(false);
      }
      questionData.corrected = false;
    }
    state.setState(() {});
  }

  void showTimer() {
    int totalTiming = questions.length * 60;
    int remaining = totalTiming - timer.tick;
    String remainingString = "${remaining / 60}:${remaining % 60}";
    Fluttertoast.showToast(
        msg: StringConstant.remainingTime
            .tr()
            .replaceFirst('(TIME)', remainingString),
        toastLength: Toast.LENGTH_LONG);
  }

  Future _configureQuestions() async {
    QuestionService questionService = Get.find();
    questions = await questionService.getQuestionsFromQuery(query);
    for (QuestionData question in questions) {
      await question.getData();
    }
    state.setState(() {});
  }

  _configureDeeplinkAndLastAccess() {
    if (!deepLinked) _showTimedTestDialogue();
    if (deepLinked) {
      QuestionData? foundQuestion;
      for (QuestionData questionData in questions) {
        if (questionData.question.uuid == questionUUID) {
          foundQuestion = questionData;
          break;
        }
      }
      if (foundQuestion != null) {
        itemScrollController.scrollTo(
            index: _getQuestionIndex(foundQuestion)!,
            duration: animationDuration);
      }
    } else {
      int? lastQuestionId;
      if (questionsScreenArgument.source == QuestionScreenSource.term) {
        termLastAccessService
            .getTermLastAccess(questionsScreenArgument.sourceId!.value!)
            .then((termLastAccess) => lastQuestionId = termLastAccess.childId);
      } else if (questionsScreenArgument.source ==
          QuestionScreenSource.questionTag) {
        questionTagPropertyService
            .getQuestionTagProperty(
                questionsScreenArgument.sourceId!.value!, 'lastAccess')
            .then((property) => lastQuestionId = int.parse(property.value));
      }
      if (lastQuestionId != null) {
        QuestionData? question = questions.firstWhereOrNull(
            (element) => element.question.id == lastQuestionId);
        if (question != null) {
          itemScrollController.scrollTo(
              index: _getQuestionIndex(question)!, duration: animationDuration);
        }
      }
    }
    state.setState(() {});
  }

  int? _getQuestionIndex(QuestionData questionData) {
    for (int c = 0; c < getAllObjects().length; c++) {
      Object object = getAllObjects()[c];
      if (object is QuestionData) {
        if (object == questionData) return c;
      }
    }
    return null;
  }

  List<Object> getAllObjects() {
    List<Object> objects = [];
    for (QuestionData questionData in _getFilteredQuestions()) {
      objects.add(questionData);
      questionData.answers.forEach(objects.add);
      objects.add(questionData);
    }
    return objects;
  }

  void moveToQuestionsReportScreen() {
    templateExited = true;
    correctQuestions();
    timer.cancel();
    Get.delete<QuestionsReportScreenArgument>();
    Get.put(QuestionsReportScreenArgument(questions: questions, timer: timer));
    state.context.go(QuestionsReportScreen.route);
  }

  void _showTimedTestDialogue() {
    if (questionsScreenArgument.source == QuestionScreenSource.term &&
        term!.type == TermType.template) {
      showOkDialogue(state.context, () {
        timer = Timer.periodic(const Duration(seconds: 1), (t) {
          if (timer.tick >= questions.length * 60) {
            showOkDialogue(state.context, moveToQuestionsReportScreen,
                title: StringConstant.testFinished.tr(),
                content: StringConstant.testFinishedExplanation.tr());
          }
        });
      },
          title: StringConstant.timedTest.tr(),
          contentWidget: Column(
            children: [
              Text(
                StringConstant.timedTestExplanation
                    .tr()
                    .replaceFirst('(MINUTES)', questions.length.toString()),
                style: Theme.of(state.context).textTheme.titleMedium,
              ),
              Text(
                StringConstant.youCantCorrectQuestions.tr(),
                style: Theme.of(state.context).textTheme.bodyLarge,
              )
            ],
          ));
    }
  }

  _updateLastAccess() {
    List<ItemPosition> positions =
        itemPositionsListener.itemPositions.value.toList();
    for (ItemPosition itemPosition in positions) {
      if (getQuestionFragment(itemPosition.index) == QuestionFragment.header) {
        firstVisibleQuestions =
            getAllObjects()[itemPosition.index] as QuestionData;
      }
    }
    if (term != null) {
      termLastAccessService.addTermLastAccessed(
          Id(term!.id), Id(firstVisibleQuestions.question.id));
    } else if (questionsScreenArgument.source ==
        QuestionScreenSource.questionTag) {
      questionTagPropertyService.addQuestionTagProperty(
          questionsScreenArgument.sourceId!,
          'lastAccess',
          firstVisibleQuestions.question.id.toString());
    }
  }

  void dispose() {
    _updateLastAccess;
    ScreenProtector.preventScreenshotOff;
    timer.cancel;
    _uploadCheckedAnswers;
  }

  void _uploadCheckedAnswers() {
    if (checkedAnswers.isNotEmpty) {
      (NetworkService(state.context,
              onPreConnect: () {},
              onPostConnect: () {},
              onConnectionSucceed: (data) {},
              onConnectionFailed: () {},
              onMessageReceived: (message) {})
            ..retryOnStartup = true)
          .post(url: ApiConstant.checkedAnswers, body: {
        'answers':
            jsonEncode(checkedAnswers.map((e) => {'id': e.answer.id}).toList())
      });
    }
  }

  bool isFavoriteOnly() => questionFilters.contains(favoriteFilter);

  bool isEditedOnly() => questionFilters.contains(editedFilter);

  List<QuestionData> _getFilteredQuestions() {
    List<QuestionData> filteredQuestions = [];
    for (QuestionData questionData in questions) {
      bool refused = false;
      for (var filter in questionFilters) {
        if (!filter(questionData)) {
          refused = true;
          break;
        }
      }
      if (!refused) filteredQuestions.add(questionData);
    }
    return filteredQuestions;
  }

  QuestionData? getAnswerParentQuestion(AnswerData answerData) {
    for (QuestionData questionData in questions) {
      if (questionData.question.id == answerData.answer.id) return questionData;
    }
    return null;
  }

  QuestionFragment getQuestionFragment(int position) {
    if (position == 0) return QuestionFragment.header;
    List<Object> objects = getAllObjects();
    Object currentObject = objects[position];
    Object previousObject = objects[position - 1];
    if (currentObject is QuestionData && previousObject is AnswerData) {
      return QuestionFragment.footer;
    }
    if (currentObject is QuestionData && previousObject is QuestionData) {
      if (currentObject.question.id == previousObject.question.id) {
        return QuestionFragment.footer;
      }
      return QuestionFragment.header;
    }
    return QuestionFragment.body;
  }

  void searchText(String? text) {
    if (text == null) return;
    search = text;
    if (questionsScreenArgument.source == QuestionScreenSource.search) {
      if (text.isEmpty) {
        state.setState(() {
          questions = [];
        });
        return;
      }
      query =
          '$preQuery(q.title like "%$text%" or q.id in (select parentQuestionId from answers where title like "%$text%")) and q.parentTermId in (select termId from termTrees where parentTermId = ${questionsScreenArgument.sourceId!.value} and depth>0) order by q.id asc ';
      _configureQuestions();
      return;
    }
    questionFilters.remove(searchFilter);
    questionFilters.add(searchFilter);
    state.setState(() {});
  }

  bool canPop() {
    if (questionUUID != null) return true;
    if (questionsScreenArgument.source == QuestionScreenSource.term &&
        term!.type == TermType.template &&
        !templateExited) {
      return false;
    }
    return true;
  }

  void onPopInvoked(bool didPop) {
    if (!didPop) {
      if (questionsScreenArgument.source == QuestionScreenSource.term &&
          term!.type == TermType.template &&
          !templateExited) {
        showYesNoDialogueDialog(state.context,
            onYesClicked: moveToQuestionsReportScreen,
            onNoClicked: () {},
            title: StringConstant.confirmExist.tr(),
            description: StringConstant.confirmTemplateExistExplanation.tr());
      }
    }
  }
}

enum Buttons { solveAll, correctAll, resetAll }
