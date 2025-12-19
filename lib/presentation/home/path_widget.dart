// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class PathWidget extends StatelessWidget {
  final List<TermData> termDatas;
  const PathWidget({super.key, required this.termDatas});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: termDatas
          .map((termData) => InkWell(
                onTap: () async {
                  Get.delete<TermData>();
                  Get.put(termData);
                  TermService termService = Get.find();
                  TermTagService termTagService = Get.find();
                  TermsController termsController = Get.find();
                  TermsListingController termsListingController = Get.find();
                  List<TermData> subTerms =
                      await termService.getSubTerms(termData.term.id);
                  List<TermTag> termsTags =
                      await termTagService.getTermsTags(subTerms);
                  if (termsTags.isNotEmpty) {
                    await Get.delete<TermData>(tag: 'source');
                    Get.put(termData, tag: 'source');
                    termsController.state.setState(() {
                      termsController.termsTags = termsTags;
                      termsController.termsDatas = subTerms;
                      termsListingController.termsListing.removeRange(
                          termsListingController.termsListing
                                  .indexOf(termData) +
                              1,
                          termsListingController.termsListing.length);
                      // tagListingController.items = termsTags;
                    });
                    return;
                  }
                  if (subTerms.isNotEmpty) {
                    termsController.state.setState(() {
                      termsController.termsDatas = subTerms;
                      termsListingController.items = subTerms;
                      termsListingController.termsListing.removeRange(
                          termsListingController.termsListing
                                  .indexOf(termData) +
                              1,
                          termsListingController.termsListing.length);
                    });
                    return;
                  }
                  // TermsListingController termsListingController = Get.find();
                  // TermsController termsController = Get.find();
                  // termsController.termsTags.clear();
                  // termDatas.removeRange(
                  //     termDatas.indexOf(termData) + 1, termDatas.length);
                  // termsListingController.init();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(termData.term.name),
                    const Icon(Icons.navigate_next)
                  ],
                ),
              ))
          .toList(),
    );
  }
}
