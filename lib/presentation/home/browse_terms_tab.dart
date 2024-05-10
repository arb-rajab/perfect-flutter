import 'package:beta/presentation/home/browse_terms_tab_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class BrowseTermsTab extends StatefulWidget {
  const BrowseTermsTab({super.key});

  @override
  State<StatefulWidget> createState() => _BrowseTermsTabState();
}

class _BrowseTermsTabState extends State<BrowseTermsTab> {
  late BrowseTermsTabController _controller;
  @override
  void initState() {
    Get.delete<BrowseTermsTabController>();
    _controller = Get.put(BrowseTermsTabController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ItemsList(controller: _controller);
  }
}
