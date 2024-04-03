import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:test/test.dart';

void main() {
  late DatabaseService databaseService;
  MainController.testing = true;

  setUp(() => databaseService = DatabaseService());
  tearDown(() => databaseService.close());

  group('deleteAllTermLastAccess related tests', () {
    test('deleteAllTermLastAccess deletes all items', () async {
      databaseService
          .into(databaseService.termsLastAccesses)
          .insert(const TermsLastAccessesCompanion(
            parentTermId: Value(1),
            childId: Value(2),
          ));
      var allItems = await databaseService.termsLastAccesses.all().get();
      expect(allItems.length, 1);

      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);
      await termLastAccessService.deleteAllTermLastAccess();
      allItems = await databaseService.termsLastAccesses.all().get();
      expect(allItems.length, 0);
    });

    test(
        'deleteAllTermLastAccess deletes question tag properties last access property',
        () async {
      databaseService.into(databaseService.questionTagProperties).insert(
          const QuestionTagPropertiesCompanion(
              questionTagId: Value(1),
              name: Value('lastAccess'),
              value: Value('random value')));
      var allItems = await databaseService.questionTagProperties.all().get();
      expect(allItems.length, 1);

      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);
      await termLastAccessService.deleteAllTermLastAccess();
      allItems = await databaseService.questionTagProperties.all().get();
      expect(allItems.length, 0);
    });

    test(
        'deleteAllTermLastAccess does not delete question tag properties other than last access property',
        () async {
      databaseService.into(databaseService.questionTagProperties).insert(
          const QuestionTagPropertiesCompanion(
              questionTagId: Value(1),
              name: Value('random name'),
              value: Value('random value')));
      var allItems = await databaseService.questionTagProperties.all().get();
      expect(allItems.length, 1);

      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);
      await termLastAccessService.deleteAllTermLastAccess();
      allItems = await databaseService.questionTagProperties.all().get();
      expect(allItems.length, 1);
    });
  });
}
