import 'package:drift/drift.dart';

@DataClassName('termsLastAccess')
class TermsLastAccesses extends Table {
  IntColumn get parentTermId => integer().named('parentTermId')();
  IntColumn get childId => integer().named('childId')();
  DateTimeColumn get lastAccess =>
      dateTime().named('lastAccess').withDefault(Constant(DateTime.now()))();

  @override
  Set<Column<Object>>? get primaryKey => {parentTermId, childId};
}
