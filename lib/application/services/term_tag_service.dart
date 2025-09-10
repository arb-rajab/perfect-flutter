import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_tag_data.dart';

class TermTagService {
  final DatabaseService databaseService;

  TermTagService({required this.databaseService});

  Future addTermTags(List<TermTagData> termTags) =>
      databaseService.batch((batch) {
        List<TermTag> updatedItems = termTags
            .where((element) => !element.isDeleted())
            .map((e) => e.termTag)
            .toList();
        List<TermTag> deletedItems = termTags
            .where((element) => element.isDeleted())
            .map((e) => e.termTag)
            .toList();
        batch.insertAllOnConflictUpdate(databaseService.termTags, updatedItems);
        for (TermTag item in deletedItems) {
          batch.delete(databaseService.termTags, item);
        }
      });

  Future<List<TermTag>> getTermsTags(List<TermData> terms) =>
      (databaseService.select(databaseService.termTags)
            ..where((tbl) => tbl.id.isIn(terms
                .where((element) => element.tagId!.value != null)
                .map((e) => e.tagId!.value!))))
          .get();
}
