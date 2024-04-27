import 'package:drift/drift.dart';

class FcmTopics extends Table {
  TextColumn get title => text()();
  BoolColumn get subscriptionSucceed =>
      boolean().named('subscriptionSucceed')();
  //TODO add delete column migration
  // BoolColumn get subscribed => boolean()();

  @override
  Set<Column<Object>>? get primaryKey => {title};

  @override
  String? get tableName => 'FCMTopics';
}
