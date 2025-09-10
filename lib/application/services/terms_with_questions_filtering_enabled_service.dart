import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_with_questions_filtering_enabled_properties.dart';
import 'package:beta/domain/value/id.dart';
import 'package:drift/drift.dart';

class TermsWithQuestionsFilteringEnabledService {
  final DatabaseService databaseService;

  TermsWithQuestionsFilteringEnabledService({required this.databaseService});

  Future addTermsWithQuestionsFilteringEnabled(
          List<TermsWithQuestionsFilteringEnabledProperties>
              termsWithQuestionsFilteringEnabled) =>
      databaseService.batch((batch) {
        List<TermsWithQuestionsFilteringEnabledData> updatedItems =
            termsWithQuestionsFilteringEnabled
                .where((element) => !element.isDeleted())
                .map((e) => e.termsWithQuestionsFilteringEnabled)
                .toList();

        List<TermsWithQuestionsFilteringEnabledData> deletedItems =
            termsWithQuestionsFilteringEnabled
                .where((element) => element.isDeleted())
                .map((e) => e.termsWithQuestionsFilteringEnabled)
                .toList();
        batch.insertAllOnConflictUpdate(
            databaseService.termsWithQuestionsFilteringEnabled, updatedItems);
        for (TermsWithQuestionsFilteringEnabledData deletedItem
            in deletedItems) {
          batch.delete(
              databaseService.termsWithQuestionsFilteringEnabled, deletedItem);
        }
      });

  Future<bool> isTermWithQuestionFilteringEnabled(Id termId) async {
    int count = await databaseService.termsWithQuestionsFilteringEnabled
        .count(where: (row) => row.termId.equals(termId.value!))
        .getSingle();
    return count > 0;
  }
}
