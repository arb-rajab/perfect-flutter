import 'package:drift/drift.dart';

class Configs extends Table {
  TextColumn get title => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>>? get primaryKey => {title};
}
