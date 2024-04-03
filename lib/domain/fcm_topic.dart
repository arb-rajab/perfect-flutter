import 'package:drift/drift.dart';

@DataClassName('FCMTopics')
class FcmTopics extends Table {
  TextColumn get title => text()();
  BoolColumn get subscriptionSucceed =>
      boolean().named('subscriptionSucceed')();
  BoolColumn get subscribed => boolean()();

  @override
  Set<Column<Object>>? get primaryKey => {title};
}
