import 'package:drift/drift.dart';

//TODO add migration
@TableIndex(name: 'termsIndex1', columns: {#termId})
class TermProperties extends Table {
  IntColumn get termId => integer().named('termId')();
  TextColumn get name => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>>? get primaryKey => {termId, name};

  @override
  String? get tableName => 'termProperties';
}
