import 'package:beta/domain/term_data.dart';
import 'package:flutter/material.dart';

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
