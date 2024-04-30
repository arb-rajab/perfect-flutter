import 'package:beta/application/services/database_service.dart';

class TermsWithQuestionsFilteringEnabledService {
  final DatabaseService databaseService;

  TermsWithQuestionsFilteringEnabledService({required this.databaseService});

  Future addTermsWithQuestionsFilteringEnabled(
          List<TermsWithQuestionsFilteringEnabledData>
              termsWithQuestionsFilteringEnabled) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.termsWithQuestionsFilteringEnabled,
          termsWithQuestionsFilteringEnabled));
}
