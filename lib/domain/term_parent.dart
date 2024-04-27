import 'package:drift/drift.dart';

class TermsParents extends Table {
  IntColumn get termId => integer().named('termId')();
  IntColumn get parentTermId => integer().named('parentTermId')();
  IntColumn get rootTermId => integer().named('rootTermId')();
  DateTimeColumn get creation => dateTime()();
  //string delted_at
  @override
  Set<Column<Object>>? get primaryKey => {termId, parentTermId, rootTermId};

  @override
  String? get tableName => 'termsParents';
}
