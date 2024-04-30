import 'package:beta/application/services/database_service.dart';
import 'package:drift/drift.dart';

class CouponService {
  DatabaseService databaseService;
  CouponService({required this.databaseService});

  Future<List<Coupon>> getPaidCoupons() =>
      (databaseService.select(databaseService.coupons)
            ..where((t) => t.free.equals(0))
            ..orderBy([(t) => OrderingTerm.desc(t.creation)]))
          .get();

  Future addCoupon(Coupon coupon) => databaseService
      .into(databaseService.coupons)
      .insertOnConflictUpdate(coupon);
}
