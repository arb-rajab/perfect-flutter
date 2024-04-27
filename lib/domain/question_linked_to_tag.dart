import 'package:drift/drift.dart';

@TableIndex(name: 'qlttIndex1', columns: {#questionId})
@TableIndex(name: 'qlttIndex2', columns: {#tagId})
class QuestionsLinkedToTags extends Table {
  IntColumn get questionId => integer().named('questionId')();
  IntColumn get tagId => integer().named('tagId')();
  @override
  Set<Column<Object>>? get primaryKey => {questionId, tagId};

  @override
  String? get tableName => 'questionsLinkedToTags';
}
