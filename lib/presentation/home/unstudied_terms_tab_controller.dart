import 'package:beta/application/services/term_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class UnstudiedTermsTabController extends TermsController {
  late TermsListingController termsListingController;

  UnstudiedTermsTabController(State state) : super(state: state) {
    termsListingController = Get.find();
    termsListingController.fetch = fetch;
  }

  @override
  Future<List> fetch() async {
    List superData = await super.fetch();
    if (superData.isNotEmpty) return Future.value(superData);
    TermService termService = Get.find();
    List<TermData> terms;
    terms = await termService.getUnstudiedTerms();
    return Future.value(terms);
  }
}
