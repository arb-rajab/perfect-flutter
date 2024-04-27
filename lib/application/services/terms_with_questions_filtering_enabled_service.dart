import 'package:beta/application/services/database_service.dart';

class TermsWithQuestionsFilteringEnabledService {
  final DatabaseService databaseService;

  TermsWithQuestionsFilteringEnabledService({required this.databaseService});

  //TODO add test
  Future addTermsWithQuestionsFilteringEnabled(
          List<TermsWithQuestionsFilteringEnabledData>
              termsWithQuestionsFilteringEnabled) =>
      databaseService.batch((batch) => batch.insertAllOnConflictUpdate(
          databaseService.termsWithQuestionsFilteringEnabled,
          termsWithQuestionsFilteringEnabled));
}
