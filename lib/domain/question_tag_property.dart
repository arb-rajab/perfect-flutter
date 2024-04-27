import 'package:drift/drift.dart';

@TableIndex(name: 'qtpIndex1', columns: {#questionTagId})
class QuestionTagProperties extends Table {
  IntColumn get questionTagId => integer().named('questionTagId')();
  TextColumn get name => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>>? get primaryKey => {questionTagId, name};

  @override
  String? get tableName => 'questionTagProperties';
}
