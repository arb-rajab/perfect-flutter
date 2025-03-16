import 'dart:convert';

import 'package:beta/presentation/home/browse_terms_tab_controller.dart';
import 'package:beta/presentation/home/path_widget.dart';
import 'package:beta/presentation/home/question_tag_listing_controller.dart';
import 'package:beta/presentation/home/question_tag_path_widget.dart';
import 'package:beta/presentation/home/term_tag_listing_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    TermsListingController termsListingController = Get.find();
    TermTagListingController tagListingController = Get.find();
    QuestionTagListingController questionTagListingController = Get.find();
    return PopScope(
        canPop: _controller.canTabPop(),
        onPopInvokedWithResult: _controller.onTabPopInvoked,
        child: Builder(
          builder: (context) {
            if (_controller.questionTagDatas.isNotEmpty) {
              return Column(
                children: [
                  QuestionTagPathWidget(
                      questionTagListingItems:
                          questionTagListingController.questionTagListing),
                  Expanded(
                    child: ItemsList(
                        key: Key(jsonEncode(_controller.questionTagDatas)),
                        controller: questionTagListingController),
                  ),
                ],
              );
            }
            if (_controller.termsTags.isNotEmpty) {
              return Column(
                children: [
                  PathWidget(termDatas: termsListingController.termsListing),
                  Expanded(child: ItemsList(controller: tagListingController)),
                ],
              );
            }
            return Column(
              children: [
                PathWidget(termDatas: termsListingController.termsListing),
                Expanded(
                    child: ItemsList(
                        key: Key(jsonEncode(_controller.termsDatas
                            .map((e) => e.toJson())
                            .toList())),
                        controller: termsListingController)),
              ],
            );
          },
        ));
  }
}
