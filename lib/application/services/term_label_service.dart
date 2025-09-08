import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_label_data.dart';

class TermLabelService {
  final DatabaseService databaseService;

  TermLabelService({required this.databaseService});

  Future addTermLabels(List<TermLabelData> termLabels) =>
      databaseService.batch((batch) {
        List<TermLabel> updatedItems = termLabels
            .where((element) => !element.isDeleted())
            .map((e) => e.termLabel)
            .toList();
        List<TermLabel> deletedItems = termLabels
            .where((element) => element.isDeleted())
            .map((e) => e.termLabel)
            .toList();
        batch.insertAllOnConflictUpdate(
            databaseService.termLabels, updatedItems);
        for (TermLabel item in deletedItems) {
          batch.delete(databaseService.termLabels, item);
        }
      });

  Future<List<TermLabel>> getTermsLabels(List<TermData> terms) =>
      (databaseService.select(databaseService.termLabels)
            ..where((tbl) => tbl.id.isIn(terms
                .where((element) => element.labelId!.value != null)
                .map((e) => e.labelId!.value!))))
          .get();
  
}
