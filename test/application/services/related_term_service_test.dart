import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/related_term_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  DatabaseService databaseService = Get.find();
  RelatedTermService relatedTermService = Get.find();
  tearDown(() async => await databaseService.relatedTerms.deleteAll());

  group('add relatedTerm', () {
    test('add relatedTerm adds a relatedTerm', () async {
      RelatedTerm relatedTerm = const RelatedTerm(anotherTermId: 1, termId: 3);
      List<RelatedTerm> relatedTerms = await (databaseService
              .select(databaseService.relatedTerms)
            ..where((tbl) => tbl.termId.equals(relatedTerm.termId))
            ..where(
                (tbl) => tbl.anotherTermId.equals(relatedTerm.anotherTermId)))
          .get();
      expect(relatedTerms.length, 0);

      await relatedTermService.addRelatedTerms([relatedTerm]);

      relatedTerms = await (databaseService.select(databaseService.relatedTerms)
            ..where((tbl) => tbl.termId.equals(relatedTerm.termId))
            ..where(
                (tbl) => tbl.anotherTermId.equals(relatedTerm.anotherTermId)))
          .get();
      expect(relatedTerms.length, 1);
    });

    test('add relatedTerm replace duplicate relatedTerm', () async {
      RelatedTerm relatedTerm = const RelatedTerm(anotherTermId: 1, termId: 3);

      await relatedTermService.addRelatedTerms([relatedTerm]);

      relatedTerm = relatedTerm.copyWith(termId: 3);

      await relatedTermService.addRelatedTerms([relatedTerm]);

      List<RelatedTerm> relatedTerms = await (databaseService
              .select(databaseService.relatedTerms)
            ..where((tbl) => tbl.termId.equals(relatedTerm.termId))
            ..where(
                (tbl) => tbl.anotherTermId.equals(relatedTerm.anotherTermId)))
          .get();
      expect(relatedTerms.length, 1);
      expect(relatedTerms[0].termId, 3);
    });
  });
}
