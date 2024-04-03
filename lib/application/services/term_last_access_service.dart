import 'package:beta/application/services/database_service.dart';

class TermLastAccessService {
  DatabaseService databaseService;
  TermLastAccessService({required this.databaseService});

  Future deleteAllTermLastAccess() => databaseService
      .delete(databaseService.termsLastAccesses)
      .go()
      .whenComplete(() =>
          (databaseService.delete(databaseService.questionTagProperties)
                ..where((tbl) => tbl.name.equals('lastAccess')))
              .go());
}
