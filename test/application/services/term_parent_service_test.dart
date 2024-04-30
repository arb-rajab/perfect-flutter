import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  DatabaseService databaseService = Get.find();
  TermsParentService termParentService = Get.find();
  TermService termService = Get.find();
  tearDown(() async => await databaseService.termsParents.deleteAll());

  group('add termParent', () {
    test('add termParent adds a termParent', () async {
      TermsParent termParent = TermsParent(
          parentTermId: 3, termId: 1, rootTermId: 1, creation: DateTime.now());
      Term term = Term(
          id: 1,
          type: 1,
          free: 0,
          creation: DateTime.now(),
          uuid: 'aaa',
          name: 'random name',
          enabled: 1,
          ordering: 1,
          needsUpdate: 1,
          captureable: 1,
          textCulumn: '');
      Term parentTerm = Term(
          id: 3,
          type: 1,
          free: 0,
          creation: DateTime.now(),
          uuid: 'aaa',
          name: 'random name',
          enabled: 1,
          ordering: 1,
          needsUpdate: 1,
          captureable: 1,
          textCulumn: '');
      List<TermsParent> termsParents = await (databaseService
              .select(databaseService.termsParents)
            ..where((tbl) => tbl.termId.equals(termParent.termId))
            ..where((tbl) => tbl.parentTermId.equals(termParent.parentTermId)))
          .get();
      expect(termsParents.length, 0);

      List<TermTree> termTrees = await (databaseService
              .select(databaseService.termTrees)
            ..where((tbl) => tbl.termId.equals(termParent.termId))
            ..where((tbl) => tbl.parentTermId.equals(termParent.parentTermId)))
          .get();
      expect(termTrees.length, 0);

      await termService.addTerms([term, parentTerm]);
      await termParentService.addTermsParents([termParent]);

      termsParents = await (databaseService.select(databaseService.termsParents)
            ..where((tbl) => tbl.termId.equals(termParent.termId))
            ..where((tbl) => tbl.parentTermId.equals(termParent.parentTermId)))
          .get();
      expect(termsParents.length, 1);

      termTrees = await (databaseService.select(databaseService.termTrees)
            ..where((tbl) => tbl.termId.equals(termParent.termId))
            ..where((tbl) => tbl.parentTermId.equals(termParent.parentTermId)))
          .get();
      expect(termTrees.length, 1);
    });

    test('add termParent replace duplicate termParent', () async {
      TermsParent termParent = TermsParent(
          parentTermId: 3, termId: 1, rootTermId: 1, creation: DateTime.now());
      Term term = Term(
          id: 1,
          type: 1,
          free: 0,
          creation: DateTime.now(),
          uuid: 'aaa',
          name: 'random name',
          enabled: 1,
          ordering: 1,
          needsUpdate: 1,
          captureable: 1,
          textCulumn: '');
      Term parentTerm = Term(
          id: 3,
          type: 1,
          free: 0,
          creation: DateTime.now(),
          uuid: 'aaa',
          name: 'random name',
          enabled: 1,
          ordering: 1,
          needsUpdate: 1,
          captureable: 1,
          textCulumn: '');

      await termService.addTerms([term, parentTerm]);
      await termParentService.addTermsParents([termParent]);
      await termParentService.addTermsParents([termParent]);

      List<TermsParent> termsParents = await (databaseService
              .select(databaseService.termsParents)
            ..where((tbl) => tbl.termId.equals(termParent.termId))
            ..where((tbl) => tbl.parentTermId.equals(termParent.parentTermId)))
          .get();
      expect(termsParents.length, 1);

      List<TermTree> termTrees = await (databaseService
              .select(databaseService.termTrees)
            ..where((tbl) => tbl.termId.equals(termParent.termId))
            ..where((tbl) => tbl.parentTermId.equals(termParent.parentTermId)))
          .get();
      expect(termTrees.length, 1);
    });
  });
}
