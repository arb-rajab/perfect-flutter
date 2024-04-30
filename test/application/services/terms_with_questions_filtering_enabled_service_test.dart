import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/terms_with_questions_filtering_enabled_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  DatabaseService databaseService = Get.find();
  TermsWithQuestionsFilteringEnabledService
      termsWithQuestionsFilteringEnabledService = Get.find();
  tearDown(() async =>
      await databaseService.termsWithQuestionsFilteringEnabled.deleteAll());

  group('add termsWithQuestionsFilteringEnabled', () {
    test(
        'add termsWithQuestionsFilteringEnabled adds a termsWithQuestionsFilteringEnabled',
        () async {
      TermsWithQuestionsFilteringEnabledData
          termsWithQuestionsFilteringEnabled =
          const TermsWithQuestionsFilteringEnabledData(termId: 3);
      List<TermsWithQuestionsFilteringEnabledData>
          termsWithQuestionsFilteringEnableds = await (databaseService
                  .select(databaseService.termsWithQuestionsFilteringEnabled)
                ..where((tbl) => tbl.termId
                    .equals(termsWithQuestionsFilteringEnabled.termId)))
              .get();
      expect(termsWithQuestionsFilteringEnableds.length, 0);

      await termsWithQuestionsFilteringEnabledService
          .addTermsWithQuestionsFilteringEnabled(
              [termsWithQuestionsFilteringEnabled]);

      termsWithQuestionsFilteringEnableds = await (databaseService
              .select(databaseService.termsWithQuestionsFilteringEnabled)
            ..where((tbl) =>
                tbl.termId.equals(termsWithQuestionsFilteringEnabled.termId)))
          .get();
      expect(termsWithQuestionsFilteringEnableds.length, 1);
    });

    test(
        'add termsWithQuestionsFilteringEnabled replace duplicate termsWithQuestionsFilteringEnabled',
        () async {
      TermsWithQuestionsFilteringEnabledData
          termsWithQuestionsFilteringEnabled =
          const TermsWithQuestionsFilteringEnabledData(termId: 3);

      await termsWithQuestionsFilteringEnabledService
          .addTermsWithQuestionsFilteringEnabled(
              [termsWithQuestionsFilteringEnabled]);

      await termsWithQuestionsFilteringEnabledService
          .addTermsWithQuestionsFilteringEnabled(
              [termsWithQuestionsFilteringEnabled]);

      List<TermsWithQuestionsFilteringEnabledData>
          termsWithQuestionsFilteringEnableds = await (databaseService
                  .select(databaseService.termsWithQuestionsFilteringEnabled)
                ..where((tbl) => tbl.termId
                    .equals(termsWithQuestionsFilteringEnabled.termId)))
              .get();
      expect(termsWithQuestionsFilteringEnableds.length, 1);
    });
  });
}
