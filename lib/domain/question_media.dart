import 'package:drift/drift.dart';

@TableIndex(name: 'questionMediasIndex1', columns: {#parentQuestionId})
class QuestionMedias extends Table {
  IntColumn get id => integer()();
  TextColumn get url => text()();
  IntColumn get parentQuestionId => integer().named('parentQuestionId')();
  DateTimeColumn get creation => dateTime()();

  @override
  Set<Column> get primaryKey => {id, parentQuestionId};

  @override
  String? get tableName => 'questionMedias';
}
