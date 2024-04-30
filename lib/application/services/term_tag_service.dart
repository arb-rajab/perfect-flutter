import 'package:beta/application/services/database_service.dart';

class TermTagService {
  final DatabaseService databaseService;

  TermTagService({required this.databaseService});

  Future addTermTags(List<TermTag> termTags) => databaseService.batch((batch) =>
      batch.insertAllOnConflictUpdate(databaseService.termTags, termTags));
}
