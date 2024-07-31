import 'package:animated_number/animated_number.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/widgets/animated_counter.dart';
import 'package:flutter/material.dart';

//TODO add test
class NumberOfChildrenWidget extends StatelessWidget {
  final TermData termData;

  const NumberOfChildrenWidget(this.termData, {super.key});

  @override
  Widget build(BuildContext context) {
    Icon icon;
    switch (termData.term.type) {
      case TermType.questions:
        icon = const Icon(Icons.question_answer);
        break;
      case TermType.ebook:
        icon = const Icon(Icons.book);
        break;
      case TermType.template:
        icon = const Icon(Icons.quiz);
        break;
      case TermType.youtubeVideos:
        icon = const Icon(Icons.slow_motion_video);
        break;
      case TermType.flashcards:
        icon = const Icon(Icons.style);
        break;
      case TermType.voiceNotes:
        icon = const Icon(Icons.audiotrack);
        break;
      default:
        icon = const Icon(Icons.description);
    }

    if ([
      TermType.flashcards,
      TermType.questions,
      TermType.template,
      TermType.term
    ].contains(termData.term.type)) {
      return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        icon,
        const Text('x'),
        if (termData.term.type == TermType.term)
          AnimatedCounter(value: termData.numberOfSubTerms!.value!),
        if (termData.term.type == TermType.questions ||
            termData.term.type == TermType.template)
          Text(termData.numberOfQuestions!.value!.toString()),
        if (termData.term.type == TermType.flashcards)
          Text(termData.numberOfFlashcards!.value!.toString())
      ]);
    }
    return const SizedBox();
  }
}
