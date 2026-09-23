import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/terms_with_homework_enabled_properties.dart';
import 'package:beta/domain/value/id.dart';
import 'package:drift/drift.dart';

class TermsWithHomeworkEnabledService {
  final DatabaseService databaseService;

  TermsWithHomeworkEnabledService({required this.databaseService});

  Future addTermsWithHomeworkEnabled(
          List<TermsWithHomeworkEnabledProperties> termsWithHomeworkEnabled) =>
      databaseService.batch((batch) {
        List<TermsWithHomeworkEnabledData> updatedItems =
            termsWithHomeworkEnabled
                .where((element) => !element.isDeleted())
                .map((e) => e.termsWithHomeworkEnabled)
                .toList();

        List<TermsWithHomeworkEnabledData> deletedItems =
            termsWithHomeworkEnabled
                .where((element) => element.isDeleted())
                .map((e) => e.termsWithHomeworkEnabled)
                .toList();
        batch.insertAllOnConflictUpdate(
            databaseService.termsWithHomeworkEnabled, updatedItems);
        for (TermsWithHomeworkEnabledData deletedItem in deletedItems) {
          batch.delete(databaseService.termsWithHomeworkEnabled, deletedItem);
        }
      });

  Future<bool> isTermWithHomeworkEnabled(Id termId) async {
    int count = await databaseService.termsWithHomeworkEnabled
        .count(where: (row) => row.termId.equals(termId.value!))
        .getSingle();
    return count > 0;
  }
}
