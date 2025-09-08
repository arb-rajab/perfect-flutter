import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() {
  late QuestionTagService service;

  setUp(() async {
    await initTests();
    service = Get.find();
  });

  group('addQuestionTags tests', () {
    test('addQuestionTags correctly adds tags to the database', () async {
      final tags = [
        const QuestionTag(
          id: 1,
          name: 'tag1',
          parentTagId: 0,
          hasInformation: 0,
          creation: '2022-01-01 11:11:11',
        ),
        const QuestionTag(
          id: 2,
          name: 'tag2',
          parentTagId: 0,
          hasInformation: 0,
          creation: '2022-01-01 11:11:11',
        ),
      ];

      await service.addQuestionTags(tags);

      // Query all tags from the database
      final allTags =
          await databaseService.select(databaseService.questionTags).get();

      // Assert that the added tags are present
      expect(allTags, isA<List<QuestionTag>>());
      expect(allTags.length, 2);
      expect(allTags.any((tag) => tag.id == 1 && tag.name == 'tag1'), isTrue);
      expect(allTags.any((tag) => tag.id == 2 && tag.name == 'tag2'), isTrue);
    });

    test('addQuestionTags overrides duplicated tags with new data', () async {
      // Insert initial tag
      const initialTag = QuestionTag(
        id: 3,
        name: 'original',
        parentTagId: 0,
        hasInformation: 0,
        creation: '2022-01-01 11:11:11',
      );
      await service.addQuestionTags([initialTag]);

      // Insert tag with same id but different data
      const updatedTag = QuestionTag(
        id: 3,
        name: 'updated',
        parentTagId: 1,
        hasInformation: 1,
        creation: '2023-02-02 22:22:22',
      );
      await service.addQuestionTags([updatedTag]);

      // Query tag from the database
      final allTags =
          await databaseService.select(databaseService.questionTags).get();
      final tag = allTags.firstWhere((t) => t.id == 3);

      // Assert that the tag data is updated
      expect(tag.name, 'updated');
      expect(tag.parentTagId, 1);
      expect(tag.hasInformation, 1);
      expect(tag.creation, '2023-02-02 22:22:22');
    });
  });

  group('getTermQuestionsTags tests', () {
    test('getTermQuestionsTags returns tags for a single term with tags',
        () async {
      // Insert a term
      const term = Term(
        id: 10,
        name: 'Test Term',
        type: 0,
        creation: '2022-01-01 00:00:00',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
        uuid: '',
      );
      await databaseService.into(databaseService.terms).insert(term);
      await databaseService
          .into(databaseService.termTrees)
          .insert(TermTree(termId: term.id, parentTermId: term.id, depth: 1));

      // Insert question tags
      const tag1 = QuestionTag(
        id: 100,
        name: 'Tag 1',
        parentTagId: 0,
        hasInformation: 0,
        creation: '2022-01-01 00:00:00',
      );
      await service.addQuestionTags([tag1]);

      // Link tag to the term's question
      // For this, we need to insert a question and link it
      const questionId = 200;
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: questionId,
              parentTermId: term.id,
              uuid: 'test-uuid-$questionId',
              title: 'Test Question $questionId',
              labelId: 0,
              note: 'Test note',
              specialCharacter: 0,
              type: 0,
              creation: '2022-01-01 00:00:00',
              editionDate: '2022-01-01 00:00:00',
              titleTranslation: '',
              noteTranslation: '',
              edited: 0,
              imageUrl: '',
            ),
          );
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTagsCompanion.insert(
              questionId: questionId,
              tagId: tag1.id,
            ),
          );

      final termData = TermData(term, deletedAt: null, visible: null);

      // Act
      final tags = await service.getTermQuestionsTags(termData);

      // Assert
      expect(tags, isA<List<QuestionTagData>>());
      expect(tags.length, greaterThanOrEqualTo(1));
      expect(tags.any((t) => t.questionTag.id == tag1.id), isTrue);
    });

    test(
        'getTermQuestionsTags returns only tags for the relevant term when multiple terms exist',
        () async {
      // Insert two terms
      const term1 = Term(
        id: 20,
        name: 'Term 1',
        type: 0,
        creation: '2022-01-01 00:00:00',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
        uuid: '',
      );
      const term2 = Term(
        id: 21,
        name: 'Term 2',
        type: 0,
        creation: '2022-01-01 00:00:00',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
        uuid: '',
      );
      await databaseService.into(databaseService.terms).insert(term1);
      await databaseService.into(databaseService.terms).insert(term2);
      await databaseService
          .into(databaseService.termTrees)
          .insert(TermTree(termId: term1.id, parentTermId: term1.id, depth: 1));
      await databaseService
          .into(databaseService.termTrees)
          .insert(TermTree(termId: term2.id, parentTermId: term2.id, depth: 1));

      // Insert tags
      const tagA = QuestionTag(
        id: 101,
        name: 'Tag A',
        parentTagId: 0,
        hasInformation: 0,
        creation: '2022-01-01 00:00:00',
      );
      const tagB = QuestionTag(
        id: 102,
        name: 'Tag B',
        parentTagId: 0,
        hasInformation: 0,
        creation: '2022-01-01 00:00:00',
      );
      await service.addQuestionTags([tagA, tagB]);

      // Insert questions for each term
      const questionId1 = 201;
      const questionId2 = 202;
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: questionId1,
              parentTermId: term1.id,
              uuid: 'test-uuid-$questionId1',
              title: 'Test Question $questionId1',
              labelId: 0,
              note: 'Test note',
              specialCharacter: 0,
              type: 0,
              creation: '2022-01-01 00:00:00',
              editionDate: '2022-01-01 00:00:00',
              titleTranslation: '',
              noteTranslation: '',
              edited: 1,
              imageUrl: '',
            ),
          );
      await databaseService.into(databaseService.questions).insert(
            QuestionsCompanion.insert(
              id: const Value(questionId2),
              parentTermId: term2.id,
              uuid: 'test-uuid-$questionId2',
              title: 'Test Question $questionId2',
              labelId: 0,
              note: 'Test note',
              specialCharacter: 0,
              type: 0,
              creation: '2022-01-01 00:00:00',
              editionDate: '2022-01-01 00:00:00',
            ),
          );

      // Link tags to questions
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTagsCompanion.insert(
              questionId: questionId1,
              tagId: tagA.id,
            ),
          );
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTagsCompanion.insert(
              questionId: questionId2,
              tagId: tagB.id,
            ),
          );

      final termData1 = TermData(term1, deletedAt: null, visible: null);
      final termData2 = TermData(term2, deletedAt: null, visible: null);

      // Act & Assert for term1
      final tags1 = await service.getTermQuestionsTags(termData1);
      expect(tags1, isA<List<QuestionTagData>>());
      expect(tags1.length, 1);
      expect(tags1.first.questionTag.id, tagA.id);

      // Act & Assert for term2
      final tags2 = await service.getTermQuestionsTags(termData2);
      expect(tags2, isA<List<QuestionTagData>>());
      expect(tags2.length, 1);
      expect(tags2.first.questionTag.id, tagB.id);
    });
  });

  test('getNumberOfAllQuestionsQuestionTag returns correct count', () async {
    // Arrange
    final questionTagData = QuestionTagData(
      const QuestionTag(
        id: 1,
        name: 'tag1',
        parentTagId: 0,
        hasInformation: 0,
        creation: '2022-01-01 11:11:11',
      ),
      numberOfChildTags: null,
      numberOfOccurrences: null,
    );
    final termData = TermData(
      const Term(
        id: 1,
        name: 'term',
        type: 0,
        creation: '',
        enabled: 1,
        free: 1,
        ordering: 0,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
        uuid: '',
      ),
      deletedAt: null,
      visible: null,
    );
    await databaseService.into(databaseService.termTrees).insert(TermTree(
        termId: termData.term.id, parentTermId: termData.term.id, depth: 0));

    // Insert 42 questions and link them to the tag
    for (int i = 0; i < 42; i++) {
      final questionId = 1000 + i;
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: questionId,
              parentTermId: termData.term.id,
              uuid: 'test-uuid-$questionId',
              title: 'Test Question $questionId',
              labelId: 0,
              note: 'Test note',
              specialCharacter: 0,
              type: 0,
              creation: '2022-01-01 00:00:00',
              editionDate: '2022-01-01 00:00:00',
              titleTranslation: '',
              noteTranslation: '',
              edited: 0,
              imageUrl: '',
            ),
          );
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTagsCompanion.insert(
              questionId: questionId,
              tagId: questionTagData.questionTag.id,
            ),
          );
    }

    // Act
    final result = await service.getNumberOfAllQuestionsQuestionTag(
      questionTagData,
      termData,
    );

    // Assert
    expect(result, 42);
  });

  test('getAllQuestionsTagChild returns list of child QuestionTagData',
      () async {
    // Arrange
    // Insert parent tag (id: 1)
    const parentTag = QuestionTag(
      id: 1,
      name: 'parent',
      parentTagId: 0,
      hasInformation: 0,
      creation: '2022-01-01 11:11:11',
    );
    // Insert child tag (id: 2, parentTagId: 1)
    const childTag = QuestionTag(
      id: 2,
      name: 'child',
      parentTagId: 1,
      hasInformation: 0,
      creation: '2022-01-01 11:11:11',
    );
    // Insert grand child tag (id: 3, parentTagId: 2)
    const grandChildTag = QuestionTag(
      id: 3,
      name: 'grand child',
      parentTagId: 2,
      hasInformation: 0,
      creation: '2022-01-01 11:11:11',
    );
    await service.addQuestionTags([parentTag, childTag, grandChildTag]);

    // Insert a term with id: 1 and enabled: 1 (required for the SQL to count occurrences)
    const term = Term(
      id: 1,
      name: 'Test Term',
      type: 0,
      creation: '2022-01-01 00:00:00',
      enabled: 1,
      free: 1,
      ordering: 0,
      needsUpdate: 0,
      captureable: 1,
      textCulumn: '',
      outerNote: '',
      uuid: '',
    );
    await databaseService.into(databaseService.terms).insert(term);

    // Insert 3 questions, each linked to childTag (id: 2)
    for (int i = 0; i < 3; i++) {
      final questionId = 100 + i;
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: questionId,
              parentTermId: 1,
              uuid: 'test-uuid-$questionId',
              title: 'Test Question $questionId',
              labelId: 0,
              note: 'Test note',
              specialCharacter: 0,
              type: 0,
              creation: '2022-01-01 00:00:00',
              editionDate: '2022-01-01 00:00:00',
              titleTranslation: '',
              noteTranslation: '',
              edited: 0,
              imageUrl: '',
            ),
          );
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTagsCompanion.insert(
              questionId: questionId,
              tagId: childTag.id,
            ),
          );
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTagsCompanion.insert(
              questionId: questionId,
              tagId: grandChildTag.id,
            ),
          );
    }

    final parentTagData = QuestionTagData(
      parentTag,
      numberOfChildTags: null,
      numberOfOccurrences: null,
    );

    // Act
    final result = await service.getAllQuestionsTagChild(parentTagData);

    // Assert
    expect(result, isA<List<QuestionTagData>>());
    expect(result.length, 1);
    expect(result.first.questionTag.id, 2);
    expect(result.first.numberOfChildTags?.value, 1);
    expect(result.first.numberOfOccurrences?.value, 3);
  });

  test('getAllQuestionsTagChild ignores other term data tags', () async {
    // Arrange
    // Insert parent tag (id: 10)
    const parentTag = QuestionTag(
      id: 10,
      name: 'parent',
      parentTagId: 0,
      hasInformation: 0,
      creation: '2022-01-01 11:11:11',
    );
    // Insert child tag (id: 11, parentTagId: 10)
    const childTag = QuestionTag(
      id: 11,
      name: 'child',
      parentTagId: 10,
      hasInformation: 0,
      creation: '2022-01-01 11:11:11',
    );
    // Insert unrelated tag (id: 99, parentTagId: 0)
    const otherTag = QuestionTag(
      id: 99,
      name: 'other',
      parentTagId: 0,
      hasInformation: 0,
      creation: '2022-01-01 11:11:11',
    );
    await service.addQuestionTags([parentTag, childTag, otherTag]);

    // Insert a term with id: 2 and enabled: 1
    const term = Term(
      id: 2,
      name: 'Test Term 2',
      type: 0,
      creation: '2022-01-01 00:00:00',
      enabled: 1,
      free: 1,
      ordering: 0,
      needsUpdate: 0,
      captureable: 1,
      textCulumn: '',
      outerNote: '',
      uuid: '',
    );
    await databaseService.into(databaseService.terms).insert(term);

    // Insert questions linked to childTag and otherTag
    // 2 questions for childTag
    for (int i = 0; i < 2; i++) {
      final questionId = 200 + i;
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: questionId,
              parentTermId: 2,
              uuid: 'test-uuid-$questionId',
              title: 'Test Question $questionId',
              labelId: 0,
              note: 'Test note',
              specialCharacter: 0,
              type: 0,
              creation: '2022-01-01 00:00:00',
              editionDate: '2022-01-01 00:00:00',
              titleTranslation: '',
              noteTranslation: '',
              edited: 0,
              imageUrl: '',
            ),
          );
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTagsCompanion.insert(
              questionId: questionId,
              tagId: childTag.id,
            ),
          );
    }
    // 3 questions for otherTag
    for (int i = 0; i < 3; i++) {
      final questionId = 300 + i;
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: questionId,
              parentTermId: 2,
              uuid: 'test-uuid-$questionId',
              title: 'Other Question $questionId',
              labelId: 0,
              note: 'Other note',
              specialCharacter: 0,
              type: 0,
              creation: '2022-01-01 00:00:00',
              editionDate: '2022-01-01 00:00:00',
              titleTranslation: '',
              noteTranslation: '',
              edited: 0,
              imageUrl: '',
            ),
          );
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTagsCompanion.insert(
              questionId: questionId,
              tagId: otherTag.id,
            ),
          );
    }

    final parentTagData = QuestionTagData(
      parentTag,
      numberOfChildTags: null,
      numberOfOccurrences: null,
    );

    // Act
    final result = await service.getAllQuestionsTagChild(parentTagData);

    // Assert
    expect(result, isA<List<QuestionTagData>>());
    // Only the childTag should be present
    expect(result.length, 1);
    expect(result.first.questionTag.id, childTag.id);
    // The number of occurrences should only count the childTag's questions
    expect(result.first.numberOfOccurrences?.value, 2);
    // The unrelated tag should not be present
    expect(result.any((t) => t.questionTag.id == otherTag.id), isFalse);
  });

  test('getNumberOfOtherQuestionsQuestionTag returns correct count', () async {
    // Arrange
    // Insert parent tag (id: 1)
    const parentTag = QuestionTag(
      id: 1,
      name: 'tag1',
      parentTagId: 0,
      hasInformation: 0,
      creation: '2022-01-01 11:11:11',
    );
    // Insert child tag (id: 2, parentTagId: 1)
    const childTag = QuestionTag(
      id: 2,
      name: 'child',
      parentTagId: 1,
      hasInformation: 0,
      creation: '2022-01-01 11:11:11',
    );
    await service.addQuestionTags([parentTag, childTag]);

    // Insert a term with id: 1 and enabled: 1
    const term = Term(
      id: 1,
      name: 'term',
      type: 0,
      creation: '',
      enabled: 1,
      free: 1,
      ordering: 0,
      needsUpdate: 0,
      captureable: 1,
      textCulumn: '',
      outerNote: '',
      uuid: '',
    );
    await databaseService.into(databaseService.terms).insert(term);

    // Insert questions:
    // - 5 questions linked only to parentTag (should be counted)
    // - 3 questions linked only to childTag (should NOT be counted)
    // - 2 questions linked to both parentTag and childTag (should NOT be counted)
    // Total expected: 5

    // 5 questions linked only to parentTag
    for (int i = 0; i < 5; i++) {
      final questionId = 1000 + i;
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: questionId,
              parentTermId: term.id,
              uuid: 'test-uuid-$questionId',
              title: 'ParentTag Question $questionId',
              labelId: 0,
              note: 'Test note',
              specialCharacter: 0,
              type: 0,
              creation: '2022-01-01 00:00:00',
              editionDate: '2022-01-01 00:00:00',
              titleTranslation: '',
              noteTranslation: '',
              edited: 0,
              imageUrl: '',
            ),
          );
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTagsCompanion.insert(
              questionId: questionId,
              tagId: parentTag.id,
            ),
          );
    }

    // 3 questions linked only to childTag
    for (int i = 0; i < 3; i++) {
      final questionId = 2000 + i;
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: questionId,
              parentTermId: term.id,
              uuid: 'test-uuid-$questionId',
              title: 'ChildTag Question $questionId',
              labelId: 0,
              note: 'Test note',
              specialCharacter: 0,
              type: 0,
              creation: '2022-01-01 00:00:00',
              editionDate: '2022-01-01 00:00:00',
              titleTranslation: '',
              noteTranslation: '',
              edited: 0,
              imageUrl: '',
            ),
          );
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTagsCompanion.insert(
              questionId: questionId,
              tagId: childTag.id,
            ),
          );
    }

    // 2 questions linked to both parentTag and childTag
    for (int i = 0; i < 2; i++) {
      final questionId = 3000 + i;
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: questionId,
              parentTermId: term.id,
              uuid: 'test-uuid-$questionId',
              title: 'BothTags Question $questionId',
              labelId: 0,
              note: 'Test note',
              specialCharacter: 0,
              type: 0,
              creation: '2022-01-01 00:00:00',
              editionDate: '2022-01-01 00:00:00',
              titleTranslation: '',
              noteTranslation: '',
              edited: 0,
              imageUrl: '',
            ),
          );
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTagsCompanion.insert(
              questionId: questionId,
              tagId: parentTag.id,
            ),
          );
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTagsCompanion.insert(
              questionId: questionId,
              tagId: childTag.id,
            ),
          );
    }

    final questionTagData = QuestionTagData(
      parentTag,
      numberOfChildTags: null,
      numberOfOccurrences: null,
    );
    final termData = TermData(
      term,
      deletedAt: null,
      visible: null,
    );
    await databaseService
        .into(databaseService.termTrees)
        .insert(TermTree(termId: term.id, parentTermId: term.id, depth: 0));

    // Act
    final result = await service.getNumberOfOtherQuestionsQuestionTag(
      questionTagData,
      termData,
    );

    // Assert
    expect(result, 5);
  });

  test('getQuestionTags returns correct tags for a given questionId', () async {
    const QuestionTag questionTag1 = QuestionTag(
        id: 1,
        name: 'related 1',
        parentTagId: 0,
        hasInformation: 0,
        creation: '2024-01-01 11:12:13');
    const QuestionTag questionTag2 = QuestionTag(
        id: 2,
        name: 'related 2',
        parentTagId: 0,
        hasInformation: 0,
        creation: '2024-01-01 11:12:13');
    const QuestionTag questionTag3 = QuestionTag(
        id: 3,
        name: 'not related',
        parentTagId: 0,
        hasInformation: 0,
        creation: '2024-01-01 11:12:13');

    await databaseService
        .into(databaseService.questionTags)
        .insert(questionTag1);
    await databaseService
        .into(databaseService.questionTags)
        .insert(questionTag2);
    await databaseService
        .into(databaseService.questionTags)
        .insert(questionTag3);

    await databaseService
        .into(databaseService.questionsLinkedToTags)
        .insert(const QuestionsLinkedToTag(questionId: 1, tagId: 1));
    await databaseService
        .into(databaseService.questionsLinkedToTags)
        .insert(const QuestionsLinkedToTag(questionId: 1, tagId: 2));

    // Act
    final result = await service.getQuestionTags(const Id(1));

    // Assert
    expect(result, isA<List<QuestionTag>>());
    expect(result.length, 2);
    expect(result[0].id, 1);
    expect(result[1].id, 2);
    expect(result[0].name, 'related 1');
    expect(result[1].name, 'related 2');
  });
}
