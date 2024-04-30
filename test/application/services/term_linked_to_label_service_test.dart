import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_linked_to_label_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  DatabaseService databaseService = Get.find();
  TermLinkedToLabelService termLinkedToLabelService = Get.find();
  tearDown(() async => await databaseService.termsLinkedToLabels.deleteAll());

  group('add termLinkedToLabel', () {
    test('add termLinkedToLabel adds a termLinkedToLabel', () async {
      TermsLinkedToLabel termLinkedToLabel =
          const TermsLinkedToLabel(termId: 1, labelId: 1);
      List<TermsLinkedToLabel> termLinkedToLabels =
          await (databaseService.select(databaseService.termsLinkedToLabels)
                ..where((tbl) => tbl.termId.equals(termLinkedToLabel.termId))
                ..where((tbl) => tbl.labelId.equals(termLinkedToLabel.labelId)))
              .get();
      expect(termLinkedToLabels.length, 0);

      await termLinkedToLabelService
          .addTermsLinkedToLabels([termLinkedToLabel]);

      termLinkedToLabels =
          await (databaseService.select(databaseService.termsLinkedToLabels)
                ..where((tbl) => tbl.termId.equals(termLinkedToLabel.termId))
                ..where((tbl) => tbl.labelId.equals(termLinkedToLabel.labelId)))
              .get();
      expect(termLinkedToLabels.length, 1);
    });

    test('add termLinkedToLabel replace duplicate termLinkedToLabel', () async {
      TermsLinkedToLabel termLinkedToLabel =
          const TermsLinkedToLabel(labelId: 1, termId: 3);

      await termLinkedToLabelService
          .addTermsLinkedToLabels([termLinkedToLabel]);

      termLinkedToLabel = termLinkedToLabel.copyWith(termId: 3);

      await termLinkedToLabelService
          .addTermsLinkedToLabels([termLinkedToLabel]);

      List<TermsLinkedToLabel> termLinkedToLabels =
          await (databaseService.select(databaseService.termsLinkedToLabels)
                ..where((tbl) => tbl.termId.equals(termLinkedToLabel.termId))
                ..where((tbl) => tbl.labelId.equals(termLinkedToLabel.labelId)))
              .get();
      expect(termLinkedToLabels.length, 1);
      expect(termLinkedToLabels[0].termId, 3);
    });
  });
}
