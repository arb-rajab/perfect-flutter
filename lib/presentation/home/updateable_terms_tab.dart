import 'dart:convert';

import 'package:beta/presentation/home/updateable_terms_tab_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class UpdateableTermsTab extends StatefulWidget {
  const UpdateableTermsTab({super.key});

  @override
  State<StatefulWidget> createState() => _UpdateableTermsTabState();
}

class _UpdateableTermsTabState extends State<UpdateableTermsTab> {
  late UpdateableTermsTabController updateableTermsTabController;
  late TermsListingController termsListingController;

  @override
  void initState() {
    Get.delete<UpdateableTermsTabController>();
    updateableTermsTabController = Get.put(UpdateableTermsTabController(this));
    termsListingController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PopScope(
      canPop: updateableTermsTabController.canPop(),
      onPopInvokedWithResult: (value, result) {
        updateableTermsTabController.onPopScoped();
        termsListingController.init();
      },
      child: ItemsList(
          key: Key(jsonEncode(updateableTermsTabController.termsDatas)),
          controller: termsListingController));
}
