import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_with_questions_filtering_enabled_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/presentation/home/term_tag_widget.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/widgets/list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class TermTagListingController extends ListController {
  TermsController termsController = Get.find();

  TermTagListingController(State state)
      : super(
            itemBuilder: (context, index) => TermTagWidget(index: index),
            state: state,
            plural: '',
            indexUrl: '',
            remote: false,
            itemsPerRow: 2,
            fetch: () => Future(() => []),
            showLoadMore: false,
            showRefresh: false,
            fromJson: null);

  @override
  Future<List> Function()? get fetch => () async {
        termsController.termTagButtons.clear();
        QuestionService questionService = Get.find();
        TermsWithQuestionsFilteringEnabledService
            termsWithQuestionsFilteringEnabledService = Get.find();
        TermData termData = Get.find();
        bool termHasQuestionsFilteringEnabled =
            await termsWithQuestionsFilteringEnabledService
                .isTermWithQuestionFilteringEnabled(Id(termData.term.id));
        bool hasOtherTag = termsController.termsDatas
            .where((element) => element.tagId!.value == null)
            .toList()
            .isNotEmpty;
        if (hasOtherTag) {
          termsController.termTagButtons.add(TermTagButton.others);
        }
        termsController.termTagButtons.add(TermTagButton.questionTags);
        termsController.termTagButtons.add(TermTagButton.search);
        if (termHasQuestionsFilteringEnabled) {
          int easyQuestionsCount =
              await questionService.getNumberOfEasyQuestions(termData);
          if (easyQuestionsCount > 0) {
            termsController.termTagButtons.add(TermTagButton.easy);
          }
          int mediumQuestionsCount =
              await questionService.getNumberOfMediumQuestions(termData);
          if (mediumQuestionsCount > 0) {
            termsController.termTagButtons.add(TermTagButton.medium);
          }
          int difficultQuestionsCount =
              await questionService.getNumberOfDifficultQuestions(termData);
          if (difficultQuestionsCount > 0) {
            termsController.termTagButtons.add(TermTagButton.difficult);
          }
        }
        termsController.termTagButtons.add(TermTagButton.favorite);
        termsController.termTagButtons.add(TermTagButton.edited);
        bool termHasTemplates =
            await Get.find<TermService>().termHasTemplate(termData);
        int numberOfWrongQuestions =
            await questionService.getNumberOfWrongQuestions(termData);
        if (termHasTemplates && numberOfWrongQuestions > 0) {
          termsController.termTagButtons.add(TermTagButton.wrong);
        }
        return Future.value(
            [...termsController.termsTags, ...termsController.termTagButtons]);
      };
}

enum TermTagButton {
  others,
  questionTags,
  search,
  easy,
  medium,
  difficult,
  favorite,
  edited,
  wrong
}
