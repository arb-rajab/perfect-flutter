import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/term_property_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/term_update_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  setUp(() async {
    await initTests();
  });

  Future addTerm(
      {required int id, required int type, int needsUpdate = 1}) async {
    TermService termService = Get.find();
    await termService.addTerms([
      TermData(
          Term(
            captureable: 1,
            id: id,
            uuid: 'uuid$id',
            name: 'name$id',
            type: type,
            creation: '2022-01-01 11:13:15',
            enabled: 1,
            free: 1,
            ordering: 1,
            needsUpdate: needsUpdate,
            textCulumn: '',
            outerNote: '',
          ),
          deletedAt: const DeletedAt(null),
          visible: const Visible(1))
    ]);
  }

  Future addQuestion({required int id, required int parentTermId}) {
    QuestionService questionService = Get.find();
    return questionService.addQuestions([
      Question(
          id: id,
          uuid: 'uuid',
          title: 'title',
          titleTranslation: 'titleTranslation',
          labelId: 1,
          note: 'note',
          noteTranslation: 'noteTranslation',
          parentTermId: parentTermId,
          specialCharacter: 1,
          type: 1,
          edited: 1,
          imageUrl: 'imageUrl',
          creation: '2022-01-01 11:12:13',
          editionDate: '2023-01-01 11:12:13')
    ]);
  }

  group('auto update setting', () {
    test('is enabled by default', () {
      TermUpdateService termUpdateService = Get.find();
      expect(termUpdateService.isAutoUpdateEnabled(), true);
    });

    test('can be disabled', () async {
      TermUpdateService termUpdateService = Get.find();
      await termUpdateService.setAutoUpdateEnabled(false);
      expect(termUpdateService.isAutoUpdateEnabled(), false);
      await termUpdateService.setAutoUpdateEnabled(true);
    });
  });

  group('getDownloadedUpdateableTerms', () {
    test('returns only downloaded terms that need an update', () async {
      await addTerm(id: 100, type: TermType.questions);
      await addQuestion(id: 1000, parentTermId: 100);
      // needs an update but was never downloaded
      await addTerm(id: 101, type: TermType.questions);
      // downloaded but up to date
      await addTerm(id: 102, type: TermType.questions, needsUpdate: 0);
      await addQuestion(id: 1001, parentTermId: 102);

      TermUpdateService termUpdateService = Get.find();
      List<TermData> terms =
          await termUpdateService.getDownloadedUpdateableTerms();

      expect(terms.map((termData) => termData.term.id), [100]);
    });
  });

  group('last updated date', () {
    test('is null when the term was never updated', () async {
      TermPropertyService termPropertyService = Get.find();
      expect(await termPropertyService.getLastUpdated(const Id(999)), null);
    });

    test('keeps only the latest date of a term', () async {
      TermPropertyService termPropertyService = Get.find();
      await termPropertyService.setLastUpdated(
          const Id(100), DateTime(2026, 1, 1));
      await termPropertyService.setLastUpdated(
          const Id(100), DateTime(2026, 2, 2));
      expect(await termPropertyService.getLastUpdated(const Id(100)),
          DateTime(2026, 2, 2));
    });

    test('is left out of backups while other properties are kept', () async {
      TermPropertyService termPropertyService = Get.find();
      await termPropertyService.addTermToFavorite(const Id(100));
      await termPropertyService.setLastUpdated(
          const Id(100), DateTime(2026, 1, 1));
      List<TermProperty> properties =
          await termPropertyService.getAllTermProperties();
      expect(properties.map((property) => property.name), ['favorite']);
    });
  });
}
