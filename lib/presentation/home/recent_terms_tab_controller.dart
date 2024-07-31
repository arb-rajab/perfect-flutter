import 'package:beta/application/services/term_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class RecentTermsTabController extends TermsController {
  late TermsListingController termsListingController;

  RecentTermsTabController(State state) : super(state: state) {
    termsListingController = Get.find();
    termsListingController.fetch = fetch;
    termsListingController.showLoadMore = true;
  }

  @override
  Future<List> fetch() async {
    List superData = await super.fetch();
    if (superData.isNotEmpty) return Future.value(superData);
    TermService termService = Get.find();
    List<TermData> terms;
    terms = await termService.getRecentTerms(
        limit: 10, offset: termsListingController.items.length);
    return Future.value([...termsListingController.items, ...terms]);
  }
}
