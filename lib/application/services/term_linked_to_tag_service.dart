import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_linked_to_tag_data.dart';

class TermLinkedToTagService {
  final DatabaseService databaseService;

  TermLinkedToTagService({required this.databaseService});

  Future addTermsLinkedToTags(List<TermLinkedToTagData> termsLinkedToTags) =>
      databaseService.batch((batch) {
        List<TermsLinkedToTag> updatedItems = termsLinkedToTags
            .where((element) => !element.isDeleted())
            .map((e) => e.termLinkedToTag)
            .toList();
        List<TermsLinkedToTag> deletedItems = termsLinkedToTags
            .where((element) => element.isDeleted())
            .map((e) => e.termLinkedToTag)
            .toList();
        batch.insertAllOnConflictUpdate(
            databaseService.termsLinkedToTags, updatedItems);
        for (TermsLinkedToTag item in deletedItems) {
          batch.delete(databaseService.termsLinkedToTags, item);
        }
      });
}
