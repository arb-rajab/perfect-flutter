import 'package:drift/drift.dart';

@TableIndex(name: 'tlttIndex1', columns: {#termId})
@TableIndex(name: 'tlttIndex2', columns: {#tagId})
class TermsLinkedToTags extends Table {
  IntColumn get termId => integer().named('termId')();
  IntColumn get tagId => integer().named('tagId')();
  //ignore deleted at string
  @override
  Set<Column<Object>>? get primaryKey => {termId, tagId};

  @override
  String? get tableName => 'termsLinkedToTags';
}
