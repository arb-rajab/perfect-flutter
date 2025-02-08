import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/presentation/home/question_tag_listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

//TODO add test
class QuestionTagPathWidget extends StatelessWidget {
  final List<QuestionTagListingItem> questionTagListingItems;
  const QuestionTagPathWidget(
      {super.key, required this.questionTagListingItems});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: questionTagListingItems
          .map((questionTagListingItem) => GestureDetector(
                onTap: () {
                  Get.delete<QuestionTagListingItem>();
                  Get.put(questionTagListingItem);
                  QuestionTagListingController questionTagListingController =
                      Get.find();
                  questionTagListingItems.removeRange(
                      questionTagListingItems.indexOf(questionTagListingItem) +
                          1,
                      questionTagListingItems.length);
                  questionTagListingController.init();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(questionTagListingItem
                        .questionTagData.questionTag.name),
                    const Icon(Icons.navigate_next)
                  ],
                ),
              ))
          .toList(),
    );
  }
}
