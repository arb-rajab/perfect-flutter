import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:test/test.dart';

void main() {
  late DatabaseService databaseService;
  MainController.testing = true;

  setUp(() => databaseService = DatabaseService());
  tearDown(() => databaseService.close());

  test('deleteAllUserCheckedAnswers deletes checked answer properties',
      () async {
    databaseService.into(databaseService.answerProperties).insert(
        const AnswerPropertiesCompanion(
            answerId: Value(1), name: Value('checked'), value: Value('true')));
    var allItems = await databaseService.answerProperties.all().get();
    expect(allItems.length, 1);

    AnswerPropertyService answerPropertyService =
        AnswerPropertyService(databaseService: databaseService);
    await answerPropertyService.deleteAllUserCheckedAnswers();
    allItems = await databaseService.answerProperties.all().get();
    expect(allItems.length, 0);
  });

  test(
      'deleteAllUserCheckedAnswers does not delete other than checked answer properties',
      () async {
    databaseService.into(databaseService.answerProperties).insert(
        const AnswerPropertiesCompanion(
            answerId: Value(1),
            name: Value('random string'),
            value: Value('random value')));
    var allItems = await databaseService.answerProperties.all().get();
    expect(allItems.length, 1);

    AnswerPropertyService answerPropertyService =
        AnswerPropertyService(databaseService: databaseService);
    await answerPropertyService.deleteAllUserCheckedAnswers();
    allItems = await databaseService.answerProperties.all().get();
    expect(allItems.length, 1);
  });
}
