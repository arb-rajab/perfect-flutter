import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/domain/term_data.dart';
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
}
