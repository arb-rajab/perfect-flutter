import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_tag_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/id.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() {
  group('TermTagService', () {
    late TermTagService service;

    setUp(() async {
      await initTests();
      service = Get.find();
    });

    test('addTermTags calls batch insert and delete correctly', () async {
      const termTag1 = TermTag(id: 1, name: 'tag 1', ordering: 1);
      const termTag2 = TermTag(id: 2, name: 'tag 2', ordering: 1);
      final termTagData1 =
          TermTagData(termTag1, deletedAt: const DeletedAt(null));
      final termTagData2 = TermTagData(termTag2,
          deletedAt: const DeletedAt('2025-08-17 14:17:19'));

      await service.addTermTags([termTagData1, termTagData2]);

      // Should insert only the updated tag
      var data = await (databaseService.select(databaseService.termTags)
            ..where((tbl) =>
                Expression.and([tbl.id.equals(1), tbl.name.equals('tag 1')])))
          .get();
      expect(data.length, equals(1));

      // Should delete only the deleted tag
      data = await (databaseService.select(databaseService.termTags)
            ..where((tbl) =>
                Expression.and([tbl.id.equals(2), tbl.name.equals('tag 2')])))
          .get();
      expect(data.length, equals(0));
    });

    test('addTermTags calls batch insert and overrides same tag', () async {
      const termTag1 = TermTag(id: 1, name: 'tag 1', ordering: 1);
      final termTagData1 =
          TermTagData(termTag1, deletedAt: const DeletedAt(null));

      await service.addTermTags([termTagData1]);
      await service.addTermTags(
          [termTagData1..termTag = termTag1.copyWith(name: 'tag 2')]);

      // Should not find old name
      var data = await (databaseService.select(databaseService.termTags)
            ..where((tbl) =>
                Expression.and([tbl.id.equals(1), tbl.name.equals('tag 1')])))
          .get();
      expect(data.length, equals(0));

      // Should find updated name
      data = await (databaseService.select(databaseService.termTags)
            ..where((tbl) =>
                Expression.and([tbl.id.equals(1), tbl.name.equals('tag 2')])))
          .get();
      expect(data.length, equals(1));
    });

    test('getTermsTags queries with correct ids', () async {
      const termTag1 = TermTag(id: 1, name: 'tag 1', ordering: 1);
      const termTag2 = TermTag(id: 2, name: 'tag 2', ordering: 2);
      const termTag3 = TermTag(id: 3, name: 'tag 3', ordering: 3);

      await databaseService.into(databaseService.termTags).insert(termTag1);
      await databaseService.into(databaseService.termTags).insert(termTag2);
      await databaseService.into(databaseService.termTags).insert(termTag3);

      List<TermData> terms = [
        TermData(
            const Term(
                id: 1,
                uuid: 'uuid',
                name: 'name',
                type: TermType.term,
                creation: '2025-01-08 14:17:19',
                enabled: 1,
                free: 1,
                ordering: 1,
                needsUpdate: 0,
                captureable: 1,
                textCulumn: 'textCulumn',
                outerNote: 'outerNote'),
            tagId: const Id(1)),
        TermData(
            const Term(
                id: 2,
                uuid: 'uuid',
                name: 'name 2',
                type: TermType.term,
                creation: '2025-01-08 14:17:19',
                enabled: 1,
                free: 1,
                ordering: 1,
                needsUpdate: 0,
                captureable: 1,
                textCulumn: 'textCulumn',
                outerNote: 'outerNote'),
            tagId: const Id(2))
      ];

      List<TermTag> tags = await service.getTermsTags(terms);
      expect(tags.length, equals(2));
      expect(tags.any((tag) => tag.id == 1), true);
      expect(tags.any((tag) => tag.id == 2), true);
      expect(tags.any((tag) => tag.id == 3), false);
    });
  });
}
