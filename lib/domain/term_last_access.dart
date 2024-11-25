import 'package:drift/drift.dart';

@DataClassName('TermsLastAccess')
class TermsLastAccesses extends Table {
  IntColumn get parentTermId => integer().named('parentTermId')();
  IntColumn get childId => integer().named('childId')();
  IntColumn get lastAccess => integer()
      .named('lastAccess')
      .withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();

  @override
  Set<Column<Object>>? get primaryKey => {parentTermId, childId};

  @override
  String? get tableName => 'termsLastAccess';
}
