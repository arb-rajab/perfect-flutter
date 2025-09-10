import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() {
  group('TermsParentService', () {
    late TermsParentService service;

    setUp(() async {
      await initTests();
      service = Get.find();
    });

    test('addTermsParents inserts and deletes batch items correctly', () async {
      const termsParent1 = TermsParent(
          parentTermId: 1,
          termId: 2,
          rootTermId: 1,
          creation: '2025-01-01 11:14:16');
      const termsParent2 = TermsParent(
          parentTermId: 3,
          termId: 4,
          rootTermId: 1,
          creation: '2025-01-01 11:14:16');
      final termsParentData1 =
          TermsParentData(termsParent1, deletedAt: const DeletedAt(null));
      final termsParentData2 = TermsParentData(termsParent2,
          deletedAt: const DeletedAt('2025-08-17 14:17:19'));

      await service.addTermsParents([termsParentData1, termsParentData2]);

      // Validate batch inserted item present
      var data = await (databaseService.select(databaseService.termsParents)
            ..where((tbl) => tbl.parentTermId.equals(1) & tbl.termId.equals(2)))
          .get();
      expect(data.length, equals(1));

      // Validate batch deleted item absent
      data = await (databaseService.select(databaseService.termsParents)
            ..where((tbl) => tbl.parentTermId.equals(3) & tbl.termId.equals(4)))
          .get();
      expect(data.length, equals(0));
    });

    test('addTermsParents updates termTrees on add and delete correctly',
        () async {
      // Insert simulated entries in termTrees
      await databaseService.into(databaseService.termTrees).insert(
            const TermTree(parentTermId: 100, termId: 101, depth: 0),
          );
      await databaseService.into(databaseService.termTrees).insert(
            const TermTree(parentTermId: 102, termId: 103, depth: 0),
          );

      const toAdd = TermsParent(
          parentTermId: 100,
          termId: 101,
          rootTermId: 100,
          creation: '2025-01-01 11:14:16');
      const toDelete = TermsParent(
          parentTermId: 102,
          termId: 103,
          rootTermId: 102,
          creation: '2025-01-01 11:14:16');

      final addData = TermsParentData(toAdd, deletedAt: const DeletedAt(null));
      final deleteData = TermsParentData(toDelete,
          deletedAt: const DeletedAt('2025-01-01 13:17:15'));

      // Pre-insert termsParents to be deleted to simulate existing data
      await databaseService.into(databaseService.termsParents).insert(toDelete);

      await service.addTermsParents([addData, deleteData]);

      // Verify termTrees contains new relations for added parent
      final addedTermTrees =
          await (databaseService.select(databaseService.termTrees)
                ..where((tbl) =>
                    tbl.parentTermId.equals(toAdd.parentTermId) &
                    tbl.termId.equals(toAdd.termId)))
              .get();
      expect(addedTermTrees.length, greaterThan(0));

      // Verify termTrees no longer contains relations for deleted parent
      final deletedTermTrees =
          await (databaseService.select(databaseService.termTrees)
                ..where((tbl) =>
                    tbl.parentTermId.equals(toDelete.parentTermId) &
                    tbl.termId.equals(toDelete.termId)))
              .get();
      expect(deletedTermTrees.length, equals(0));
    });
  });
}
