import 'package:beta/application/services/database_service.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/application/services/term_linked_to_tag_service.dart';
import 'package:beta/domain/term_linked_to_tag_data.dart';
import 'package:beta/domain/value/deleted_at.dart';

import '../../common/tests.dart';

void main() {
  group('TermLinkedToTagService', () {
    late TermLinkedToTagService service;

    setUp(() async {
      await initTests();
      service = TermLinkedToTagService(databaseService: databaseService);
    });

    test('addTermsLinkedToTags inserts and deletes as expected', () async {
      final updatedItem = TermLinkedToTagData(
        const TermsLinkedToTag(termId: 1, tagId: 2),
        deletedAt: const DeletedAt(null),
      );
      final deletedItem = TermLinkedToTagData(
        const TermsLinkedToTag(termId: 3, tagId: 4),
        deletedAt: const DeletedAt('2025-04-09 13:16:19'),
      );

      await service.addTermsLinkedToTags([updatedItem, deletedItem]);

      // Should insert only the updated item
      var data =
          await (databaseService.select(databaseService.termsLinkedToTags)
                ..where((tbl) => Expression.and([
                      tbl.termId.equals(1),
                      tbl.tagId.equals(2),
                    ])))
              .get();
      expect(data.length, equals(1));

      // Should delete only the deleted item
      data = await (databaseService.select(databaseService.termsLinkedToTags)
            ..where((tbl) => Expression.and([
                  tbl.termId.equals(3),
                  tbl.tagId.equals(4),
                ])))
          .get();
      expect(data.length, equals(0));
    });
  });
}
