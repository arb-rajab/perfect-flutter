import 'package:beta/application/services/database_service.dart';

class TermLinkedToLabelService {
  final DatabaseService databaseService;

  TermLinkedToLabelService({required this.databaseService});

  //TODO add test
  Future addTermsLinkedToLabels(List<TermsLinkedToLabel> termsLinkedToLabels) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.termsLinkedToLabels, termsLinkedToLabels));
}
