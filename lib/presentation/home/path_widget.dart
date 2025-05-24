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
                onTap: () {
                  Get.delete<TermData>();
                  Get.put(termData);
                  TermsListingController termsListingController = Get.find();
                  TermsController termsController = Get.find();
                  termsController.termsTags.clear();
                  termDatas.removeRange(
                      termDatas.indexOf(termData) + 1, termDatas.length);
                  termsListingController.init();
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
