import 'package:drift/drift.dart';

class Flashcards extends Table {
  IntColumn get id => integer()();
  TextColumn get head => text()();
  TextColumn get tail => text()();
  IntColumn get parentTermId => integer().named('parentTermId')();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  String? get tableName => 'flashcards';
}
