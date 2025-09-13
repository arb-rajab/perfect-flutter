import 'package:drift/drift.dart';

class FcmTopics extends Table {
  TextColumn get title => text()();
  BoolColumn get subscriptionSucceed =>
      boolean().named('subscriptionSucceed')();

  @override
  Set<Column<Object>>? get primaryKey => {title};

  @override
  String? get tableName => 'FCMTopics';
}
