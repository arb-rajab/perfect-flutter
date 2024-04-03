import 'package:drift/drift.dart';

@DataClassName('termTrees')
class TermTrees extends Table {
  IntColumn get termId => integer().named('termId')();
  IntColumn get parentTermId => integer().named('parentTermId')();
  IntColumn get depth => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {termId, parentTermId, depth};
}
