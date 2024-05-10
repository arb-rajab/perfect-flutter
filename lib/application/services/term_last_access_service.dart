import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:drift/drift.dart';

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

  //TODO add test
  Future<bool> isTermAccessed(TermData termData) async {
    int childrenCount = await databaseService.termsLastAccesses
        .count(where: (row) => row.parentTermId.equals(termData.term.id))
        .getSingle();
    return childrenCount > 0;
  }
}
