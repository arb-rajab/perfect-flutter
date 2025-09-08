import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_label_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/id.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/application/services/term_label_service.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() {
  group('TermLabelService', () {
    late TermLabelService service;

    setUp(() async {
      await initTests();
      service = Get.find();
    });

    test('addTermLabels calls batch insert and delete correctly', () async {
      const termLabel1 = TermLabel(id: 1, name: 'label 1');
      const termLabel2 = TermLabel(id: 2, name: 'label 2');
      final termLabelData1 =
          TermLabelData(termLabel1, deletedAt: const DeletedAt(null));
      final termLabelData2 = TermLabelData(termLabel2,
          deletedAt: const DeletedAt('2025-08-17 14:17:19'));

      await service.addTermLabels([termLabelData1, termLabelData2]);

      // Should insert only the updated label
      var data = await (databaseService.select(databaseService.termLabels)
            ..where((tbl) =>
                Expression.and([tbl.id.equals(1), tbl.name.equals('label 1')])))
          .get();
      expect(data.length, equals(1));

      // Should delete only the deleted label
      data = await (databaseService.select(databaseService.termLabels)
            ..where((tbl) =>
                Expression.and([tbl.id.equals(2), tbl.name.equals('label 2')])))
          .get();
      expect(data.length, equals(0));
    });

    test('addTermLabels calls batch insert and overrides same label', () async {
      const termLabel1 = TermLabel(id: 1, name: 'label 1');
      final termLabelData1 =
          TermLabelData(termLabel1, deletedAt: const DeletedAt(null));

      await service.addTermLabels([termLabelData1]);
      await service.addTermLabels(
          [termLabelData1..termLabel = termLabel1.copyWith(name: 'label 2')]);

      // Should insert only the updated label
      var data = await (databaseService.select(databaseService.termLabels)
            ..where((tbl) =>
                Expression.and([tbl.id.equals(1), tbl.name.equals('label 1')])))
          .get();
      expect(data.length, equals(0));

      // Should delete only the deleted label
      data = await (databaseService.select(databaseService.termLabels)
            ..where((tbl) =>
                Expression.and([tbl.id.equals(1), tbl.name.equals('label 2')])))
          .get();
      expect(data.length, equals(1));
    });

    test('getTermsLabels queries with correct ids', () async {
      const termLabel1 = TermLabel(id: 1, name: 'label 1');
      const termLabel2 = TermLabel(id: 2, name: 'label 2');
      const termLabel3 = TermLabel(id: 3, name: 'label 3');

      await databaseService.into(databaseService.termLabels).insert(termLabel1);
      await databaseService.into(databaseService.termLabels).insert(termLabel2);
      await databaseService.into(databaseService.termLabels).insert(termLabel3);

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
            labelId: const Id(1)),
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
            labelId: const Id(2))
      ];

      List<TermLabel> labels = await service.getTermsLabels(terms);
      expect(labels.length, equals(2));
      expect(labels.any((label) => label.id == 1), true);
      expect(labels.any((label) => label.id == 2), true);
      expect(labels.any((label) => label.id == 3), false);
    });
  });
}
