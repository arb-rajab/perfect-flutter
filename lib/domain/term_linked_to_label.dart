import 'package:drift/drift.dart';

@TableIndex(name: 'tltlIndex1', columns: {#termId})
@TableIndex(name: 'tltlIndex2', columns: {#labelId})
class TermsLinkedToLabels extends Table {
  IntColumn get termId => integer().named('termId')();
  IntColumn get labelId => integer().named('labelId')();
  //ignore deleted at string
  @override
  Set<Column<Object>>? get primaryKey => {termId, labelId};

  @override
  String? get tableName => 'termsLinkedToLabels';
}
