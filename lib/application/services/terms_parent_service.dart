import 'package:beta/application/services/database_service.dart';
import 'package:drift/drift.dart';

class TermsParentService {
  final DatabaseService databaseService;

  TermsParentService({required this.databaseService});

  //TODO add test
  Future addTermsParents(List<TermsParent> termsParents) {
    databaseService.batch((batch) {
      batch.insertAllOnConflictUpdate(
          databaseService.termsParents, termsParents);
    });
    for (int c = 0; c < termsParents.length; c++) {
      TermsParent termsParent = termsParents[c];
      databaseService.customInsert(
          'insert or ignore into termTrees(parentTermId, termId, depth) select p.parentTermId, c.termId, p.depth+c.depth+1 from termTrees p, termTrees c where p.termId=? and c.parentTermId=?',
          variables: [
            Variable.withInt(termsParent.parentTermId),
            Variable.withInt(termsParent.termId)
          ],
          updates: {
            databaseService.termTrees
          });
    }
    return Future.value();
  }
}
