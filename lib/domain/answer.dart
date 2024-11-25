import 'package:drift/drift.dart';

@TableIndex(name: 'parentQuestionIdIndex', columns: {#parentQuestionId})
class Answers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text()();
  TextColumn get title => text()();
  TextColumn get titleTranslation =>
      text().withDefault(const Constant('')).named('titleTranslation')();
  IntColumn get isCorrect => integer().named('isCorrect')();
  IntColumn get parentQuestionId => integer().named('parentQuestionId')();
  IntColumn get specialCharacter => integer().named('specialCharacter')();
  TextColumn get creation => text()();
  IntColumn get checkedCount =>
      integer().withDefault(const Constant(0)).named('checkedCount')();

  @override
  String? get tableName => 'answers';
}
