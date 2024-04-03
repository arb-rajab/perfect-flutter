import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_property_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:test/test.dart';

void main() {
  late DatabaseService databaseService;
  MainController.testing = true;

  setUp(() => databaseService = DatabaseService());
  tearDown(() => databaseService.close());

  group('deleteAllUserCheckedAnswers related tests', () {
    test('deleteAllUserNotes deletes userNote question properties', () async {
      databaseService.into(databaseService.questionProperties).insert(
          const QuestionPropertiesCompanion(
              questionId: Value(1),
              name: Value('userNote'),
              value: Value('random string')));
      var allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 1);

      QuestionPropertyService questionPropertyService =
          QuestionPropertyService(databaseService: databaseService);
      await questionPropertyService.deleteAllUserNotes();
      allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 0);
    });

    test(
        'deleteAllUserCheckedAnswers does not delete other than userNote question properties',
        () async {
      databaseService.into(databaseService.questionProperties).insert(
          const QuestionPropertiesCompanion(
              questionId: Value(1),
              name: Value('random string'),
              value: Value('random value')));
      var allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 1);

      QuestionPropertyService questionPropertyService =
          QuestionPropertyService(databaseService: databaseService);
      await questionPropertyService.deleteAllUserNotes();
      allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 1);
    });
  });

  group('deleteAllUserFavoriteQuestions related tests', () {
    test('deleteAllUserNotes deletes favorite question properties', () async {
      databaseService.into(databaseService.questionProperties).insert(
          const QuestionPropertiesCompanion(
              questionId: Value(1),
              name: Value('favorite'),
              value: Value('true')));
      var allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 1);

      QuestionPropertyService questionPropertyService =
          QuestionPropertyService(databaseService: databaseService);
      await questionPropertyService.deleteAllUserFavoriteQuestions();
      allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 0);
    });

    test(
        'deleteAllUserCheckedAnswers does not delete other than favorite question properties',
        () async {
      databaseService.into(databaseService.questionProperties).insert(
          const QuestionPropertiesCompanion(
              questionId: Value(1),
              name: Value('random string'),
              value: Value('random value')));
      var allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 1);

      QuestionPropertyService questionPropertyService =
          QuestionPropertyService(databaseService: databaseService);
      await questionPropertyService.deleteAllUserFavoriteQuestions();
      allItems = await databaseService.questionProperties.all().get();
      expect(allItems.length, 1);
    });
  });
}
