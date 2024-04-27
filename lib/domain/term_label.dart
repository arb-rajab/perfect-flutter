import 'package:drift/drift.dart';

class TermLabels extends Table {
  @override
  String? get tableName => 'termsLabels';

  IntColumn get id => integer()();
  TextColumn get name => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
