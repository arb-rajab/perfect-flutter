// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/question_tag_listing_controller.dart';
import 'package:beta/presentation/home/term_tag_listing_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class TermsController {
  List<TermData> termsDatas = [];
  List<TermTag> termsTags = [];
  List<TermTagButton> termTagButtons = [];
  List<QuestionTagData> questionTagDatas = [];
  // List<TermData> relatedTerms = [];

  final State state;

  TermsController({required this.state}) {
    Get.delete<TermsListingController>();
    Get.delete<TermTagListingController>();
    Get.delete<QuestionTagListingController>();
    Get.delete<TermsController>();
    Get.delete<TermData>(tag: 'relatedTerm');
    Get.put(this);
    Get.put(TermsListingController(state));
    Get.put(TermTagListingController(state));
    Get.put(QuestionTagListingController(state));
  }

  Future<List> fetch() {
    if (Get.isRegistered<TermData>(tag: 'relatedTerm')) {
      // return Future.value(relatedTerms);
      return Future.value(termsDatas);
    }
    return Future.value([]);
  }

  bool canPop() {
    if (Get.isRegistered<TermData>(tag: 'relatedTerm')) {
      return false;
    }
    TermsListingController termsListingController = Get.find();
    if (termsListingController.termsListing.isNotEmpty &&
        Get.isRegistered<TermData>(tag: 'source')) {
      if (termsListingController.termsListing.last ==
          Get.find<TermData>(tag: 'source')) return false;
    }
    return true;
  }

  Future onPopScoped() async {
    if (Get.isRegistered<TermData>(tag: 'relatedTerm')) {
      Get.delete<TermData>(tag: 'relatedTerm');
      // relatedTerms.clear();
      state.setState(() {});
    }
    TermsListingController termsListingController = Get.find();
    TermService termService = Get.find();
    if (termsListingController.termsListing.isNotEmpty &&
        Get.isRegistered<TermData>(tag: 'source')) {
      TermData termData = Get.find(tag: 'source');
      if (termsListingController.termsListing.last ==
          Get.find<TermData>(tag: 'source')) {
        TermTagService termTagService = Get.find();
        List<TermData> subTerms =
            await termService.getSubTerms(termData.term.id);
        List<TermTag> termsTags = await termTagService.getTermsTags(subTerms);
        state.setState(() {
          this.termsTags = termsTags;
          termsDatas = subTerms;
        });
        return;
      }
    }
    if (termsListingController.termsListing.isNotEmpty) {
      termsListingController.termsListing.removeLast();
      List<TermData> termsDatas;
      if (termsListingController.termsListing.isEmpty) {
        termsDatas = await termService.getFirstLayerTerms();
        state.setState(() {
          this.termsDatas = termsDatas;
          termsListingController.items = termsDatas;
        });
        return;
      }
      await Get.delete<TermData>();
      TermData termData = termsListingController.termsListing.last;
      Get.put(termData);
      termsDatas = await termService.getSubTerms(termData.term.id);
      state.setState(() {
        this.termsDatas = termsDatas;
        termsListingController.items = termsDatas;
      });
    }
  }
}
