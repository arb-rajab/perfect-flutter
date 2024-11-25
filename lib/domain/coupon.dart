import "package:drift/drift.dart";

class Coupons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serial => text()();
  IntColumn get type => integer()();
  IntColumn get free => integer().withDefault(const Constant(1))();
  TextColumn get creation => text()();
  TextColumn get activationDate => text().named('activationDate').nullable()();
  IntColumn get expirationDays =>
      integer().withDefault(const Constant(-1)).named('expirationDays')();

  @override
  String? get tableName => 'coupons';
}
