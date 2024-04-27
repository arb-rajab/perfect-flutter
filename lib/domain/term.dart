import 'package:drift/drift.dart';

class Terms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => super.text()();
  TextColumn get name => super.text()();
  IntColumn get type => integer()();
  DateTimeColumn get creation => dateTime()();
  IntColumn get enabled => integer().withDefault(const Constant(1))();
  IntColumn get free => integer()();
  IntColumn get ordering => integer()();
  IntColumn get needsUpdate =>
      integer().withDefault(const Constant(0)).named('needsUpdate')();
  IntColumn get captureable => integer().withDefault(const Constant(1))();
  @JsonKey('text')
  TextColumn get textCulumn => super.text().named('text')();

  // Ignore column
  // TextColumn get deletedAt => text().named('deleted_at').nullable()();

  @override
  String? get tableName => 'terms';
}
