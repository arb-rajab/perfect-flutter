import 'package:drift/drift.dart';

@DataClassName('couponsLinkedToTerms')
class CouponsLinkedToTerms extends Table {
  IntColumn get couponId => integer().named('couponId')();
  IntColumn get termId => integer().named('termId')();

  @override
  Set<Column<Object>>? get primaryKey => {couponId, termId};
}
