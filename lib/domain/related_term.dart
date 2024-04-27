import 'package:drift/drift.dart';

class RelatedTerms extends Table {
  IntColumn get anotherTermId => integer().named('anotherTermId')();
  IntColumn get termId => integer().named('termId')();
  //ignore String deleted_at
  @override
  Set<Column<Object>>? get primaryKey => {anotherTermId, termId};

  @override
  String? get tableName => 'relatedTerms';
}
