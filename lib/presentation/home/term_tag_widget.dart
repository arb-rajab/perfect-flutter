import 'package:beta/application/services/database_service.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class TermTagWidget extends StatelessWidget {
  final int index;

  const TermTagWidget({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    late IconData iconData;
    late String text;
    TermsListingController controller = Get.find();
    if (index < controller.termsTags.length) {
      TermTag termTag = controller.termsTags[index];
      text = termTag.name;
      iconData = Icons.import_contacts;
    }
    return GestureDetector(
      onTap: () {
        if (index < controller.termsTags.length) {
          TermTag termTag = controller.termsTags[index];
          controller.termDatas = controller.termDatas
              .where((element) => element.tagId == termTag.id)
              .toList();
        }
      },
      child: WidgetWrapperWithBorder(
          child: Column(children: [
        Icon(iconData, color: Theme.of(context).primaryColor),
        Text(text, style: Theme.of(context).textTheme.titleMedium)
      ])),
    );
  }
}
