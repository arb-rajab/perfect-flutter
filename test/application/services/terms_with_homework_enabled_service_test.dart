import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/terms_with_homework_enabled_properties.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/application/services/terms_with_homework_enabled_service.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() {
  group('TermsWithHomeworkEnabledService', () {
    late TermsWithHomeworkEnabledService service;

    setUp(() async {
      await initTests();
      service = Get.find();
    });

    test('addTermsWithHomeworkEnabled inserts and deletes correctly',
        () async {
      const enabled1 = TermsWithHomeworkEnabledData(
        termId: 1,
      );

      const enabled2 = TermsWithHomeworkEnabledData(
        termId: 2,
      );

      final enabledData1 = TermsWithHomeworkEnabledProperties(enabled1,
          deletedAt: const DeletedAt(null));
      final enabledData2 = TermsWithHomeworkEnabledProperties(enabled2,
          deletedAt: const DeletedAt('2025-08-01 14:00:00'));

      await service.addTermsWithHomeworkEnabled([enabledData1, enabledData2]);

      // Inserted item present
      var data = await (databaseService
              .select(databaseService.termsWithHomeworkEnabled)
            ..where((tbl) => tbl.termId.equals(1)))
          .get();
      expect(data.length, equals(1));

      // Deleted item absent
      data = await (databaseService
              .select(databaseService.termsWithHomeworkEnabled)
            ..where((tbl) => tbl.termId.equals(2)))
          .get();
      expect(data.length, equals(0));
    });

    test('addTermsWithHomeworkEnabled updates existing rows on conflict',
        () async {
      const termId = 5;
      await databaseService
          .into(databaseService.termsWithHomeworkEnabled)
          .insert(const TermsWithHomeworkEnabledData(termId: termId));

      final enabledData = TermsWithHomeworkEnabledProperties(
          const TermsWithHomeworkEnabledData(termId: termId),
          deletedAt: const DeletedAt(null));
      await service.addTermsWithHomeworkEnabled([enabledData]);

      final data = await (databaseService
              .select(databaseService.termsWithHomeworkEnabled)
            ..where((tbl) => tbl.termId.equals(termId)))
          .get();
      expect(data.length, equals(1));
    });

    test('isTermWithHomeworkEnabled returns true if enabled', () async {
      const termIdEnabled = 100;
      const termIdDisabled = 200;

      const enabledData = TermsWithHomeworkEnabledData(
        termId: termIdEnabled,
      );

      await databaseService
          .into(databaseService.termsWithHomeworkEnabled)
          .insert(enabledData);

      final isEnabled =
          await service.isTermWithHomeworkEnabled(const Id(termIdEnabled));
      expect(isEnabled, equals(true));

      final isDisabled =
          await service.isTermWithHomeworkEnabled(const Id(termIdDisabled));
      expect(isDisabled, equals(false));
    });
  });
}
