import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  DatabaseService databaseService = Get.find();
  TermService termService = Get.find();
  tearDown(() async {
    await databaseService.terms.deleteAll();
    await databaseService.fcmTopics.deleteAll();
  });

  group('add term', () {
    test('add term adds a term', () async {
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
      List<Term> terms = await (databaseService.select(databaseService.terms)
            ..where((tbl) => tbl.id.equals(term.id)))
          .get();
      expect(terms.length, 0);

      List<TermTree> termTrees =
          await (databaseService.select(databaseService.termTrees)
                ..where((tbl) => tbl.termId.equals(term.id))
                ..where((tbl) => tbl.parentTermId.equals(term.id)))
              .get();
      expect(termTrees.length, 0);

      await termService.addTerms([term]);

      terms = await (databaseService.select(databaseService.terms)
            ..where((tbl) => tbl.id.equals(term.id)))
          .get();
      expect(terms.length, 1);

      termTrees = await (databaseService.select(databaseService.termTrees)
            ..where((tbl) => tbl.termId.equals(term.id))
            ..where((tbl) => tbl.parentTermId.equals(term.id)))
          .get();
      expect(termTrees.length, 1);
    });

    test('add term replace duplicate term', () async {
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

      await termService.addTerms([term]);

      term = term.copyWith(free: 1);

      await termService.addTerms([term]);

      List<Term> terms = await (databaseService.select(databaseService.terms)
            ..where((tbl) => tbl.id.equals(term.id)))
          .get();
      expect(terms.length, 1);
      expect(terms[0].free, 1);

      List<TermTree> termTrees =
          await (databaseService.select(databaseService.termTrees)
                ..where((tbl) => tbl.termId.equals(term.id))
                ..where((tbl) => tbl.parentTermId.equals(term.id)))
              .get();
      expect(termTrees.length, 1);
    });
  });

  group('subscribe to term updates', () {
    test('subscribe to term adds an FCMTopic', () async {
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

      List<FcmTopic> fcmTopics =
          await (databaseService.select(databaseService.fcmTopics)
                ..where((tbl) => tbl.title.equals("termId.${term.id}")))
              .get();
      expect(fcmTopics.length, 0);

      await termService.subscribeToTermUpdates(term);

      fcmTopics = await (databaseService.select(databaseService.fcmTopics)
            ..where((tbl) => tbl.title.equals("termId.${term.id}")))
          .get();
      expect(fcmTopics.length, 1);
    });

    test('subscribe to term replaces duplicate FCMTopic', () async {
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

      await termService.subscribeToTermUpdates(term);
      await termService.subscribeToTermUpdates(term);

      List<FcmTopic> fcmTopics =
          await (databaseService.select(databaseService.fcmTopics)
                ..where((tbl) => tbl.title.equals("termId.${term.id}")))
              .get();
      expect(fcmTopics.length, 1);
    });
  });
}
