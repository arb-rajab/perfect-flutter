import 'package:beta/application/services/database_service.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/application/services/term_linked_to_label_service.dart';
import 'package:beta/domain/term_linked_to_label_data.dart';
import 'package:beta/domain/value/deleted_at.dart';

import '../../common/tests.dart';

void main() {
  group('TermLinkedToLabelService', () {
    late TermLinkedToLabelService service;

    setUp(() async {
      await initTests();
      service = TermLinkedToLabelService(databaseService: databaseService);
    });

    test('addTermsLinkedToLabels inserts and deletes as expected', () async {
      final updatedItem = TermLinkedToLabelData(
        const TermsLinkedToLabel(termId: 1, labelId: 2),
        deletedAt: const DeletedAt(null),
      );
      final deletedItem = TermLinkedToLabelData(
        const TermsLinkedToLabel(termId: 3, labelId: 4),
        deletedAt: const DeletedAt('2025-04-09 13:16:19'),
      );

      await service.addTermsLinkedToLabels([updatedItem, deletedItem]);

      // Should insert only the updated item
      var data =
          await (databaseService.select(databaseService.termsLinkedToLabels)
                ..where((tbl) => Expression.and([
                      tbl.termId.equals(1),
                      tbl.labelId.equals(2),
                    ])))
              .get();
      expect(data.length, equals(1));

      // Should delete only the deleted item
      data = await (databaseService.select(databaseService.termsLinkedToLabels)
            ..where((tbl) => Expression.and([
                  tbl.termId.equals(3),
                  tbl.labelId.equals(4),
                ])))
          .get();
      expect(data.length, equals(0));
    });
  });
}
