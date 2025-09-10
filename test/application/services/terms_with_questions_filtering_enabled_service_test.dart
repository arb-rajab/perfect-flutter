import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_with_questions_filtering_enabled_properties.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/application/services/terms_with_questions_filtering_enabled_service.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() {
  group('TermsWithQuestionsFilteringEnabledService', () {
    late TermsWithQuestionsFilteringEnabledService service;

    setUp(() async {
      await initTests();
      service = Get.find();
    });

    test('addTermsWithQuestionsFilteringEnabled inserts and deletes correctly',
        () async {
      // Prepare test data
      const enabled1 = TermsWithQuestionsFilteringEnabledData(
        termId: 1,
      );

      const enabled2 = TermsWithQuestionsFilteringEnabledData(
        termId: 2,
      );

      final enabledData1 = TermsWithQuestionsFilteringEnabledProperties(
          enabled1,
          deletedAt: const DeletedAt(null));
      final enabledData2 = TermsWithQuestionsFilteringEnabledProperties(
          enabled2,
          deletedAt: const DeletedAt('2025-08-01 14:00:00'));

      // Perform add and delete operations
      await service
          .addTermsWithQuestionsFilteringEnabled([enabledData1, enabledData2]);

      // Inserted item present
      var data = await (databaseService
              .select(databaseService.termsWithQuestionsFilteringEnabled)
            ..where((tbl) => tbl.termId.equals(1)))
          .get();
      expect(data.length, equals(1));

      // Deleted item absent
      data = await (databaseService
              .select(databaseService.termsWithQuestionsFilteringEnabled)
            ..where((tbl) => tbl.termId.equals(2)))
          .get();
      expect(data.length, equals(0));
    });

    test('isTermWithQuestionFilteringEnabled returns true if enabled',
        () async {
      const termIdEnabled = 100;
      const termIdDisabled = 200;

      const enabledData = TermsWithQuestionsFilteringEnabledData(
        termId: termIdEnabled,
      );

      // Insert enabled term
      await databaseService
          .into(databaseService.termsWithQuestionsFilteringEnabled)
          .insert(enabledData);

      // Check enabled term
      final isEnabled = await service
          .isTermWithQuestionFilteringEnabled(const Id(termIdEnabled));
      expect(isEnabled, equals(true));

      // Check disabled (non-existing) term
      final isDisabled = await service
          .isTermWithQuestionFilteringEnabled(const Id(termIdDisabled));
      expect(isDisabled, equals(false));
    });
  });
}
