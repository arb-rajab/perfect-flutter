import 'dart:async';

import 'package:beta/domain/question_data.dart';
import 'package:flutter/material.dart';

class QuestionsReportScreen extends StatelessWidget {
  static const String route = '/questions-report';

  const QuestionsReportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class QuestionsReportScreenArgument {
  final List<QuestionData> questions;
  final Timer timer;

  QuestionsReportScreenArgument({required this.questions, required this.timer});
}
