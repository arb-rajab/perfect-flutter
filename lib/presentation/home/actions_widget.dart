import 'dart:io';

import 'package:beta/application/services/term_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:beta/presentation/home/term_widget_controller.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//TODO add test
class ActionsWidget extends StatefulWidget {
  final bool downloaded;
  final bool studied;
  final bool downloading;
  final double? downloadProgress;
  final TermWidgetController termWidgetController;
  const ActionsWidget(this.termWidgetController,
      {super.key,
      required this.downloaded,
      required this.studied,
      required this.downloading,
      required this.downloadProgress});

  @override
  State<ActionsWidget> createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends State<ActionsWidget> {
  TermService termService = Get.find();
  @override
  Widget build(BuildContext context) {
    TermData termData = widget.termWidgetController.termData;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (TermType.downloadable(termData) && widget.downloaded)
          IconButton(
              onPressed: () {
                showConfirmationDialog(context, () async {
                  if (TermType.hasContent(termData)) {
                    await termService.deleteTermContent(termData.term);
                    widget.termWidgetController.state.setState(() {
                      widget.termWidgetController.isDownloaded = false;
                      termData.numberOfFlashcards = const NumberOfSubTerms(0);
                      termData.numberOfQuestions = const NumberOfSubTerms(0);
                    });
                  } else if (TermType.hasFile(termData)) {
                    File file = File(join(
                        (await getApplicationSupportDirectory()).path,
                        'term$separator${termData.term.id}'));
                    if (await file.exists()) await file.delete();
                    widget.termWidgetController.state.setState(() {
                      widget.termWidgetController.isDownloaded = false;
                    });
                  }
                });
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              )),
        
        if (TermType.downloadable(termData) &&
            !widget.downloaded &&
            !widget.downloading)
            IconButton(
                onPressed: widget.termWidgetController.downloadContent,
                icon: const Icon(Icons.cloud_download))
        else if (widget.downloading)
            CircularProgressIndicator(
                value: TermType.hasFile(termData)
                    ? widget.downloadProgress
                    : null),
        if (TermType.downloadable(termData) &&
            termData.term.needsUpdate == 1 &&
            widget.downloaded)
          if (!widget.downloading)
            IconButton(
                onPressed: widget.termWidgetController.downloadContent,
                icon: const Icon(Icons.refresh))
          else
            CircularProgressIndicator(value: widget.downloadProgress),
        if (termData.term.type != TermType.term)
          IconButton(
            onPressed: () =>
                widget.termWidgetController.updateStudied(!widget.studied),
            icon: widget.studied
                ? Icon(
                    Icons.fact_check,
                    color: Theme.of(context).primaryColor,
                  )
                : Icon(
                    Icons.fact_check_outlined,
                    color: Theme.of(context).disabledColor,
                  ),
          ),
        if (termData.numberOfRelatedTerms!.value! > 0)
          IconButton(
              onPressed: () async {
                List<TermData> relatedTerms =
                    await termService.getTermRelatedTerms(termData);
                TermsController termsController = Get.find();
                TermsListingController termsListingController = Get.find();
                Get.delete<TermData>(tag: 'relatedTerm');
                Get.put(termData, tag: 'relatedTerm');
                termsController.state.setState(() {
                  // termsController.relatedTerms = relatedTerms;
                  termsController.termsDatas = relatedTerms;
                  // termsListingController.items = relatedTerms;
                });
              },
              icon: const Icon(Icons.link))
      ],
    );
  }
}
