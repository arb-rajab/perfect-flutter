import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:drift/drift.dart';

class TermsParentService {
  final DatabaseService databaseService;

  TermsParentService({required this.databaseService});

  Future addTermsParents(List<TermsParentData> termsParents) async {
    List<TermsParent> addedItems = termsParents
        .where((element) => !element.isDeleted())
        .map((e) => e.termsParent)
        .toList();
    List<TermsParent> deletedItems = termsParents
        .where((element) => element.isDeleted())
        .map((e) => e.termsParent)
        .toList();
    databaseService.batch((batch) {
      batch.insertAllOnConflictUpdate(databaseService.termsParents, addedItems);
      for (TermsParent deletedItem in deletedItems) {
        batch.delete(databaseService.termsParents, deletedItem);
      }
    });
    for (int c = 0; c < addedItems.length; c++) {
      TermsParent termsParent = addedItems[c];
      await databaseService.customInsert(
          'insert or ignore into termTrees(parentTermId, termId, depth) select p.parentTermId, c.termId, p.depth+c.depth+1 from termTrees p, termTrees c where p.termId=? and c.parentTermId=?',
          variables: [
            Variable.withInt(termsParent.parentTermId),
            Variable.withInt(termsParent.termId)
          ],
          updates: {
            databaseService.termTrees
          });
    }
    for (int c = 0; c < deletedItems.length; c++) {
      TermsParent termsParent = deletedItems[c];
      await (databaseService.delete(databaseService.termTrees)
            ..where((tbl) => tbl.termId.equals(termsParent.termId))
            ..where((tbl) => tbl.parentTermId.isInQuery(
                databaseService.selectOnly(databaseService.termTrees)
                  ..addColumns([databaseService.termTrees.parentTermId])
                  ..where(databaseService.termTrees.termId
                      .equals(termsParent.parentTermId)))))
          .go();
      await (databaseService.delete(databaseService.termTrees)
            ..where((tbl) => Expression.and([
                  tbl.termId.equals(termsParent.termId),
                  tbl.parentTermId.equals(termsParent.parentTermId)
                ])))
          .go();
      await (databaseService.delete(databaseService.termTrees)
            ..where((tbl) => tbl.parentTermId.equals(termsParent.parentTermId))
            ..where((tbl) => tbl.termId.isInQuery(
                databaseService.selectOnly(databaseService.termTrees)
                  ..addColumns([databaseService.termTrees.termId])
                  ..where(databaseService.termTrees.parentTermId
                      .equals(termsParent.termId)))))
          .go();
    }
    return Future.value();
  }
}
