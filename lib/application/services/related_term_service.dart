import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/related_term_data.dart';

class RelatedTermService {
  final DatabaseService databaseService;

  RelatedTermService({required this.databaseService});

  //TODO add test
  Future addRelatedTerms(List<RelatedTermData> relatedTerms) {
    List<RelatedTerm> updatedRelatedTerms = relatedTerms
        .where((element) => !element.isDeleted())
        .map((e) => e.relatedTerm)
        .toList();
    List<RelatedTerm> deletedRelatedTerms = relatedTerms
        .where((element) => element.isDeleted())
        .map((e) => e.relatedTerm)
        .toList();
    return databaseService.batch((batch) {
      batch.insertAllOnConflictUpdate(
          databaseService.relatedTerms, updatedRelatedTerms);
      for (RelatedTerm deletedRelatedTerm in deletedRelatedTerms) {
        batch.delete(databaseService.relatedTerms, deletedRelatedTerm);
      }
    });
  }
}
