import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/term_widget_controller.dart';
import 'package:flutter/material.dart';

//TODO add test
class ActionsWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    TermData termData = termWidgetController.termData;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (TermType.hasFile(termData) && downloaded)
          IconButton(
              onPressed: () {
                //TODO implement delete term
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              )),
        if (TermType.downloadable(termData) && !downloaded)
          if (!downloading)
            IconButton(
                onPressed: () => termWidgetController.downloadContent(),
                icon: const Icon(Icons.cloud_download))
          else
            CircularProgressIndicator(value: downloadProgress),
        if (TermType.downloadable(termData) &&
            termData.term.needsUpdate == 1 &&
            downloaded)
          if (!downloading)
            IconButton(
                onPressed: () => termWidgetController.downloadContent(),
                icon: const Icon(Icons.refresh))
          else
            CircularProgressIndicator(value: downloadProgress),
        if (termData.term.type != TermType.term)
          GestureDetector(
              onTap: () => termWidgetController.updateStudied(!studied),
              child: studied
                  ? Icon(
                      Icons.fact_check,
                      color: Theme.of(context).primaryColor,
                    )
                  : Icon(
                      Icons.fact_check_outlined,
                      color: Theme.of(context).disabledColor,
                    ))
      ],
    );
  }
}
