import 'package:drift/drift.dart';

@DataClassName('questionProperties')
@TableIndex(name: 'qpIndex1', columns: {#questionId})
class QuestionProperties extends Table {
  IntColumn get questionId => integer().named('questionId')();
  TextColumn get name => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>>? get primaryKey => {questionId, name};
}
