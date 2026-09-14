import 'package:drift/drift.dart';

class TermsWithHomeworkEnabled extends Table {
  IntColumn get termId => integer()();

  @override
  String? get tableName => 'termsWithHomeworkEnabled';

  @override
  Set<Column<Object>>? get primaryKey => {termId};
}
