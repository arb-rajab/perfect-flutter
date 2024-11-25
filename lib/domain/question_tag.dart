import 'package:drift/drift.dart';

@TableIndex(name: 'questionTagsIndex1', columns: {#parentTagId})
class QuestionTags extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  IntColumn get parentTagId => integer().named('parentTagId')();
  IntColumn get hasInformation =>
      integer().withDefault(const Constant(0)).named('hasInformation')();
  TextColumn get creation => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  String? get tableName => 'questionTags';
}
