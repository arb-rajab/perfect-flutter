import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/presentation/questions/question_header.dart';

List<QuestionData> createTestQuestions() {
  return [
    QuestionData(
      const Question(
          id: 1,
          uuid: 'uuid',
          title: 'title',
          titleTranslation: 'titleTranslation',
          labelId: 1,
          note: 'note',
          noteTranslation: 'noteTranslation',
          parentTermId: 1,
          specialCharacter: SpecialCharacter.none,
          type: 1,
          edited: 0,
          imageUrl: '',
          creation: '2024-01-01 11:15:19',
          editionDate: ''),
      parentTermName: '',
      numberOfMedias: 0,
      hasNote: false,
      indexInTerm: 1,
    )
      ..questionTags = [
        const QuestionTag(
            id: 1,
            name: 'Parent Tag',
            parentTagId: 0,
            hasInformation: 0,
            creation: '2024-01-01 12:13:15'),
      ]
      ..answers = [],
    QuestionData(
      const Question(
          id: 2,
          uuid: 'uuid',
          title: 'title',
          titleTranslation: 'titleTranslation',
          labelId: 1,
          note: 'note',
          noteTranslation: 'noteTranslation',
          parentTermId: 1,
          specialCharacter: SpecialCharacter.none,
          type: 1,
          edited: 0,
          imageUrl: '',
          creation: '2024-01-01 11:15:19',
          editionDate: ''),
      parentTermName: '',
      numberOfMedias: 0,
      hasNote: false,
      indexInTerm: 1,
    )..questionTags = [
        const QuestionTag(
            id: 2,
            name: 'Child Tag',
            parentTagId: 1,
            hasInformation: 0,
            creation: '2024-01-01 12:13:15'),
      ]..answers=[],
    QuestionData(
      const Question(
          id: 3,
          uuid: 'uuid',
          title: 'title',
          titleTranslation: 'titleTranslation',
          labelId: 1,
          note: 'note',
          noteTranslation: 'noteTranslation',
          parentTermId: 1,
          specialCharacter: SpecialCharacter.none,
          type: 1,
          edited: 0,
          imageUrl: '',
          creation: '2024-01-01 11:15:19',
          editionDate: ''),
      parentTermName: '',
      numberOfMedias: 0,
      hasNote: false,
      indexInTerm: 1,
    )..questionTags = []..answers=[],
  ];
}

List<QuestionTag> createTestTags() {
  return [
    const QuestionTag(
        id: 1,
        name: 'Parent Tag',
        parentTagId: 0,
        hasInformation: 0,
        creation: '2024-01-01 12:13:15'),
    const QuestionTag(
        id: 2,
        name: 'Child Tag',
        parentTagId: 1,
        hasInformation: 0,
        creation: '2024-01-01 12:13:15'),
  ];
}
