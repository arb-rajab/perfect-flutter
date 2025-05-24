import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/presentation/home/question_tag_listing_controller.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class QuestionTagPathWidget extends StatelessWidget {
  final List<QuestionTagListingItem> questionTagListingItems;
  const QuestionTagPathWidget(
      {super.key, required this.questionTagListingItems});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: questionTagListingItems
          .map((questionTagListingItem) => InkWell(
                onTap: () async {
                  QuestionTagService questionTagService = Get.find();
                  TermsController termsController = Get.find();
                  QuestionTagListingController questionTagListingController =
                      Get.find();
                  QuestionTagData questionTagData =
                      questionTagListingItem.questionTagData;
                  List<QuestionTagData> questionTagDatas =
                      await questionTagService
                          .getAllQuestionsTagChild(questionTagData);
                  await Get.delete<QuestionTagData>();

                  termsController.questionTagDatas = questionTagDatas;
                  questionTagListingController.numberOfOthers =
                      questionTagListingItem.numberOfOthers;
                  await Get.delete<QuestionTagData>();
                  Get.put<QuestionTagData>(questionTagData);
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
