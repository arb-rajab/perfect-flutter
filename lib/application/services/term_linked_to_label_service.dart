import 'package:beta/application/services/database_service.dart';

class TermLinkedToLabelService {
  final DatabaseService databaseService;

  TermLinkedToLabelService({required this.databaseService});

  Future addTermsLinkedToLabels(List<TermsLinkedToLabel> termsLinkedToLabels) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.termsLinkedToLabels, termsLinkedToLabels));
}
