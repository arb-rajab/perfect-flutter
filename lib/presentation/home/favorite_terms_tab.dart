import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/home/favorite_terms_tab_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FavoriteTermsTab extends StatefulWidget {
  const FavoriteTermsTab({super.key});

  @override
  State<StatefulWidget> createState() => _FavoriteTermsTabState();
}

class _FavoriteTermsTabState extends State<FavoriteTermsTab> {
  late FavoriteTermsTabController favoriteTermsTabController;
  late TermsListingController termsListingController;

  @override
  void initState() {
    Get.delete<FavoriteTermsTabController>();
    favoriteTermsTabController = Get.put(FavoriteTermsTabController(this));
    termsListingController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PopScope(
      canPop: favoriteTermsTabController.canPop(),
      onPopInvokedWithResult: (value, result) {
        favoriteTermsTabController.onPopScoped();
        termsListingController.init();
      },
      child: ItemsList(controller: termsListingController));
}
