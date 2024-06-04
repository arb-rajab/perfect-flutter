// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_tag_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/presentation/home/term_tag_listing_controller.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class TermTagWidget extends StatelessWidget {
  final int index;

  const TermTagWidget({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    IconData iconData = Icons.import_contacts;
    String text = '';
    TermsListingController controller = Get.find();
    TermsController termsController = Get.find();
    if (index < termsController.termsTags.length) {
      TermTag termTag = termsController.termsTags[index];
      text = termTag.name;
      iconData = Icons.import_contacts;
    } else {
      if (index - termsController.termsTags.length <
          termsController.termTagButtons.length) {
        switch (termsController
            .termTagButtons[index - termsController.termsTags.length]) {
          case TermTagButton.others:
            text = StringConstant.others.tr();
            iconData = Icons.import_contacts;
            break;
          case TermTagButton.questionTags:
            text = StringConstant.questionTags.tr();
            iconData = Icons.style_outlined;
            break;
          case TermTagButton.search:
            text = StringConstant.search.tr();
            iconData = Icons.search;
            break;
          case TermTagButton.favorite:
            text = StringConstant.favorite.tr();
            iconData = Icons.star;
            break;
          case TermTagButton.edited:
            text = StringConstant.edited.tr();
            iconData = Icons.rule;
            break;
          case TermTagButton.easy:
            text = StringConstant.easyQuestions.tr();
            iconData = Icons.maximize;
            break;
          case TermTagButton.medium:
            text = StringConstant.mediumQuestions.tr();
            iconData = Icons.horizontal_rule;
            break;
          case TermTagButton.difficult:
            text = StringConstant.difficultQuestions.tr();
            iconData = Icons.minimize;
            break;
          case TermTagButton.wrong:
            text = StringConstant.wrongQuestions.tr();
            iconData = Icons.block;
            break;
        }
      }
    }
    return GestureDetector(
      onTap: () async {
        if (index < termsController.termsTags.length) {
          TermTag termTag = termsController.termsTags[index];
          List<TermData> subTerms = termsController.termsDatas
              .where((element) => element.tagId!.value == termTag.id)
              .toList();
          Get.delete<TermTag>();
          Get.put(termTag);
          termsController.state.setState(() {
            termsController.termsTags.clear();
            controller.items = subTerms;
            termsController.termsDatas = subTerms;
          });
          return;
        }
        TermData termData = Get.find<TermData>();
        Get.delete<QuestionsScreenArgument>();
        switch (termsController
            .termTagButtons[index - termsController.termsTags.length]) {
          case TermTagButton.others:
            List<TermData> subTerms = termsController.termsDatas
                .where((element) => element.tagId!.value == null)
                .toList();
            termsController.state.setState(() {
              termsController.termsTags.clear();
              controller.items = subTerms;
              termsController.termsDatas = subTerms;
            });
            return;
          case TermTagButton.questionTags:
            QuestionTagService questionTagService = Get.find();
            questionTagService.getTermQuestionsTags(termData).then((value) {
              termsController.state.setState(() {
                termsController.questionTagDatas = value;
              });
            });
            return;
          case TermTagButton.search:
            Get.put(QuestionsScreenArgument(
                query: null,
                source: QuestionScreenSource.search,
                sourceId: Id(termData.term.id),
                resourceTermId: Id(termData.term.id),
                title: t.Title(StringConstant.search.tr())));
            Navigator.pushNamed(context, QuestionsScreen.route);
            return;
          case TermTagButton.favorite:
            Get.put(QuestionsScreenArgument(
                query:
                    "q.id in (select questionId from questionProperties where name='favorite' and value ='true') and q.parentTermId in (select termId from termTrees where parentTermId =${termData.term.id} and depth>0) order by q.id asc",
                source: QuestionScreenSource.favorite,
                sourceId: Id(termData.term.id),
                resourceTermId: Id(termData.term.id),
                title: t.Title(StringConstant.favorite.tr())));
            Navigator.pushNamed(context, QuestionsScreen.route);
            return;
          case TermTagButton.edited:
            Get.put(QuestionsScreenArgument(
                query:
                    "q.edited =1 and q.parentTermId in (select termId from termTrees where parentTermId =${termData.term.id} and depth>0) order by q.id asc",
                source: QuestionScreenSource.edited,
                sourceId: Id(termData.term.id),
                resourceTermId: Id(termData.term.id),
                title: t.Title(StringConstant.edited.tr())));
            Navigator.pushNamed(context, QuestionsScreen.route);
            return;
          case TermTagButton.easy:
            Get.put(QuestionsScreenArgument(
                query:
                    "q.id in (select parentQuestionId from answers where isCorrect=1 and parentQuestionId=q.id and checkedCount=(select max(checkedCount) from answers where parentQuestionId=q.id) ) and (select sum(checkedCount) from answers where parentQuestionId=q.id)>25 and q.parentTermId in (select termId from termTrees where parentTermId=${termData.term.id})",
                source: QuestionScreenSource.easy,
                sourceId: Id(termData.term.id),
                resourceTermId: Id(termData.term.id),
                title: t.Title(StringConstant.easyQuestions.tr())));
            Navigator.pushNamed(context, QuestionsScreen.route);
            return;
          case TermTagButton.medium:
            Get.put(QuestionsScreenArgument(
                query:
                    "q.id in (select parentQuestionId from answers where isCorrect=1 and parentQuestionId=q.id and checkedCount<(select max(checkedCount) from answers where parentQuestionId=q.id) and checkedCount> (select min(checkedCount) from answers where parentQuestionId=q.id)) and (select sum(checkedCount) from answers where parentQuestionId=q.id)>25 and q.parentTermId in (select termId from termTrees where parentTermId=${termData.term.id})",
                source: QuestionScreenSource.medium,
                sourceId: Id(termData.term.id),
                resourceTermId: Id(termData.term.id),
                title: t.Title(StringConstant.mediumQuestions.tr())));
            Navigator.pushNamed(context, QuestionsScreen.route);
            return;
          case TermTagButton.difficult:
            Get.put(QuestionsScreenArgument(
                query:
                    "q.id in (select parentQuestionId from answers where isCorrect=1 and parentQuestionId=q.id and checkedCount=(select min(checkedCount) from answers where parentQuestionId=q.id) ) and (select sum(checkedCount) from answers where parentQuestionId=q.id)>25 and q.parentTermId in (select termId from termTrees where parentTermId=${termData.term.id})",
                source: QuestionScreenSource.difficult,
                sourceId: Id(termData.term.id),
                resourceTermId: Id(termData.term.id),
                title: t.Title(StringConstant.difficultQuestions.tr())));
            Navigator.pushNamed(context, QuestionsScreen.route);
            return;
          case TermTagButton.wrong:
            Get.put(QuestionsScreenArgument(
                query:
                    "q.id in (select parentQuestionId from answers where isCorrect=0 and id in (select answerId from answerProperties where name='checked' and value='true'))and q.parentTermId in (select termId from termTrees where parentTermId =${termData.term.id} and depth>0)  order by q.id asc",
                source: QuestionScreenSource.wrong,
                sourceId: Id(termData.term.id),
                resourceTermId: Id(termData.term.id),
                title: t.Title(StringConstant.wrongQuestions.tr())));
            Navigator.pushNamed(context, QuestionsScreen.route);
            return;
        }
      },
      child: WidgetWrapperWithBorder(
          child: Center(
        child: Column(children: [
          Icon(iconData, color: Theme.of(context).primaryColor),
          Text(text, style: Theme.of(context).textTheme.titleMedium)
        ]),
      )),
    );
  }
}
