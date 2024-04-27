import "package:drift/drift.dart";

//TODO add migration to drop layer, numberOfObjects and rootTermId columns
class Coupons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serial => text()();
  IntColumn get type => integer()();
  // IntColumn get layer => integer()();
  // IntColumn get numberOfObjects =>
  //     integer().withDefault(const Constant(1)).named('numberOfObjects')();
  // IntColumn get rootTermId => integer().named('rootTermId')();
  IntColumn get free => integer().withDefault(const Constant(1))();
  DateTimeColumn get creation => dateTime()();
  DateTimeColumn get activationDate =>
      dateTime().named('activationDate').nullable()();
  IntColumn get expirationDays =>
      integer().withDefault(const Constant(-1)).named('expirationDays')();

  @override
  String? get tableName => 'coupons';
}
