import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:flutter/widgets.dart';

class QuestionsScreen extends StatefulWidget {
  static const String route = '/questions';

  const QuestionsScreen({super.key});
  @override
  State<StatefulWidget> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class QuestionsScreenArgument {
  final String? query;
  final QuestionScreenSource source;
  final Id? sourceId;
  final Id? resourceTermId;
  final t.Title title;
  TermData? termData;

  QuestionsScreenArgument(
      {required this.query,
      required this.source,
      required this.sourceId,
      required this.resourceTermId,
      required this.title,
      this.termData});
}

enum QuestionScreenSource {
  questionTag,
  search,
  favorite,
  edited,
  easy,
  medium,
  difficult,
  wrong,
  term
}
