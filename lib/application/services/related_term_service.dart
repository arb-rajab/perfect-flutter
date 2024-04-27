import 'package:beta/application/services/database_service.dart';

class RelatedTermService {
  final DatabaseService databaseService;

  RelatedTermService({required this.databaseService});

  //TODO add test
  Future addRelatedTerms(List<RelatedTerm> relatedTerms) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.relatedTerms, relatedTerms));
}
