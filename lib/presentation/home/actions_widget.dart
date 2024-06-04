import 'package:beta/application/services/term_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/term_widget_controller.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

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
  @override
  Widget build(BuildContext context) {
    TermData termData = widget.termWidgetController.termData;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (TermType.hasFile(termData) && widget.downloaded)
          IconButton(
              onPressed: () {
                //TODO implement delete term
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              )),
        if (TermType.downloadable(termData) && !widget.downloaded)
          if (!widget.downloading)
            IconButton(
                onPressed: widget.termWidgetController.downloadContent,
                icon: const Icon(Icons.cloud_download))
          else
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
                TermService termService = Get.find();
                List<TermData> relatedTerms =
                    await termService.getTermRelatedTerms(termData);
                TermsController termsController = Get.find();
                TermsListingController termsListingController = Get.find();
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
