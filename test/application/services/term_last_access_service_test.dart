import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:test/test.dart';
import 'package:get/instance_manager.dart';

void main() {
  late DatabaseService databaseService;
  MainController.testing = true;

  setUp(() async {
    await MainController.initServices();
    databaseService = Get.find();
  });
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

  group('isTermAccessed tests', () {
    test('isTermAccessed returns true when term has accessed children',
        () async {
      // Insert a termsLastAccess record for a parent term
      databaseService
          .into(databaseService.termsLastAccesses)
          .insert(const TermsLastAccessesCompanion(
            parentTermId: Value(1),
            childId: Value(2),
          ));

      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);

      // Create a TermData with the same parent term ID
      final termData = TermData(
        const Term(
          id: 1,
          uuid: 'test-uuid',
          name: 'Test Term',
          type: 0,
          creation: '2023-01-01',
          enabled: 1,
          free: 1,
          ordering: 0,
          needsUpdate: 0,
          captureable: 1,
          textCulumn: '',
          outerNote: '',
        ),
        deletedAt: const DeletedAt(null),
        visible: const Visible(1),
      );

      final result = await termLastAccessService.isTermAccessed(termData);
      expect(result, true);
    });

    test('isTermAccessed returns false when term has no accessed children',
        () async {
      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);

      // Create a TermData with a term ID that doesn't have any accessed children
      final termData = TermData(
        const Term(
          id: 999,
          uuid: 'test-uuid',
          name: 'Test Term',
          type: 0,
          creation: '2023-01-01',
          enabled: 1,
          free: 1,
          ordering: 0,
          needsUpdate: 0,
          captureable: 1,
          textCulumn: '',
          outerNote: '',
        ),
        deletedAt: const DeletedAt(null),
        visible: const Visible(1),
      );

      final result = await termLastAccessService.isTermAccessed(termData);
      expect(result, false);
    });
  });

  group('addTermLastAccessed tests', () {
    test('addTermLastAccessed inserts a new record', () async {
      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);

      const parentId = Id(1);
      const childId = Id(2);

      await termLastAccessService.addTermLastAccessed(parentId, childId);

      final allItems = await databaseService.termsLastAccesses.all().get();
      expect(allItems.length, 1);
      expect(allItems[0].parentTermId, 1);
      expect(allItems[0].childId, 2);
      expect(allItems[0].lastAccess, greaterThan(0));
    });

    test('addTermLastAccessed updates existing record', () async {
      // Insert an initial record
      databaseService
          .into(databaseService.termsLastAccesses)
          .insert(const TermsLastAccessesCompanion(
            parentTermId: Value(1),
            childId: Value(2),
            lastAccess: Value(1000),
          ));

      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);

      const parentId = Id(1);
      const childId = Id(2);

      // Add the same record again (should update)
      await termLastAccessService.addTermLastAccessed(parentId, childId);

      final allItems = await databaseService.termsLastAccesses.all().get();
      expect(allItems.length, 1);
      expect(allItems[0].parentTermId, 1);
      expect(allItems[0].childId, 2);
      // The lastAccess should be updated to a more recent timestamp
      expect(allItems[0].lastAccess, greaterThan(1000));
    });
  });

  group('addTermLastAccessFromJson tests', () {
    test('addTermLastAccessFromJson inserts records from JSON data', () async {
      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);

      final jsonData = [
        {
          'parentTermId': 1,
          'childId': 2,
          'lastAccess': 1000,
        },
        {
          'parentTermId': 3,
          'childId': 4,
          'lastAccess': 2000,
        }
      ];

      await termLastAccessService.addTermLastAccessFromJson(jsonData);

      final allItems = await databaseService.termsLastAccesses.all().get();
      expect(allItems.length, 2);

      // Check first record
      expect(allItems[0].parentTermId, 1);
      expect(allItems[0].childId, 2);
      expect(allItems[0].lastAccess, 1000);

      // Check second record
      expect(allItems[1].parentTermId, 3);
      expect(allItems[1].childId, 4);
      expect(allItems[1].lastAccess, 2000);
    });

    test('addTermLastAccessFromJson updates existing records', () async {
      // Insert an initial record
      databaseService
          .into(databaseService.termsLastAccesses)
          .insert(const TermsLastAccessesCompanion(
            parentTermId: Value(1),
            childId: Value(2),
            lastAccess: Value(1000),
          ));

      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);

      final jsonData = [
        {
          'parentTermId': 1,
          'childId': 2,
          'lastAccess': 3000, // Updated timestamp
        }
      ];

      await termLastAccessService.addTermLastAccessFromJson(jsonData);

      final allItems = await databaseService.termsLastAccesses.all().get();
      expect(allItems.length, 1);
      expect(allItems[0].parentTermId, 1);
      expect(allItems[0].childId, 2);
      expect(allItems[0].lastAccess, 3000); // Should be updated
    });
  });

  group('getAllTermLastAccesses tests', () {
    test('getAllTermLastAccesses returns all records', () async {
      // Insert some test data
      databaseService
          .into(databaseService.termsLastAccesses)
          .insert(const TermsLastAccessesCompanion(
            parentTermId: Value(1),
            childId: Value(2),
            lastAccess: Value(1000),
          ));

      databaseService
          .into(databaseService.termsLastAccesses)
          .insert(const TermsLastAccessesCompanion(
            parentTermId: Value(3),
            childId: Value(4),
            lastAccess: Value(2000),
          ));

      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);

      final result = await termLastAccessService.getAllTermLastAccesses();
      expect(result.length, 2);

      // Check first record
      expect(result[0].parentTermId, 1);
      expect(result[0].childId, 2);
      expect(result[0].lastAccess, 1000);

      // Check second record
      expect(result[1].parentTermId, 3);
      expect(result[1].childId, 4);
      expect(result[1].lastAccess, 2000);
    });

    test('getAllTermLastAccesses returns empty list when no records exist',
        () async {
      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);

      final result = await termLastAccessService.getAllTermLastAccesses();
      expect(result, isEmpty);
    });
  });

  group('getTermLastAccess tests', () {
    test('getTermLastAccess returns the most recent access record', () async {
      // Insert multiple records for the same parent term
      databaseService
          .into(databaseService.termsLastAccesses)
          .insert(const TermsLastAccessesCompanion(
            parentTermId: Value(1),
            childId: Value(2),
            lastAccess: Value(1000),
          ));

      databaseService
          .into(databaseService.termsLastAccesses)
          .insert(const TermsLastAccessesCompanion(
            parentTermId: Value(1),
            childId: Value(3),
            lastAccess: Value(3000), // Most recent
          ));

      databaseService
          .into(databaseService.termsLastAccesses)
          .insert(const TermsLastAccessesCompanion(
            parentTermId: Value(1),
            childId: Value(4),
            lastAccess: Value(2000),
          ));

      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);

      final result = await termLastAccessService.getTermLastAccess(1);
      expect(result, isNotNull);
      expect(result!.parentTermId, 1);
      expect(result.childId, 3); // The child with the most recent access
      expect(result.lastAccess, 3000);
    });

    test('getTermLastAccess returns null when no records exist for term',
        () async {
      TermLastAccessService termLastAccessService =
          TermLastAccessService(databaseService: databaseService);

      final result = await termLastAccessService.getTermLastAccess(999);
      expect(result, isNull);
    });
  });
}
