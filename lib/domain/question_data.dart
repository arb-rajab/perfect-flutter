import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_property_service.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/domain/answer_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:drift/drift.dart';
import 'package:get/instance_manager.dart';

class QuestionData {
  String parentTermName;
  int numberOfMedias;
  bool hasNote;
  int indexInTerm;

  Question question;
  late List<AnswerData> answers;
  late List<QuestionProperty> questionProperties;
  late List<QuestionTag> questionTags;

  final AnswerService _answerService = Get.find();
  final QuestionPropertyService _questionPropertyService = Get.find();
  final QuestionTagService _questionTagService = Get.find();

  bool corrected = false;
  bool translated = false;
  bool imageVisible = false;
  bool translatable = false;
  bool _isInitiallyChecked = false;

  QuestionData(this.question,
      {required this.parentTermName,
      required this.numberOfMedias,
      required this.hasNote,
      required this.indexInTerm});

  Future getData() async {
    if (question.titleTranslation.isNotEmpty) translatable = true;
    if (question.noteTranslation.isNotEmpty) translatable = true;
    await _configureAnswers();
    await _configureQuestionProperty();
    await _configureQuestionTags();
    _configureInitiallyChecked();
  }

  _configureQuestionTags() async =>
      questionTags = await _questionTagService.getQuestionTags(Id(question.id));

  _configureQuestionProperty() async => questionProperties =
      await _questionPropertyService.getQuestionProperties(Id(question.id));

  _configureAnswers() async {
    answers = (await _answerService.getQuestionAnswers(Id(question.id)))
        .map((element) => AnswerData(element))
        .toList();
    for (AnswerData answerData in answers) {
      if (answerData.answer.titleTranslation.isNotEmpty) {
        translatable = true;
        break;
      }
    }
  }

  static QuestionData fromMap(QueryRow row) {
    DatabaseService databaseService = Get.find();
    return QuestionData(databaseService.questions.map(row.data),
        parentTermName: row.read<String>('parentTermName'),
        numberOfMedias: row.read<int>('numberOfMedias'),
        hasNote: row.read<int>('hasNote') == 1,
        indexInTerm: row.read<int>('indexInTerm'));
  }

  bool isFavorite() {
    for (QuestionProperty questionProperty in questionProperties) {
      if (questionProperty.name == 'favorite') {
        return questionProperty.value == 'true';
      }
    }
    return false;
  }

  Future setFavorite(bool value) async {
    if (value) {
      await _questionPropertyService.addQuestionToFavorite(question.id);
    } else {
      await _questionPropertyService.removeQuestionFromFavorite(question.id);
    }
    return _questionPropertyService
        .getQuestionProperties(Id(question.id))
        .then((value) => questionProperties = value);
  }

  bool hasUserNote() {
    for (QuestionProperty questionProperty in questionProperties) {
      if (questionProperty.name == 'userNote') return true;
    }
    return false;
  }

  String getUserNote() {
    for (QuestionProperty questionProperty in questionProperties) {
      if (questionProperty.name == 'userNote') return questionProperty.value;
    }
    return '';
  }

  Future setUserNote(String value) async {
    if (value.isNotEmpty) {
      await _questionPropertyService.setUserNote(question.id, value);
    } else {
      await _questionPropertyService.deleteUserNote(question.id);
    }
    return _questionPropertyService
        .getQuestionProperties(Id(question.id))
        .then((value) => questionProperties = value);
  }

  Future deleteUserNote() =>
      _questionPropertyService.deleteUserNote(question.id);

  String getTranslatableTitle() {
    if (translated && question.titleTranslation.isNotEmpty) {
      return question.titleTranslation;
    }
    return question.title;
  }

  String getTranslatableNote() {
    if (translated && question.noteTranslation.isNotEmpty) {
      return question.noteTranslation;
    }
    return question.note;
  }

  String getMultiOrientationString(String source) {
    String ltr = '<div style="direction:ltr;display:inline-block">';
    source = source.replaceAll('\$\$', '$ltr\$\$');
    int startingIndex = 0;
    while (source.indexOf('$ltr\$\$', startingIndex) != -1) {
      int index = source.indexOf('$ltr\$\$', startingIndex);
      int trailingIndex = source.indexOf('$ltr\$\$', index + 1);
      if (trailingIndex == -1) break;
      source =
          '${source.substring(0, trailingIndex)}\$\$${source.substring(trailingIndex)}';
      source = source.replaceAll('\$\$$ltr\$\$', '\$\$</div>');
      startingIndex = trailingIndex;
    }

    source = source.replaceAll('%%%%', '$ltr%%%%');
    startingIndex = 0;
    while (source.indexOf('$ltr%%%%', startingIndex) != -1) {
      int index = source.indexOf('$ltr%%%%', startingIndex);
      int trailingIndex = source.indexOf('$ltr%%%%', index + 1);
      if (trailingIndex == -1) break;
      source =
          '${source.substring(0, trailingIndex)}%%%%${source.substring(trailingIndex)}';
      source = source.replaceAll('%%%%$ltr%%%%', '</div>');
      startingIndex = trailingIndex;
    }
    source = source.replaceAll('%%%%', '');
    return source;
  }

  bool get isInitiallyChecked => _isInitiallyChecked;

  void _configureInitiallyChecked() {
    for (AnswerData answerData in answers) {
      if (answerData.isChecked()) _isInitiallyChecked = true;
    }
    _isInitiallyChecked = false;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionData && other.question == question);

  @override
  int get hashCode => Object.hash(question, answers);
}
