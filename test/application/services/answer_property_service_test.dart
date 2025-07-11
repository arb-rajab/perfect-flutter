import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:drift/drift.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';

void main() {
  setUp(() async {
    await initTests();
  });

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

  test('addAnswerPropertiesFromJson test', () async {
    AnswerPropertyService answerPropertyService = Get.find();
    await answerPropertyService.addAnswerPropertiesFromJson([
      {'answerId': 1, 'name': 'random name', 'value': 'random value'}
    ]);
    List items = await (databaseService.select(databaseService.answerProperties)
          ..where((tbl) => Expression.and([
                tbl.answerId.equals(1),
                tbl.name.equals('random name'),
                tbl.value.equals('random value'),
              ])))
        .get();
    expect(items.length, 1);
  });

  test('getAllAnswerProperties test', () async {
    AnswerPropertyService answerPropertyService = Get.find();
    AnswerProperty answerProperty =
        const AnswerProperty(answerId: 1, name: 'name', value: 'value');
    await databaseService
        .into(databaseService.answerProperties)
        .insert(answerProperty);
    List items = await answerPropertyService.getAllAnswerProperties();
    expect(items, [answerProperty]);
  });

  test('getAnswerProperties test', () async {
    AnswerPropertyService answerPropertyService = Get.find();
    AnswerProperty answerProperty1 =
        const AnswerProperty(answerId: 1, name: 'name', value: 'value');
    AnswerProperty answerProperty2 =
        const AnswerProperty(answerId: 2, name: 'name', value: 'value');
    await databaseService
        .into(databaseService.answerProperties)
        .insert(answerProperty1);
    await databaseService
        .into(databaseService.answerProperties)
        .insert(answerProperty2);
    List items = await answerPropertyService.getAnswerProperties(1);
    expect(items, [answerProperty1]);
  });

  test('checkAnswer test', () async {
    AnswerPropertyService answerPropertyService = Get.find();
    AnswerProperty answerProperty =
        const AnswerProperty(answerId: 1, name: 'checked', value: 'true');
    AnswerProperty answerProperty2 =
        const AnswerProperty(answerId: 1, name: 'name', value: 'value');

    await answerPropertyService
        .addAnswerPropertiesFromJson([answerProperty2.toJson()]);

    await answerPropertyService.checkAnswer(1);
    List items = await answerPropertyService.getAnswerProperties(1);

    expect(items, [
      answerProperty2,
      answerProperty,
    ]);
  });

  test('checkAnswer override false values', () async {
    AnswerPropertyService answerPropertyService = Get.find();
    AnswerProperty answerProperty =
        const AnswerProperty(answerId: 1, name: 'checked', value: 'true');

    AnswerProperty answerProperty2 =
        const AnswerProperty(answerId: 1, name: 'name', value: 'value');

    await answerPropertyService.addAnswerPropertiesFromJson([
      answerProperty2.toJson(),
      answerProperty.copyWith(value: 'false').toJson()
    ]);

    await answerPropertyService.checkAnswer(1);

    List items = await answerPropertyService.getAnswerProperties(1);

    expect(items, [answerProperty2, answerProperty]);
  });

  test('uncheckAnswer tests', () async {
    AnswerPropertyService answerPropertyService = Get.find();
    AnswerProperty answerProperty =
        const AnswerProperty(answerId: 1, name: 'checked', value: 'true');
    AnswerProperty answerProperty2 =
        const AnswerProperty(answerId: 1, name: 'name', value: 'value');

    await answerPropertyService.addAnswerPropertiesFromJson(
        [answerProperty.toJson(), answerProperty2.toJson()]);
    await answerPropertyService.uncheckAnswer(1);

    List items = await answerPropertyService.getAnswerProperties(1);

    expect(items, [answerProperty2]);
  });
}
