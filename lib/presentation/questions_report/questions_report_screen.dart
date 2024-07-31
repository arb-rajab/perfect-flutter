import 'dart:async';

import 'package:beta/application/services/database_service.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/answer_data.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/question_statistic.dart';
import 'package:beta/presentation/questions_report/questions_report_controller.dart';
import 'package:beta/presentation/questions_report/quiz_detail_widget.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class QuestionsReportScreen extends StatelessWidget {
  static const String route = '/questions-report';
  final QuestionsReportScreenArgument questionsReportScreenArgument =
      Get.find();
  QuestionsReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.delete<QuestionsReportController>();
    QuestionsReportController questionsReportController =
        Get.put(QuestionsReportController());

    late int itemCount;

    bool isQuestionWithNoQuestionTag(int position) {
      return questionsReportController.questionsWithNoQuestionsTagsExists &&
          position == itemCount - 1;
    }

    itemCount = questionsReportController.allQuestionTags.length +
        (questionsReportController.questionsWithNoQuestionsTagsExists ? 1 : 0);

    QuestionStatistic questionStatistic =
        QuestionData.getStatistics(questionsReportScreenArgument.questions);
    return ScreenWrapper(
        titleText: StringConstant.quizReport.tr(),
        child: Padding(
          padding: const EdgeInsets.all(halfMargin),
          child: ListView.builder(
            itemCount: itemCount + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return QuizDetailWidget(
                    parentTitle: null,
                    title: null,
                    correct: questionStatistic.correct,
                    wrong: questionStatistic.wrong,
                    unanswered:
                        questionStatistic.total - questionStatistic.answered);
              }
              if (index == 1) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(StringConstant.expectedMarkPercent.tr()),
                        Text(
                            '${questionStatistic.correct * 100 / questionsReportScreenArgument.questions.length}%')
                      ],
                    ),
                    Column(
                      children: [
                        Text(StringConstant.timePerQuestion.tr()),
                        Text(StringConstant.seconds.tr().replaceAll(
                            '(SECONDS)',
                            (questionsReportScreenArgument.timer.tick /
                                    questionsReportScreenArgument
                                        .questions.length)
                                .toString()))
                      ],
                    )
                  ],
                );
              }

              index = index - 2;
              QuestionTag currentQuestionTag =
                  questionsReportController.allQuestionTags[index];
              String? title;
              String? parentTitle;
              if (isQuestionWithNoQuestionTag(index)) {
                parentTitle = StringConstant.noTagsQuestions.tr();
                title = null;
              } else {
                if (index == 0) {
                  if (currentQuestionTag.parentTagId != 0) {
                    QuestionTag? parentTag = questionsReportController
                        .getParentTag(currentQuestionTag.parentTagId);
                    if (parentTag == null) {
                      parentTitle = StringConstant.unknownTag.tr();
                    } else {
                      parentTitle = parentTag.name;
                    }
                    title = currentQuestionTag.name;
                  } else {
                    parentTitle = currentQuestionTag.name;
                  }
                } else {
                  QuestionTag previousQuestionTag =
                      questionsReportController.allQuestionTags[index - 1];
                  if (currentQuestionTag.parentTagId != 0) {
                    QuestionTag? parentTag = questionsReportController
                        .getParentTag(currentQuestionTag.parentTagId);
                    if (parentTag == null) {
                      parentTitle = StringConstant.unknownTag.tr();
                    } else {
                      parentTitle = parentTag.name;
                    }
                    title = currentQuestionTag.name;
                    if (currentQuestionTag.parentTagId ==
                        previousQuestionTag.parentTagId) {
                      parentTitle = null;
                    }
                  } else {
                    if (currentQuestionTag.id ==
                        previousQuestionTag.parentTagId) {
                      parentTitle = null;
                      title = StringConstant.others.tr();
                    } else {
                      parentTitle = currentQuestionTag.name;
                    }
                  }
                }
              }

              int correctAnswers = 0, wrongAnswers = 0, answeredQuestions = 0;
              int questionsWithQuestionTag = 0;
              bool otherQuestionTag = false;

              if (index > 0 && isQuestionWithNoQuestionTag(index)) {
                QuestionTag previousQuestionTag =
                    questionsReportController.allQuestionTags[index - 1];
                if (currentQuestionTag.parentTagId == 0 &&
                    previousQuestionTag.parentTagId == currentQuestionTag.id) {
                  otherQuestionTag = true;
                }
              }
              for (QuestionData questionData in questionsReportController
                  .questionsReportScreenArgument.questions) {
                bool correct = true,
                    answered = false,
                    tagFound = false,
                    subtagFound = false;
                if (!isQuestionWithNoQuestionTag(index)) {
                  for (QuestionTag questionTag in questionData.questionTags) {
                    if (questionTag.id == currentQuestionTag.id) {
                      tagFound = true;
                    }
                    if (questionTag.parentTagId == currentQuestionTag.id) {
                      subtagFound = true;
                    }
                  }
                } else if (questionData.questionTags.isNotEmpty) {
                  tagFound = true;
                }
                if (isQuestionWithNoQuestionTag(index)) {
                  if (tagFound) continue;
                } else {
                  if (!tagFound) continue;
                  if (otherQuestionTag && subtagFound) continue;
                }
                questionsWithQuestionTag++;
                for (AnswerData answerData in questionData.answers) {
                  if (answerData.isChecked()) answered = true;
                  if (answerData.isChecked() &&
                      answerData.answer.isCorrect == 0) correct = false;
                  if (answerData.answer.isCorrect == 1 &&
                      !answerData.isChecked()) correct = false;
                }
                if (answered) {
                  answeredQuestions++;
                  if (correct) {
                    correctAnswers++;
                  } else {
                    wrongAnswers++;
                  }
                }
              }

              return QuizDetailWidget(
                  parentTitle: parentTitle,
                  title: title,
                  correct: correctAnswers,
                  wrong: wrongAnswers,
                  unanswered: questionsWithQuestionTag - answeredQuestions);
            },
          ),
        ));
  }
}

class QuestionsReportScreenArgument {
  final List<QuestionData> questions;
  final Timer timer;

  QuestionsReportScreenArgument({required this.questions, required this.timer});
}
