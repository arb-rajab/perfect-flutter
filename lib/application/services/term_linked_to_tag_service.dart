import 'package:beta/application/services/database_service.dart';

class TermLinkedToTagService {
  final DatabaseService databaseService;

  TermLinkedToTagService({required this.databaseService});

  //TODO add test
  Future addTermsLinkedToTags(List<TermsLinkedToTag> termsLinkedToTags) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.termsLinkedToTags, termsLinkedToTags));
}
