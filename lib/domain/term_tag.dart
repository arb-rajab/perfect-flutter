import 'package:drift/drift.dart';

class TermTags extends Table {
  @override
  String? get tableName => 'termsTags';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  IntColumn get ordering => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
