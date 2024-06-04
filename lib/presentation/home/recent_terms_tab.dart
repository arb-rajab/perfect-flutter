import 'package:beta/presentation/home/recent_terms_tab_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class RecentTermsTab extends StatefulWidget {
  const RecentTermsTab({super.key});

  @override
  State<StatefulWidget> createState() => _RecentTermsTabState();
}

class _RecentTermsTabState extends State<RecentTermsTab> {
  late RecentTermsTabController recentTermsTabController;
  late TermsListingController termsListingController;

  @override
  void initState() {
    Get.delete<RecentTermsTabController>();
    recentTermsTabController = Get.put(RecentTermsTabController(this));
    termsListingController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PopScope(
      canPop: recentTermsTabController.canPop(),
      onPopInvoked: (value) {
        recentTermsTabController.onPopScoped();
        termsListingController.init();
      },
      child: ItemsList(controller: termsListingController));
}
