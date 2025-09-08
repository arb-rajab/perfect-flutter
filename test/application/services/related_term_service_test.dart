import 'package:beta/application/services/database_service.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/application/services/related_term_service.dart';
import 'package:beta/domain/related_term_data.dart';
import 'package:beta/domain/value/deleted_at.dart';

import '../../common/tests.dart';

void main() {
  group('RelatedTermService', () {
    late RelatedTermService service;

    setUp(() async {
      await initTests();
      service = RelatedTermService(databaseService: databaseService);
    });

    test('addRelatedTerms inserts and deletes as expected', () async {
      final updatedTerm = RelatedTermData(
        const RelatedTerm(anotherTermId: 1, termId: 2),
        deletedAt: const DeletedAt(null),
      );
      final deletedTerm = RelatedTermData(
        const RelatedTerm(anotherTermId: 3, termId: 4),
        deletedAt: const DeletedAt('2025-04-09 13:16:19'),
      );

      await service.addRelatedTerms([updatedTerm, deletedTerm]);

      // Should insert only the updated term
      var data = await (databaseService.select(databaseService.relatedTerms)
            ..where((tbl) => Expression.and(
                [tbl.anotherTermId.equals(1), tbl.termId.equals(2)])))
          .get();
      expect(data.length, equals(1));

      // Should delete only the deleted term
      data = await (databaseService.select(databaseService.relatedTerms)
            ..where((tbl) => Expression.and(
                [tbl.anotherTermId.equals(3), tbl.termId.equals(4)])))
          .get();
      expect(data.length, equals(0));
    });
  });
}
