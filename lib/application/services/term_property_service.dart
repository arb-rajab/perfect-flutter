import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';

class TermPropertyService {
  DatabaseService databaseService;
  TermPropertyService({required this.databaseService});
  String studied = 'studied';

  //TODO add test
  Future deleteAllUserStudiedTerms() =>
      (databaseService.delete(databaseService.termProperties)
            ..where((tbl) => tbl.name.equals(studied)))
          .go();

  Future addTermToStudied(TermData termData) =>
      databaseService.into(databaseService.termProperties).insert(
          TermProperty(termId: termData.term.id, name: studied, value: 'true'));

  Future removeTermFromStudied(TermData termData) =>
      (databaseService.delete(databaseService.termProperties)
            ..where((tbl) => tbl.termId.equals(termData.term.id))
            ..where((tbl) => tbl.name.equals(studied)))
          .go();

  Future<bool> isTermStudied(TermData termData) async {
    List properties =
        await (databaseService.select(databaseService.termProperties)
              ..where((tbl) => tbl.termId.equals(termData.term.id))
              ..where((tbl) => tbl.name.equals(studied))
              ..where((tbl) => tbl.value.equals('true')))
            .get();
    return properties.isNotEmpty;
  }

  //TODO add test
  Future addTermPropertiesFromJson(dynamic data) =>
      databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(databaseService.termProperties,
            (data as List).map((e) => TermProperty.fromJson(e)).toList());
      });

  //TODO add test
  Future<List<TermProperty>> getAllTermProperties() =>
      databaseService.select(databaseService.termProperties).get();
}
