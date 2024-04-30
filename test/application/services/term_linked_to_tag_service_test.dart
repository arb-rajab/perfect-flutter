import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_linked_to_tag_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  DatabaseService databaseService = Get.find();
  TermLinkedToTagService termLinkedToTagService = Get.find();
  tearDown(() async => await databaseService.termsLinkedToTags.deleteAll());

  group('add termLinkedToTag', () {
    test('add termLinkedToTag adds a termLinkedToTag', () async {
      TermsLinkedToTag termLinkedToTag =
          const TermsLinkedToTag(termId: 1, tagId: 1);
      List<TermsLinkedToTag> termLinkedToTags =
          await (databaseService.select(databaseService.termsLinkedToTags)
                ..where((tbl) => tbl.termId.equals(termLinkedToTag.termId))
                ..where((tbl) => tbl.tagId.equals(termLinkedToTag.tagId)))
              .get();
      expect(termLinkedToTags.length, 0);

      await termLinkedToTagService.addTermsLinkedToTags([termLinkedToTag]);

      termLinkedToTags =
          await (databaseService.select(databaseService.termsLinkedToTags)
                ..where((tbl) => tbl.termId.equals(termLinkedToTag.termId))
                ..where((tbl) => tbl.tagId.equals(termLinkedToTag.tagId)))
              .get();
      expect(termLinkedToTags.length, 1);
    });

    test('add termLinkedToTag replace duplicate termLinkedToTag', () async {
      TermsLinkedToTag termLinkedToTag =
          const TermsLinkedToTag(tagId: 1, termId: 3);

      await termLinkedToTagService.addTermsLinkedToTags([termLinkedToTag]);

      termLinkedToTag = termLinkedToTag.copyWith(termId: 3);

      await termLinkedToTagService.addTermsLinkedToTags([termLinkedToTag]);

      List<TermsLinkedToTag> termLinkedToTags =
          await (databaseService.select(databaseService.termsLinkedToTags)
                ..where((tbl) => tbl.termId.equals(termLinkedToTag.termId))
                ..where((tbl) => tbl.tagId.equals(termLinkedToTag.tagId)))
              .get();
      expect(termLinkedToTags.length, 1);
      expect(termLinkedToTags[0].termId, 3);
    });
  });
}
