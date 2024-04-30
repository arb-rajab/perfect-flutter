import 'package:beta/application/services/database_service.dart';

class TermLabelService {
  final DatabaseService databaseService;

  TermLabelService({required this.databaseService});

  Future addTermLabels(List<TermLabel> termLabels) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.termLabels, termLabels));
}
