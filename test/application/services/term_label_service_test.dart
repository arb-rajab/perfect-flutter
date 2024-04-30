import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_label_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  DatabaseService databaseService = Get.find();
  TermLabelService termLabelService = Get.find();
  tearDown(() async => await databaseService.termLabels.deleteAll());

  group('add termLabel', () {
    test('add termLabel adds a termLabel', () async {
      TermLabel termLabel = const TermLabel(id: 1, name: 'random name 1');
      List<TermLabel> termLabels =
          await (databaseService.select(databaseService.termLabels)
                ..where((tbl) => tbl.id.equals(termLabel.id)))
              .get();
      expect(termLabels.length, 0);

      await termLabelService.addTermLabels([termLabel]);

      termLabels = await (databaseService.select(databaseService.termLabels)
            ..where((tbl) => tbl.id.equals(termLabel.id)))
          .get();
      expect(termLabels.length, 1);
    });

    test('add termLabel replace duplicate termLabel', () async {
      TermLabel termLabel = const TermLabel(id: 1, name: 'random name 1');
      const String randomName = 'random name 2';

      await termLabelService.addTermLabels([termLabel]);

      termLabel = termLabel.copyWith(name: randomName);

      await termLabelService.addTermLabels([termLabel]);

      List<TermLabel> termLabels =
          await (databaseService.select(databaseService.termLabels)
                ..where((tbl) => tbl.id.equals(termLabel.id)))
              .get();
      expect(termLabels.length, 1);
      expect(termLabels[0].name, randomName);
    });
  });
}
