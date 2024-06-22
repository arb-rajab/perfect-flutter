import 'package:beta/application/services/database_service.dart';
import 'package:flutter/material.dart';

class QuestionMediasScreen extends StatelessWidget {
  static const String route = '/question-medias';
  const QuestionMediasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class QuestionMediasScreenArgument {
  final List<QuestionMedia> questionMedias;

  QuestionMediasScreenArgument({required this.questionMedias});
}
