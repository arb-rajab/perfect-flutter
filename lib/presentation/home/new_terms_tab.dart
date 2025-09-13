import 'dart:convert';

import 'package:beta/presentation/home/new_terms_tab_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class NewTermsTab extends StatefulWidget {
  const NewTermsTab({super.key});

  @override
  State<StatefulWidget> createState() => _NewTermsTabState();
}

class _NewTermsTabState extends State<NewTermsTab> {
  late NewTermsTabController newTermsTabController;
  late TermsListingController termsListingController;

  @override
  void initState() {
    Get.delete<NewTermsTabController>();
    newTermsTabController = Get.put(NewTermsTabController(this));
    termsListingController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PopScope(
      canPop: newTermsTabController.canPop(),
      onPopInvokedWithResult: (value, result) {
        newTermsTabController.onPopScoped();
        termsListingController.init();
      },
      child: ItemsList(
          key: Key(jsonEncode(newTermsTabController.termsDatas)),
          controller: termsListingController));
}
