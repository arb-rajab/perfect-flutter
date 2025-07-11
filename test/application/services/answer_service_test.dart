import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/value/id.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';

void main() {
  setUp(() async {
    await initTests();
  });

  // Helper function to create a complete Answer instance
  Answer createTestAnswer({
    int id = 1,
    String uuid = 'test-uuid',
    String title = 'Test Answer',
    String titleTranslation = 'Test Answer Translation',
    int isCorrect = 1,
    int parentQuestionId = 1,
    int specialCharacter = 0,
    String creation = '2023-01-01',
    int checkedCount = 0,
  }) {
    return Answer(
      id: id,
      uuid: uuid,
      title: title,
      titleTranslation: titleTranslation,
      isCorrect: isCorrect,
      parentQuestionId: parentQuestionId,
      specialCharacter: specialCharacter,
      creation: creation,
      checkedCount: checkedCount,
    );
  }

  test('addAnswers inserts all answers with conflict resolution', () async {
    final answerService = AnswerService(databaseService: databaseService);
    final answers = [
      createTestAnswer(id: 1, parentQuestionId: 1),
      createTestAnswer(id: 2, parentQuestionId: 1),
    ];

    await answerService.addAnswers(answers);

    final storedAnswers =
        await databaseService.select(databaseService.answers).get();
    expect(storedAnswers.length, 2);
    expect(storedAnswers.map((a) => a.id), containsAll([1, 2]));
  });

  test('addAnswers updates existing answers on conflict', () async {
    final answerService = AnswerService(databaseService: databaseService);
    final initialAnswer = createTestAnswer(
      id: 1,
      title: 'Initial Title',
      isCorrect: 0,
    );

    // Insert initial answer
    await databaseService.into(databaseService.answers).insert(initialAnswer);

    // Update the answer
    final updatedAnswer = createTestAnswer(
      id: 1,
      title: 'Updated Title',
      isCorrect: 1,
    );

    await answerService.addAnswers([updatedAnswer]);

    final storedAnswers =
        await databaseService.select(databaseService.answers).get();
    expect(storedAnswers.length, 1);
    expect(storedAnswers.first.title, 'Updated Title');
    expect(storedAnswers.first.isCorrect, 1);
  });

  test('getQuestionAnswers returns only answers for specified question',
      () async {
    final answerService = AnswerService(databaseService: databaseService);
    const question1Id = Id(1);
    const question2Id = Id(2);

    // Insert test data
    await databaseService
        .into(databaseService.answers)
        .insert(createTestAnswer(id: 1, parentQuestionId: question1Id.value!));
    await databaseService
        .into(databaseService.answers)
        .insert(createTestAnswer(id: 2, parentQuestionId: question1Id.value!));
    await databaseService
        .into(databaseService.answers)
        .insert(createTestAnswer(id: 3, parentQuestionId: question2Id.value!));

    // Get answers for question 1
    final question1Answers =
        await answerService.getQuestionAnswers(question1Id);
    expect(question1Answers.length, 2);
    expect(question1Answers.map((a) => a.id), containsAll([1, 2]));

    // Get answers for question 2
    final question2Answers =
        await answerService.getQuestionAnswers(question2Id);
    expect(question2Answers.length, 1);
    expect(question2Answers.first.id, 3);
  });

  test('getQuestionAnswers returns empty list when no answers exist', () async {
    final answerService = AnswerService(databaseService: databaseService);
    const questionId = Id(999); // Non-existent question ID

    final answers = await answerService.getQuestionAnswers(questionId);
    expect(answers, isEmpty);
  });

  test('addAnswers preserves all answer fields', () async {
    final answerService = AnswerService(databaseService: databaseService);
    final answer = createTestAnswer(
      id: 1,
      uuid: 'unique-uuid',
      title: 'Complete Answer',
      titleTranslation: 'Complete Answer Translation',
      isCorrect: 1,
      parentQuestionId: 1,
      specialCharacter: 1,
      creation: '2023-01-01T00:00:00Z',
      checkedCount: 5,
    );

    await answerService.addAnswers([answer]);

    final storedAnswers =
        await databaseService.select(databaseService.answers).get();
    expect(storedAnswers.length, 1);

    final storedAnswer = storedAnswers.first;
    expect(storedAnswer.id, 1);
    expect(storedAnswer.uuid, 'unique-uuid');
    expect(storedAnswer.title, 'Complete Answer');
    expect(storedAnswer.titleTranslation, 'Complete Answer Translation');
    expect(storedAnswer.isCorrect, 1);
    expect(storedAnswer.parentQuestionId, 1);
    expect(storedAnswer.specialCharacter, 1);
    expect(storedAnswer.creation, '2023-01-01T00:00:00Z');
    expect(storedAnswer.checkedCount, 5);
  });
}
