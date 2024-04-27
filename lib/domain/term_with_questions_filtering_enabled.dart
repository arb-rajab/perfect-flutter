import 'package:drift/drift.dart';

class TermsWithQuestionsFilteringEnabled extends Table {
  IntColumn get termId => integer()();
  //add ignore
  //String deleted_at;

  @override
  String? get tableName => 'termsWithQuestionsFilteringEnabled';

  @override
  Set<Column<Object>>? get primaryKey => {termId};
}
