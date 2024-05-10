import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_linked_to_label_data.dart';

class TermLinkedToLabelService {
  final DatabaseService databaseService;

  TermLinkedToLabelService({required this.databaseService});

  //TODO add test
  Future addTermsLinkedToLabels(
          List<TermLinkedToLabelData> termsLinkedToLabels) =>
      databaseService.batch((batch) {
        List<TermsLinkedToLabel> updatedItems = termsLinkedToLabels
            .where((element) => !element.isDeleted())
            .map((e) => e.termLinkedToLabel)
            .toList();
        List<TermsLinkedToLabel> deletedItems = termsLinkedToLabels
            .where((element) => element.isDeleted())
            .map((e) => e.termLinkedToLabel)
            .toList();
        batch.insertAllOnConflictUpdate(
            databaseService.termsLinkedToLabels, updatedItems);
        for (TermsLinkedToLabel item in deletedItems) {
          batch.delete(databaseService.termsLinkedToLabels, item);
        }
      });
}
