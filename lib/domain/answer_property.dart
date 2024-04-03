import 'package:drift/drift.dart';

@DataClassName('answerProperties')
@TableIndex(name: 'answersIndex1', columns: {#answerId})
class AnswerProperties extends Table {
  IntColumn get answerId => integer().named('answerId')();
  TextColumn get name => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>>? get primaryKey => {answerId, name};
}
