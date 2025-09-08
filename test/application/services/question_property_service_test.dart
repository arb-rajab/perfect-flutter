import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_property_service.dart';
import 'package:beta/domain/value/id.dart';
import 'package:drift/drift.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';

void main() {
  late QuestionPropertyService questionPropertyService;

  setUp(() async {
    await initTests();
    questionPropertyService = Get.find();
  });

  group('deleteAllUserNotes', () {
    test('deletes userNote question properties', () async {
      await databaseService.into(databaseService.questionProperties).insert(
            const QuestionPropertiesCompanion(
              questionId: Value(1),
              name: Value('userNote'),
              value: Value('random string'),
            ),
          );
      var allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 1);

      await questionPropertyService.deleteAllUserNotes();
      allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 0);
    });

    test('does not delete non-userNote question properties', () async {
      await databaseService.into(databaseService.questionProperties).insert(
            const QuestionPropertiesCompanion(
              questionId: Value(1),
              name: Value('other'),
              value: Value('random value'),
            ),
          );
      var allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 1);

      await questionPropertyService.deleteAllUserNotes();
      allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 1);
    });
  });

  group('deleteAllUserFavoriteQuestions', () {
    test('deletes favorite question properties', () async {
      await databaseService.into(databaseService.questionProperties).insert(
            const QuestionPropertiesCompanion(
              questionId: Value(1),
              name: Value('favorite'),
              value: Value('true'),
            ),
          );
      var allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 1);

      await questionPropertyService.deleteAllUserFavoriteQuestions();
      allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 0);
    });

    test('does not delete non-favorite question properties', () async {
      await databaseService.into(databaseService.questionProperties).insert(
            const QuestionPropertiesCompanion(
              questionId: Value(1),
              name: Value('other'),
              value: Value('random value'),
            ),
          );
      var allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 1);

      await questionPropertyService.deleteAllUserFavoriteQuestions();
      allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 1);
    });
  });

  group('addQuestionPropertiesFromJson', () {
    test('inserts multiple question properties from JSON', () async {
      final jsonList = [
        {'questionId': 1, 'name': 'favorite', 'value': 'true'},
        {'questionId': 2, 'name': 'userNote', 'value': 'note'},
      ];
      await questionPropertyService.addQuestionPropertiesFromJson(jsonList);

      final all = await databaseService.questionProperties.all().get();
      expect(all.length, 2);
      expect(all.any((e) => e.questionId == 1 && e.name == 'favorite'), isTrue);
      expect(all.any((e) => e.questionId == 2 && e.name == 'userNote'), isTrue);
    });
  });

  group('getAllQuestionProperties', () {
    test('returns all question properties', () async {
      await databaseService.into(databaseService.questionProperties).insert(
            const QuestionPropertiesCompanion(
              questionId: Value(1),
              name: Value('favorite'),
              value: Value('true'),
            ),
          );
      await databaseService.into(databaseService.questionProperties).insert(
            const QuestionPropertiesCompanion(
              questionId: Value(2),
              name: Value('userNote'),
              value: Value('note'),
            ),
          );
      final all = await questionPropertyService.getAllQuestionProperties();
      expect(all.length, 2);
    });
  });

  group('getQuestionProperties', () {
    test('returns properties for a specific question', () async {
      await databaseService.into(databaseService.questionProperties).insert(
            const QuestionPropertiesCompanion(
              questionId: Value(1),
              name: Value('favorite'),
              value: Value('true'),
            ),
          );
      await databaseService.into(databaseService.questionProperties).insert(
            const QuestionPropertiesCompanion(
              questionId: Value(2),
              name: Value('userNote'),
              value: Value('note'),
            ),
          );
      final props =
          await questionPropertyService.getQuestionProperties(const Id(1));
      expect(props.length, 1);
      expect(props.first.name, 'favorite');
    });
  });

  group('addQuestionToFavorite', () {
    test('adds a favorite property for a question', () async {
      await questionPropertyService.addQuestionToFavorite(3);
      final all = await databaseService.questionProperties.all().get();
      expect(all.length, 1);
      expect(all.first.questionId, 3);
      expect(all.first.name, 'favorite');
      expect(all.first.value, 'true');
    });
  });

  group('removeQuestionFromFavorite', () {
    test('removes favorite property for a question', () async {
      await questionPropertyService.addQuestionToFavorite(4);
      var all = await databaseService.questionProperties.all().get();
      expect(all.length, 1);

      await questionPropertyService.removeQuestionFromFavorite(4);
      all = await databaseService.questionProperties.all().get();
      expect(all.length, 0);
    });
  });

  group('setUserNote', () {
    test('sets a user note for a question', () async {
      await questionPropertyService.setUserNote(5, 'my note');
      final all = await databaseService.questionProperties.all().get();
      expect(all.length, 1);
      expect(all.first.questionId, 5);
      expect(all.first.name, 'userNote');
      expect(all.first.value, 'my note');
    });

    test('overwrites previous user note for a question', () async {
      await questionPropertyService.setUserNote(6, 'first note');
      await questionPropertyService.setUserNote(6, 'second note');
      final all = await databaseService.questionProperties.all().get();
      expect(all.length, 1);
      expect(all.first.value, 'second note');
    });
  });

  group('deleteUserNote', () {
    test('deletes user note for a question', () async {
      await questionPropertyService.setUserNote(7, 'note to delete');
      var all = await databaseService.questionProperties.all().get();
      expect(all.length, 1);

      await questionPropertyService.deleteUserNote(7);
      all = await databaseService.questionProperties.all().get();
      expect(all.length, 0);
    });
  });
}
