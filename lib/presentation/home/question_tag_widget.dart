import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/presentation/home/question_tag_listing_controller.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/widgets/animated_counter.dart';
import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class QuestionTagWidget extends StatefulWidget {
  final int index;

  const QuestionTagWidget({super.key, required this.index});

  @override
  State<QuestionTagWidget> createState() => _QuestionTagWidgetState();
}

class _QuestionTagWidgetState extends State<QuestionTagWidget> {
  int? numberOfQuestions;
  int? numberOfChildTags;
  late QuestionTagData? parentQuestionTagData;
  QuestionTagService questionTagService = Get.find();
  TermData termData = Get.find();
  QuestionTagListingController questionTagListingController = Get.find();
  QuestionTagData? questionTagData;
  TermsController termsController = Get.find();

  void getNumberOfOccurences() {
    parentQuestionTagData = Get.isRegistered<QuestionTagData>()
        ? Get.find<QuestionTagData>()
        : null;
    if (widget.index == 0 && parentQuestionTagData != null) {
      questionTagService
          .getNumberOfAllQuestionsQuestionTag(parentQuestionTagData!, termData)
          .then((value) {
        if (numberOfQuestions != value) {
          setState(() {
            numberOfQuestions = value;
          });
        }
      });
    } else if (questionTagListingController.numberOfOthers > 0 &&
        widget.index == questionTagListingController.getLength() - 1) {
      Future.delayed(Duration.zero, () {
        if (numberOfQuestions != questionTagListingController.numberOfOthers) {
          setState(() {
            numberOfQuestions = questionTagListingController.numberOfOthers;
          });
        }
      });
    } else {
      Future.delayed(Duration.zero, () {
        if (numberOfQuestions != questionTagData?.numberOfOccurrences!.value ||
            numberOfChildTags != questionTagData?.numberOfChildTags!.value) {
          setState(() {
            numberOfQuestions = questionTagData?.numberOfOccurrences!.value;
            numberOfChildTags = questionTagData?.numberOfChildTags!.value;
          });
        }
      });
    }
  }

  void startQuestionTagQuiz(
      QuestionTagData questionTagData, TermData termData) {
    Get.delete<QuestionsScreenArgument>();
    Get.put(QuestionsScreenArgument(
        query:
            "q.id in (select questionId from questionsLinkedToTags where tagId ='${questionTagData.questionTag.id}') and q.parentTermId in (select termId from termTrees where parentTermId = '${termData.term.id}' and depth>0) order by q.id asc ",
        source: QuestionScreenSource.questionTag,
        sourceId: Id(questionTagData.questionTag.id),
        title: t.Title(questionTagData.questionTag.name),
        resourceTermId: Id(termData.term.id)));
    context.push(QuestionsScreen.route);
  }

  void startQuestionTagOtherQuestionsQuiz(
      QuestionTagData questionTagData, TermData termData) {
    Get.delete<QuestionsScreenArgument>();
    Get.put(QuestionsScreenArgument(
        query:
            "q.id in (select questionId from questionsLinkedToTags where tagId ='${questionTagData.questionTag.id}') and q.id not in (select questionId from questionsLinkedToTags where tagId in (select id from questionTags where parentTagId='${questionTagData.questionTag.id}')) and q.parentTermId in (select termId from termTrees where parentTermId = '${termData.term.id}') order by q.id asc ",
        source: QuestionScreenSource.questionTag,
        sourceId: Id(questionTagData.questionTag.id),
        title: t.Title(questionTagData.questionTag.name),
        resourceTermId: Id(termData.term.id)));
    context.push(QuestionsScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    parentQuestionTagData = Get.isRegistered<QuestionTagData>()
        ? Get.find<QuestionTagData>()
        : null;
    questionTagData = (widget.index == 0 && parentQuestionTagData != null)
        ? null
        : (widget.index == questionTagListingController.getLength() - 1 &&
                questionTagListingController.numberOfOthers > 0)
            ? null
            : termsController.questionTagDatas[parentQuestionTagData == null
                ? widget.index
                : widget.index - 1];
    getNumberOfOccurences();
    return WidgetWrapperWithBorder(
        child: ListTile(
      onTap: () async {
        if (widget.index == 0 && parentQuestionTagData != null) {
          startQuestionTagQuiz(parentQuestionTagData!, termData);
        } else if (questionTagListingController.numberOfOthers > 0 &&
            widget.index == questionTagListingController.getLength() - 1) {
          startQuestionTagOtherQuestionsQuiz(parentQuestionTagData!, termData);
        } else {
          if (questionTagData!.numberOfChildTags!.value! > 0) {
            List<QuestionTagData> questionTagDatas = await questionTagService
                .getAllQuestionsTagChild(questionTagData!);
            int numberOfOtherQuestionsQuestionTag =
                await questionTagService.getNumberOfOtherQuestionsQuestionTag(
                    questionTagData!, termData);
            await Get.delete<QuestionTagData>();

            termsController.questionTagDatas = questionTagDatas;
            questionTagListingController.numberOfOthers =
                numberOfOtherQuestionsQuestionTag;
            await Get.delete<QuestionTagData>();
            Get.put<QuestionTagData>(questionTagData!);
            questionTagListingController.questionTagListing.add(
                QuestionTagListingItem(
                    questionTagData: questionTagData!,
                    numberOfOthers: numberOfOtherQuestionsQuestionTag));
            await questionTagListingController.init();
          } else if (questionTagData!.numberOfOccurrences!.value! > 0) {
            startQuestionTagQuiz(questionTagData!, termData);
          }
        }
      },
      leading: const Icon(Icons.style_outlined),
      title: Text(widget.index == 0 && parentQuestionTagData != null
          ? StringConstant.showAll.tr()
          : questionTagListingController.numberOfOthers > 0 &&
                  widget.index == questionTagListingController.getLength() - 1
              ? StringConstant.others.tr()
              : questionTagData!.questionTag.name),
      subtitle: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        if (numberOfChildTags != null && numberOfChildTags != 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: halfMargin),
            child: Row(
              key: Key(
                  '${questionTagData!.questionTag.name} $numberOfChildTags-child'),
              children: [
                const Icon(Icons.style_outlined),
                const Text('x'),
                AnimatedCounter(value: numberOfChildTags!)
              ],
            ),
          ),
        if (numberOfQuestions != null && numberOfQuestions != 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: halfMargin),
            child: Row(
              key: questionTagData != null
                  ? Key(
                      '${questionTagData!.questionTag.name} $numberOfQuestions-question')
                  : null,
              children: [
                const Icon(Icons.question_answer),
                const Text('x'),
                AnimatedCounter(value: numberOfQuestions!)
              ],
            ),
          )
      ]),
      trailing: questionTagData != null &&
              questionTagData!.questionTag.hasInformation != 0
          ? IconButton(
              key: const Key('information'),
              onPressed: () => questionTagService.openQuestionTagInformation(
                  questionTag: questionTagData!.questionTag, context: context),
              icon: const Icon(Icons.article))
          : null,
    ));
  }
}
