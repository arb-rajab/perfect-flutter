import 'dart:convert';

import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/browse_terms_tab_controller.dart';
import 'package:beta/presentation/home/path_widget.dart';
import 'package:beta/presentation/home/question_tag_listing_controller.dart';
import 'package:beta/presentation/home/question_tag_path_widget.dart';
import 'package:beta/presentation/home/term_tag_listing_controller.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';

class BrowseTermsTab extends StatefulWidget {
  const BrowseTermsTab({super.key});

  @override
  State<StatefulWidget> createState() => _BrowseTermsTabState();
}

class _BrowseTermsTabState extends State<BrowseTermsTab> {
  late BrowseTermsTabController _controller;
  @override
  void initState() {
    Get.delete<BrowseTermsTabController>();
    _controller = Get.put(BrowseTermsTabController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TermsListingController termsListingController = Get.find();
    TermTagListingController tagListingController = Get.find();
    QuestionTagListingController questionTagListingController = Get.find();
    TermsController termsController = Get.find();
    TermService termService = Get.find();
    if (_controller.questionTagDatas.isNotEmpty) {
      return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            QuestionTagService questionTagService = Get.find();
            _controller.backPressed = true;
            List<QuestionTagData> questionTagDatas = [];
            questionTagListingController.numberOfOthers = 0;

            if (questionTagListingController.questionTagListing.isNotEmpty) {
              questionTagListingController.questionTagListing.removeLast();
              await Get.delete<QuestionTagData>();
              TermData termData = Get.find();
              if (questionTagListingController.questionTagListing.isEmpty) {
                questionTagDatas =
                    await questionTagService.getTermQuestionsTags(termData);
              } else {
                QuestionTagListingItem questionTagListingItem =
                    questionTagListingController.questionTagListing.last;
                QuestionTagData questionTagData =
                    questionTagListingItem.questionTagData;
                Get.put(questionTagData);

                questionTagDatas = await questionTagService
                    .getAllQuestionsTagChild(questionTagData);
                questionTagListingController.numberOfOthers =
                    await questionTagService
                        .getNumberOfOtherQuestionsQuestionTag(
                            questionTagData, termData);
              }
            }
            questionTagListingController.items.clear();
            _controller.questionTagDatas = questionTagDatas;
            questionTagListingController.init();
          },
          child: Column(
            children: [
              QuestionTagPathWidget(
                  questionTagListingItems:
                      questionTagListingController.questionTagListing),
              Expanded(
                child: ItemsList(
                    key: Key(jsonEncode(_controller.questionTagDatas)),
                    controller: questionTagListingController),
              ),
            ],
          ));
    }
    if (_controller.termsTags.isNotEmpty) {
      return PopScope(
          canPop: false,
          onPopInvoked: (value) async {
            _controller.backPressed = true;
            termsListingController.termsListing.removeLast();
            if (termsListingController.termsListing.isNotEmpty) {
              TermData termData = termsListingController.termsListing.last;
              await Get.delete<TermData>();
              Get.put(termData);
            }
            _controller.termsTags.clear();
            termsListingController.init();
          },
          child: Column(
            children: [
              PathWidget(termDatas: termsListingController.termsListing),
              Expanded(child: ItemsList(controller: tagListingController)),
            ],
          ));
    }
    // if (_controller.relatedTerms.isNotEmpty) {
    //   return PopScope(
    //       canPop: termsController.canPop(),
    //       onPopInvoked: (value) {
    //         termsController.onPopScoped();
    //       },
    //       child: ItemsList(
    //           key: Key(jsonEncode(
    //               _controller.relatedTerms.map((e) => e.toJson()).toList())),
    //           controller: termsListingController));
    // }
    return PopScope(
        canPop: termsListingController.termsListing.isEmpty,
        onPopInvoked: (bool value) async {
          _controller.backPressed = true;
          termsController.onPopScoped();
        },
        child: Column(
          children: [
            PathWidget(termDatas: termsListingController.termsListing),
            Expanded(
                child: ItemsList(
                    key: Key(jsonEncode(_controller.termsDatas
                        .map((e) => e.toJson())
                        .toList())),
                    controller: termsListingController)),
          ],
        ));
  }
}
