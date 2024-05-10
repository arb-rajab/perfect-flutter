import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/actions_widget.dart';
import 'package:beta/presentation/home/term_widget_controller.dart';
import 'package:beta/presentation/widgets/number_of_children_widget.dart';
import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class TermLeadingWidget extends StatelessWidget {
  final TermData termData;
  const TermLeadingWidget(
    this.termData, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double iconSize = 50;
    switch (termData.term.type) {
      case TermType.questions:
        return const Icon(Icons.question_mark, size: iconSize);
      case TermType.ebook:
        return const Icon(Icons.book, size: iconSize);
      case TermType.template:
        return const Icon(Icons.quiz, size: iconSize);
      case TermType.youtubeVideos:
        return const Icon(Icons.slow_motion_video, size: iconSize);
      case TermType.flashcards:
        return const Icon(Icons.style, size: iconSize);
      case TermType.voiceNotes:
        return const Icon(Icons.audiotrack, size: iconSize);
      default:
        return const Icon(Icons.description, size: iconSize);
    }
  }
}

class TermWidget extends StatefulWidget {
  final int index;
  const TermWidget({super.key, required this.index});

  @override
  State<StatefulWidget> createState() => _TermWidgetState();
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

class _TermWidgetState extends State<TermWidget> {
  late TermWidgetController _termWidgetController;
  late TermData _termData;

  @override
  Widget build(BuildContext context) {
    if (_termData.term.type != 0) return const UnsupportedContentWidget();
    var widget = WidgetWrapperWithBorder(
        child: ListTile(
      onTap: _termWidgetController.onTermClick,
      leading: TermLeadingWidget(_termData),
      title: Text(_termData.term.name),
      subtitle: _termData.term.enabled == 1
          ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              NumberOfChildrenWidget(_termData),
              ActionsWidget(
                _termWidgetController,
                downloaded: _termWidgetController.isDownloaded,
                studied: _termWidgetController.isStudied,
                downloadProgress: _termWidgetController.downloadProgress,
                downloading: _termWidgetController.downloading,
              )
            ])
          : null,
      trailing: _termData.term.enabled == 1
          ? const Icon(Icons.navigate_next)
          : const Icon(Icons.lock),
    ));
    if (_termWidgetController.isNew) {
      return Column(
        children: [
          if (_termWidgetController.displayLabel())
            LabelWidget(termWidgetController: _termWidgetController),
          Banner(
              message: StringConstant.neww.tr(),
              location: BannerLocation.topStart,
              child: widget),
        ],
      );
    } else {
      return Column(
        children: [
          if (_termWidgetController.displayLabel())
            LabelWidget(termWidgetController: _termWidgetController),
          widget,
        ],
      );
    }
  }

  @override
  void initState() {
    Get.delete<TermWidgetController>(tag: widget.index.toString());
    _termWidgetController = Get.put(TermWidgetController(index: widget.index),
        tag: widget.index.toString());
    _termData = _termWidgetController.termData;
    super.initState();
  }
}
