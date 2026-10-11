import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/value/id.dart';

class TermPropertyService {
  DatabaseService databaseService;
  TermPropertyService({required this.databaseService});
  String studied = 'studied';
  String favorite = 'favorite';
  String lastUpdated = 'lastUpdated';

  Future deleteAllUserStudiedTerms() =>
      (databaseService.delete(databaseService.termProperties)
            ..where((tbl) => tbl.name.equals(studied)))
          .go();

  Future deleteAllUserFavoriteTerms() =>
      (databaseService.delete(databaseService.termProperties)
            ..where((tbl) => tbl.name.equals(favorite)))
          .go();

  Future addTermToStudied(Id termId) =>
      databaseService.into(databaseService.termProperties).insert(
          TermProperty(termId: termId.value!, name: studied, value: 'true'));

  Future addTermToFavorite(Id termId) =>
      databaseService.into(databaseService.termProperties).insert(
          TermProperty(termId: termId.value!, name: favorite, value: 'true'));

  Future removeTermFromStudied(Id termId) =>
      (databaseService.delete(databaseService.termProperties)
            ..where((tbl) => tbl.termId.equals(termId.value!))
            ..where((tbl) => tbl.name.equals(studied)))
          .go();

  Future removeTermFromFavorite(Id termId) =>
      (databaseService.delete(databaseService.termProperties)
            ..where((tbl) => tbl.termId.equals(termId.value!))
            ..where((tbl) => tbl.name.equals(favorite)))
          .go();

  Future<bool> isTermStudied(Id termId) async {
    List properties =
        await (databaseService.select(databaseService.termProperties)
              ..where((tbl) => tbl.termId.equals(termId.value!))
              ..where((tbl) => tbl.name.equals(studied))
              ..where((tbl) => tbl.value.equals('true')))
            .get();
    return properties.isNotEmpty;
  }

  Future<bool> isTermFavorite(Id termId) async {
    List properties =
        await (databaseService.select(databaseService.termProperties)
              ..where((tbl) => tbl.termId.equals(termId.value!))
              ..where((tbl) => tbl.name.equals(favorite))
              ..where((tbl) => tbl.value.equals('true')))
            .get();
    return properties.isNotEmpty;
  }

  Future addTermPropertiesFromJson(dynamic data) =>
      databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(databaseService.termProperties,
            (data as List).map((e) => TermProperty.fromJson(e)).toList());
      });

  Future setLastUpdated(Id termId, DateTime date) => databaseService
      .into(databaseService.termProperties)
      .insertOnConflictUpdate(TermProperty(
          termId: termId.value!,
          name: lastUpdated,
          value: date.toIso8601String()));

  Future<DateTime?> getLastUpdated(Id termId) async {
    TermProperty? property =
        await (databaseService.select(databaseService.termProperties)
              ..where((tbl) => tbl.termId.equals(termId.value!))
              ..where((tbl) => tbl.name.equals(lastUpdated)))
            .getSingleOrNull();
    return property == null ? null : DateTime.tryParse(property.value);
  }

  /// The last updated date describes the content downloaded on this device,
  /// so it is left out of backups.
  Future<List<TermProperty>> getAllTermProperties() =>
      (databaseService.select(databaseService.termProperties)
            ..where((tbl) => tbl.name.isNotValue(lastUpdated)))
          .get();
}
