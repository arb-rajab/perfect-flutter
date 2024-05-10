import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/application/services/term_label_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_with_questions_filtering_enabled_service.dart';
import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_tag_data.dart';
import 'package:beta/presentation/home/term_tag_widget.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:beta/presentation/widgets/list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class TermsListingController extends ListController {
  TermLabelService termLabelService = Get.find();
  List<List<TermData>> termsListing = [];
  bool reload = false;
  late List<TermLabel> termsLabels;
  List<TermTag> termsTags = [];
  List<TermTagButton> termTagButtons = [];
  List<TermData> termDatas = [];
  TermsListingController(state)
      : super(
            itemBuilder: (context, index) => TermWidget(
                  index: index,
                ),
            state: state,
            plural: 'terms',
            indexUrl: '',
            remote: false,
            itemsPerRow: 1,
            fetch: () => Future(() => []),
            showRefresh: false,
            fromJson: TermData.fromJson,
            showLoadMore: false);

  Future<void> refresh() async {
    reload = true;
    await fetch?.call();
    reload = false;
  }

  @override
  Function? get onPostFetch => () async {
        List<TermData> termDatas = items as List<TermData>;
        termsLabels = await termLabelService.getTermsLabels(termDatas);
        if (termsTags.isNotEmpty) {
          QuestionService questionService = Get.find();
          TermsWithQuestionsFilteringEnabledService
              termsWithQuestionsFilteringEnabledService = Get.find();
          QuestionTagService questionTagService = Get.find();
          TermData termData = Get.find();
          bool termHasQuestionsFilteringEnabled =
              await termsWithQuestionsFilteringEnabledService
                  .isTermWithQuestionFilteringEnabled(termData);
          List<QuestionTagData> questionTagDatas =
              await questionTagService.getTermQuestionsTags(termData);
          bool hasOtherTag = termDatas
              .where((element) => element.tagId!.value == null)
              .toList()
              .isNotEmpty;
          if (hasOtherTag) termTagButtons.add(TermTagButton.others);
          if (questionTagDatas.isNotEmpty) {
            termTagButtons.add(TermTagButton.questionTags);
          }
          termTagButtons.add(TermTagButton.search);
          if (termHasQuestionsFilteringEnabled) {
            int easyQuestionsCount =
                await questionService.getNumberOfEasyQuestions(termData);
            if (easyQuestionsCount > 0) termTagButtons.add(TermTagButton.easy);
            int mediumQuestionsCount =
                await questionService.getNumberOfMediumQuestions(termData);
            if (mediumQuestionsCount > 0) {
              termTagButtons.add(TermTagButton.medium);
            }
            int difficultQuestionsCount =
                await questionService.getNumberOfDifficultQuestions(termData);
            if (difficultQuestionsCount > 0) {
              termTagButtons.add(TermTagButton.difficult);
            }
          }
          termTagButtons.add(TermTagButton.favorite);
          int editedQuestionsCount =
              await questionService.getNumberOfEditedQuestions(termData);
          if (editedQuestionsCount > 0) {
            termTagButtons.add(TermTagButton.edited);
          }
          bool termHasTemplates =
              await Get.find<TermService>().termHasTemplate(termData);
          int numberOfWrongQuestions =
              await questionService.getNumberOfWrongQuestions(termData);
          if (termHasTemplates && numberOfWrongQuestions > 0) {
            termTagButtons.add(TermTagButton.wrong);
          }
          fetch!();
        }
      };

  @override
  Widget Function(BuildContext contenxt, int index) get itemBuilder =>
      (context, index) => termsTags.isEmpty
          ? TermWidget(index: index)
          : TermTagWidget(
              index: index,
            );

  @override
  int get itemsPerRow => termsTags.isEmpty ? 1 : 2;
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
