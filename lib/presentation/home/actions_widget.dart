import 'package:beta/application/services/path/shared.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:beta/presentation/home/term_widget_controller.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/homework/homework_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

class ActionsWidget extends StatefulWidget {
  final bool downloaded;
  final bool studied;
  final bool favorite;
  final bool downloading;
  final double? downloadProgress;
  final bool homeworkEnabled;
  final TermWidgetController termWidgetController;
  const ActionsWidget(
    this.termWidgetController, {
    super.key,
    required this.downloaded,
    required this.studied,
    required this.favorite,
    required this.downloading,
    required this.downloadProgress,
    this.homeworkEnabled = false,
  });

  @override
  State<ActionsWidget> createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends State<ActionsWidget> {
  TermService termService = Get.find();
  @override
  Widget build(BuildContext context) {
    TermData termData = widget.termWidgetController.termData;
    Get.delete<State<ActionsWidget>>(tag: termData.term.id.toString());
    Get.put<State<ActionsWidget>>(this, tag: termData.term.id.toString());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (TermType.downloadable(termData) &&
            widget.downloaded &&
            !widget.downloading &&
            !widget.termWidgetController.isDownloadingInBackground(termData))
          IconButton(
            onPressed: () {
              showConfirmationDialog(context, () async {
                if (TermType.hasContent(termData)) {
                  await termService.deleteTermContent(termData.term);
                  widget.termWidgetController.state.setState(() {
                    widget.termWidgetController.isDownloaded = false;
                    termData.numberOfFlashcards = const NumberOfSubTerms(0);
                    termData.numberOfImages = const NumberOfSubTerms(0);
                    termData.numberOfQuestions = const NumberOfSubTerms(0);
                  });
                } else if (TermType.hasFile(termData)) {
                  PathService pathService = Get.find();
                  await pathService.deleteFileFromSupport(
                    'term$separator${termData.term.id}',
                  );
                  widget.termWidgetController.state.setState(() {
                    widget.termWidgetController.isDownloaded = false;
                  });
                }
              });
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        if (TermType.downloadable(termData) &&
            !widget.downloaded &&
            !widget.downloading &&
            !widget.termWidgetController.isDownloadingInBackground(termData))
          IconButton(
            onPressed: widget.termWidgetController.downloadContent,
            icon: const Icon(Icons.cloud_download),
          )
        else if (widget.downloading ||
            widget.termWidgetController.isDownloadingInBackground(termData))
          CircularProgressIndicator(value: widget.downloadProgress),
        if (TermType.downloadable(termData) &&
            termData.term.needsUpdate == 1 &&
            widget.downloaded)
          if (!widget.downloading)
            IconButton(
              key: const Key('refresh'),
              tooltip: StringConstant.update.tr(),
              onPressed: widget.termWidgetController.downloadContent,
              icon: Badge(
                smallSize: 8,
                child: Icon(
                  Icons.system_update,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          else
            CircularProgressIndicator(value: widget.downloadProgress),
        if (termData.term.type != TermType.term)
          IconButton(
            onPressed: () =>
                widget.termWidgetController.updateStudied(!widget.studied),
            icon: widget.studied
                ? Icon(
                    key: const Key('studied'),
                    Icons.fact_check,
                    color: Theme.of(context).primaryColor,
                  )
                : Icon(
                    key: const Key('unstudied'),
                    Icons.fact_check_outlined,
                    color: Theme.of(context).disabledColor,
                  ),
          ),
        if (termData.term.type != TermType.term)
          IconButton(
            onPressed: () =>
                widget.termWidgetController.updateFavorite(!widget.favorite),
            icon: widget.favorite
                ? Icon(
                    key: const Key('favorite'),
                    Icons.star,
                    color: Theme.of(context).primaryColor,
                  )
                : Icon(
                    key: const Key('unfavorite'),
                    Icons.star_border,
                    color: Theme.of(context).disabledColor,
                  ),
          ),
        if (TermType.isHomeworkEligibleType(termData) && widget.homeworkEnabled)
          IconButton(
            onPressed: () {
              Get.delete<HomeworkScreenArgument>();
              Get.put(HomeworkScreenArgument(term: termData));
              context.push(HomeworkScreen.route);
            },
            icon: const Icon(Icons.assignment),
          ),
        if (termData.numberOfRelatedTerms!.value! > 0)
          IconButton(
            onPressed: () async {
              List<TermData> relatedTerms = await termService
                  .getTermRelatedTerms(termData);
              TermsController termsController = Get.find();
              Get.delete<TermData>(tag: 'relatedTerm');
              Get.put(termData, tag: 'relatedTerm');
              termsController.state.setState(() {
                // termsController.relatedTerms = relatedTerms;
                termsController.termsDatas = relatedTerms;
                // termsListingController.items = relatedTerms;
              });
            },
            icon: const Icon(Icons.link),
          ),
      ],
    );
  }
}
