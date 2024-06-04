import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/home/unstudied_terms_tab_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class UnstudiedTermsTab extends StatefulWidget {
  const UnstudiedTermsTab({super.key});

  @override
  State<StatefulWidget> createState() => _UnstudiedTermsTabState();
}

class _UnstudiedTermsTabState extends State<UnstudiedTermsTab> {
  late UnstudiedTermsTabController unstudiedTermsTabController;
  late TermsListingController termsListingController;

  @override
  void initState() {
    Get.delete<UnstudiedTermsTabController>();
    unstudiedTermsTabController = Get.put(UnstudiedTermsTabController(this));
    termsListingController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PopScope(
      canPop: unstudiedTermsTabController.canPop(),
      onPopInvoked: (value) {
        unstudiedTermsTabController.onPopScoped();
        termsListingController.init();
      },
      child: ItemsList(controller: termsListingController));
}
