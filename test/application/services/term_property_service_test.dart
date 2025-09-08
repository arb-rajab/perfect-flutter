import 'package:beta/application/services/term_property_service.dart';
import 'package:beta/application/services/database_service.dart';

import 'package:get/instance_manager.dart';
import 'package:test/test.dart';
import 'package:beta/domain/value/id.dart';

import '../../common/tests.dart';

Future<void> main() async {
  late TermPropertyService termPropertyService;

  setUp(() async {
    await initTests();
    termPropertyService = Get.find();
  });

  group('deleteAllUserStudiedTerms', () {
    test('should delete all user studied terms', () async {
      // Insert a dummy term property
      await databaseService.into(databaseService.termProperties).insert(
            TermProperty(
                termId: 1, name: termPropertyService.studied, value: 'true'),
          );

      // Ensure the term property exists
      final before =
          await databaseService.select(databaseService.termProperties).get();
      expect(before.length, 1);

      // Call the method under test
      await termPropertyService.deleteAllUserStudiedTerms();

      // Ensure all term properties are deleted
      final after =
          await databaseService.select(databaseService.termProperties).get();
      expect(after.length, 0);
    });

    test('does not delete other term properties', () async {
      // Insert a dummy term property
      await databaseService.into(databaseService.termProperties).insert(
            const TermProperty(termId: 1, name: 'property', value: 'true'),
          );

      // Ensure the term property exists
      final before =
          await databaseService.select(databaseService.termProperties).get();
      expect(before.length, 1);

      // Call the method under test
      await termPropertyService.deleteAllUserStudiedTerms();

      // Ensure all term properties are deleted
      final after =
          await databaseService.select(databaseService.termProperties).get();
      expect(after.length, 1);
    });
  });

  group('addTermToStudied & removeTermFromStudied', () {
    test('addTermToStudied adds a studied property for the term', () async {
      const termId = 42;

      // Ensure no studied property exists
      var before = databaseService.select(databaseService.termProperties)
        ..where((tbl) => tbl.termId.equals(termId));
      expect(await before.get(), isEmpty);

      // Add studied property
      await termPropertyService.addTermToStudied(const Id(termId));

      // Check that the studied property exists
      final after = databaseService.select(databaseService.termProperties)
        ..where((tbl) => tbl.termId.equals(termId));
      final result = await after.get();
      expect(result.length, 1);
      expect(result.first.name, termPropertyService.studied);
      expect(result.first.value, 'true');
    });

    test('removeTermFromStudied removes only the studied property for the term',
        () async {
      const termId = 99;

      // Insert a studied property and another property
      await databaseService.into(databaseService.termProperties).insert(
            TermProperty(
                termId: termId,
                name: termPropertyService.studied,
                value: 'true'),
          );
      await databaseService.into(databaseService.termProperties).insert(
            const TermProperty(termId: termId, name: 'other', value: 'foo'),
          );

      // Remove studied property
      await termPropertyService.removeTermFromStudied(const Id(termId));

      // Only the other property should remain
      final remaining = databaseService.select(databaseService.termProperties)
        ..where((tbl) => tbl.termId.equals(termId));
      final result = await remaining.get();
      expect(result.length, 1);
      expect(result.first.name, isNot(termPropertyService.studied));
    });
  });
  group('isTermStudied', () {
    test('returns true if the term is studied', () async {
      const termId = 123;
      // Add studied property
      await termPropertyService.addTermToStudied(const Id(termId));
      // Should return true
      final result = await termPropertyService.isTermStudied(const Id(termId));
      expect(result, isTrue);
    });

    test('returns false if the term is not studied', () async {
      const termId = 456;
      // Ensure no studied property exists
      final result = await termPropertyService.isTermStudied(const Id(termId));
      expect(result, isFalse);
    });

    test('returns false if the term has a property but not studied', () async {
      const termId = 789;
      // Add a property with a different name
      await databaseService.into(databaseService.termProperties).insert(
            const TermProperty(termId: termId, name: 'other', value: 'true'),
          );
      // Should return false
      final result = await termPropertyService.isTermStudied(const Id(termId));
      expect(result, isFalse);
    });
  });

  group('addTermPropertiesFromJson & getAllTermProperties', () {
    test('addTermPropertiesFromJson adds multiple term properties from JSON',
        () async {
      final data = [
        {'termId': 1, 'name': 'studied', 'value': 'true'},
        {'termId': 2, 'name': 'other', 'value': 'foo'},
      ];
      await termPropertyService.addTermPropertiesFromJson(data);

      final all =
          await databaseService.select(databaseService.termProperties).get();
      expect(all.length, 2);
      expect(
          all.any(
              (e) => e.termId == 1 && e.name == 'studied' && e.value == 'true'),
          isTrue);
      expect(
          all.any(
              (e) => e.termId == 2 && e.name == 'other' && e.value == 'foo'),
          isTrue);
    });

    test('addTermPropertiesFromJson overrides already existed term properties',
        () async {
      // Insert initial property
      await databaseService.into(databaseService.termProperties).insert(
            const TermProperty(termId: 1, name: 'studied', value: 'true'),
          );
      // Override with new value
      final data = [
        {'termId': 1, 'name': 'studied', 'value': 'false'},
      ];
      await termPropertyService.addTermPropertiesFromJson(data);

      final all =
          await databaseService.select(databaseService.termProperties).get();
      expect(all.length, 1);
      expect(all.first.termId, 1);
      expect(all.first.name, 'studied');
      expect(all.first.value, 'false');
    });

    test('getAllTermProperties returns all term properties', () async {
      // Insert some properties
      await databaseService.into(databaseService.termProperties).insert(
            const TermProperty(termId: 10, name: 'studied', value: 'true'),
          );
      await databaseService.into(databaseService.termProperties).insert(
            const TermProperty(termId: 20, name: 'other', value: 'bar'),
          );

      final result = await termPropertyService.getAllTermProperties();
      expect(result.length, greaterThanOrEqualTo(2));
      expect(
          result.any((e) =>
              e.termId == 10 && e.name == 'studied' && e.value == 'true'),
          isTrue);
      expect(
          result.any(
              (e) => e.termId == 20 && e.name == 'other' && e.value == 'bar'),
          isTrue);
    });
  });
}
