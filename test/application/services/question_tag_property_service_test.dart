import 'package:get/instance_manager.dart';
import 'package:test/test.dart';
import 'package:beta/application/services/question_tag_property_service.dart';
import 'package:beta/domain/value/id.dart';

import '../../common/tests.dart';

void main() {
  late QuestionTagPropertyService service;

  setUp(() async {
    await initTests();
    service = Get.find();
  });

  group('QuestionTagPropertyService', () {
    test('addQuestionTagProperty and getAllQuestionTagProperties', () async {
      const id = Id(1);
      await service.addQuestionTagProperty(id, 'difficulty', 'hard');
      final all = await service.getAllQuestionTagProperties();
      expect(all.length, 1);
      expect(all.first.questionTagId, 1);
      expect(all.first.name, 'difficulty');
      expect(all.first.value, 'hard');
    });

    test('getQuestionTagProperty returns correct property', () async {
      const id = Id(2);
      await service.addQuestionTagProperty(id, 'topic', 'math');
      final prop = await service.getQuestionTagProperty(2, 'topic');
      expect(prop, isNotNull);
      expect(prop!.questionTagId, 2);
      expect(prop.name, 'topic');
      expect(prop.value, 'math');
    });

    test('getQuestionTagProperty returns null if not found', () async {
      final prop = await service.getQuestionTagProperty(999, 'nonexistent');
      expect(prop, isNull);
    });

    test('addQuestionTagPropertiesFromJson inserts multiple properties',
        () async {
      final json = [
        {'questionTagId': 10, 'name': 'type', 'value': 'multiple'},
        {'questionTagId': 11, 'name': 'type', 'value': 'single'},
      ];
      await service.addQuestionTagPropertiesFromJson(json);
      final all = await service.getAllQuestionTagProperties();
      expect(all.length, 2);
      expect(all.any((e) => e.questionTagId == 10 && e.value == 'multiple'),
          isTrue);
      expect(
          all.any((e) => e.questionTagId == 11 && e.value == 'single'), isTrue);
    });

    test('addQuestionTagPropertiesFromJson upsert properties', () async {
      final json = [
        {'questionTagId': 10, 'name': 'type', 'value': 'multiple'},
        {'questionTagId': 11, 'name': 'type', 'value': 'single'},
      ];
      await service.addQuestionTagPropertiesFromJson(json);
      await service.addQuestionTagPropertiesFromJson([
        {'questionTagId': 10, 'name': 'type', 'value': 'multiple2'}
      ]);
      final neww = await service.getQuestionTagProperty(10, 'type');
      expect(neww, isNotNull);
      expect(neww!.value, 'multiple2');
    });

    test('addQuestionTagProperty upserts (on conflict update)', () async {
      const id = Id(3);
      await service.addQuestionTagProperty(id, 'lang', 'en');
      await service.addQuestionTagProperty(id, 'lang', 'tr');
      final prop = await service.getQuestionTagProperty(3, 'lang');
      expect(prop, isNotNull);
      expect(prop!.value, 'tr');
    });
  });
}
