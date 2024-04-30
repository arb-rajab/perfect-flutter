import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  DatabaseService databaseService = Get.find();
  TermTagService termTagService = Get.find();
  tearDown(() async => await databaseService.termTags.deleteAll());

  group('add termTag', () {
    test('add termTag adds a termTag', () async {
      TermTag termTag =
          const TermTag(id: 1, name: 'random name 1', ordering: 1);
      List<TermTag> termTags =
          await (databaseService.select(databaseService.termTags)
                ..where((tbl) => tbl.id.equals(termTag.id)))
              .get();
      expect(termTags.length, 0);

      await termTagService.addTermTags([termTag]);

      termTags = await (databaseService.select(databaseService.termTags)
            ..where((tbl) => tbl.id.equals(termTag.id)))
          .get();
      expect(termTags.length, 1);
    });

    test('add termTag replace duplicate termTag', () async {
      TermTag termTag =
          const TermTag(id: 1, name: 'random name 1', ordering: 1);
      const String randomName = 'random name 2';

      await termTagService.addTermTags([termTag]);

      termTag = termTag.copyWith(name: randomName);

      await termTagService.addTermTags([termTag]);

      List<TermTag> termTags =
          await (databaseService.select(databaseService.termTags)
                ..where((tbl) => tbl.id.equals(termTag.id)))
              .get();
      expect(termTags.length, 1);
      expect(termTags[0].name, randomName);
    });
  });
}
