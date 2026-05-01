import 'package:drift/drift.dart';

class Images extends Table {
  IntColumn get id => integer()();
  TextColumn get url => text()();
  TextColumn get title => text()();
  TextColumn get info => text()();
  IntColumn get parentTermId => integer().named('parentTermId')();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  String? get tableName => 'images';
}
