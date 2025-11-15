import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/actions_widget.dart';
import 'package:beta/presentation/home/term_leading_widget.dart';
import 'package:beta/presentation/home/term_widget_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/widgets/number_of_children_widget.dart';
import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class TermWidget extends StatefulWidget {
  final int index;
  const TermWidget({super.key, required this.index});

  @override
  State<TermWidget> createState() => _TermWidgetState();
}

class _TermWidgetState extends State<TermWidget> {
  late TermWidgetController termWidgetController;

  @override
  void initState() {
    termWidgetController = TermWidgetController(this, index: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    termWidgetController.termsListingController =
        Get.find<TermsListingController>();
    termWidgetController.termData =
        termWidgetController.termsListingController.items[widget.index];
    TermData termData = termWidgetController.termData;
    if (kIsWeb &&
        [TermType.ebook, TermType.youtubeVideos, TermType.voiceNotes]
            .contains(termData.term.type)) {
      return const UnsupportedContentWebWidget();
    }
    if (![
      TermType.term,
      TermType.questions,
      TermType.template,
      TermType.ebook,
      TermType.youtubeVideos,
      TermType.flashcards,
      TermType.voiceNotes
    ].contains(termData.term.type)) {
      return const UnsupportedContentWidget();
    }
    var widgett = InkWell(
      // behavior: HitTestBehavior.opaque,
      onTap: termWidgetController.onTermClick,
      child: Column(
        children: [
          ListTile(
            leading: TermLeadingWidget(termData),
            title: Text(termData.term.name),
            subtitle: termData.term.outerNote.isNotEmpty
                ? Text(termData.term.outerNote)
                : null,
            trailing: termData.term.enabled == 1
                ? const Icon(Icons.navigate_next)
                : const Icon(Icons.lock),
          ),
          if (termData.term.enabled == 1)
            Column(
              children: [
                const Divider(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      NumberOfChildrenWidget(termData),
                      ActionsWidget(
                        termWidgetController,
                        downloaded: termWidgetController.isDownloaded,
                        studied: termWidgetController.isStudied,
                        favorite: termWidgetController.isFavorite,
                        downloadProgress: termWidgetController.downloadProgress,
                        downloading: termWidgetController.downloading,
                      )
                    ]),
              ],
            )
        ],
      ),
    );
    if (termWidgetController.isNew) {
      return Column(
        children: [
          if (termWidgetController.displayLabel())
            LabelWidget(termWidgetController: termWidgetController),
          WidgetWrapperWithBorder(
            child: Banner(
                message: StringConstant.neww.tr(),
                location: BannerLocation.topStart,
                child: widgett),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          if (termWidgetController.displayLabel())
            LabelWidget(termWidgetController: termWidgetController),
          WidgetWrapperWithBorder(child: widgett),
        ],
      );
    }
  }
}

class UnsupportedContentWidget extends StatelessWidget {
  const UnsupportedContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetWrapperWithBorder(
        child: ListTile(
      title: Text(StringConstant.unsupportedContent.tr()),
      subtitle: Text(StringConstant.unsupportedContentExplanation.tr()),
    ));
  }
}

class UnsupportedContentWebWidget extends StatelessWidget {
  const UnsupportedContentWebWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetWrapperWithBorder(
        child: ListTile(
      title: Text(StringConstant.unsupportedContent.tr()),
      subtitle: Text(StringConstant.unsupportedContentWebExplanation.tr()),
    ));
  }
}

class LabelWidget extends StatelessWidget {
  final TermWidgetController termWidgetController;
  const LabelWidget({super.key, required this.termWidgetController});

  @override
  Widget build(BuildContext context) {
    return WidgetWrapperWithBorder(
        child: ListTile(
      leading: const Icon(Icons.bookmark),
      titleAlignment: ListTileTitleAlignment.center,
      title: Text(termWidgetController.getLabelText(),
          style: Theme.of(context).textTheme.headlineSmall),
    ));
  }
}
