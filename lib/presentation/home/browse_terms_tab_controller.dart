import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/question_tag_listing_controller.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class BrowseTermsTabController extends TermsController {
  bool backPressed = false;
  late TermsListingController termsListingController;

  BrowseTermsTabController(State state) : super(state: state) {
    termsListingController = Get.find();
    termsListingController.fetch = fetch;
  }

  @override
  Future<List> fetch() async {
    List superData = await super.fetch();
    if (superData.isNotEmpty) return Future.value(superData);
    TermService termService = Get.find();
    List<TermData> terms;
    if (termsListingController.termsListing.isEmpty) {
      terms = await termsListingController.termService.getFirstLayerTerms();
    } else {
      TermData termData = Get.find();
      terms = await termService.getSubTerms(termData.term.id);
      // if (!reload) termsListing.add(termData);
    }
    if (Get.isRegistered<TermTag>()) {
      TermTag tag = Get.find();
      terms = terms.where((element) => element.tagId!.value == tag.id).toList();
      await Get.delete<TermTag>();
    }
    // if (terms.length == 1 &&
    //     terms[0].term.type == TermType.term &&
    //     Get.isRegistered<BrowseTermsTabController>() &&
    //     !Get.find<BrowseTermsTabController>().backPressed) {
    //   await Get.delete<TermData>();
    //   Get.put(terms[0]);
    //   termsListing.add(terms[0]);
    //   // ignore: recursive_getters
    //   return fetch!();
    // }
    return Future.value(terms);
  }

  bool canTabPop() {
    if (questionTagDatas.isNotEmpty) return false;
    if (termsTags.isNotEmpty) return false;
    if (termsListingController.termsListing.isNotEmpty) return false;
    return true;
  }

  onTabPopInvoked(bool didPop, result) async {
    if (didPop) return;
    BrowseTermsTabController controller = Get.find();
    QuestionTagListingController questionTagListingController = Get.find();
    TermsListingController termsListingController = Get.find();
    TermsController termsController = Get.find();
    if (controller.questionTagDatas.isNotEmpty) {
      QuestionTagService questionTagService = Get.find();
      controller.backPressed = true;
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
          Get.delete<QuestionTagData>();
          Get.put(questionTagData);

          questionTagDatas =
              await questionTagService.getAllQuestionsTagChild(questionTagData);
          questionTagListingController.numberOfOthers = await questionTagService
              .getNumberOfOtherQuestionsQuestionTag(questionTagData, termData);
        }
      }
      questionTagListingController.items.clear();
      controller.questionTagDatas = questionTagDatas;
      questionTagListingController.init();
      return;
    }
    if (controller.termsTags.isNotEmpty) {
      controller.backPressed = true;
      termsListingController.termsListing.removeLast();
      if (termsListingController.termsListing.isNotEmpty) {
        TermData termData = termsListingController.termsListing.last;
        await Get.delete<TermData>();
        Get.put(termData);
      }
      controller.termsTags.clear();
      termsListingController.init();
      return;
    }
    controller.backPressed = true;
    if (termsListingController.termsListing.isEmpty) return;
    await termsController.onPopScoped();
  }
}
