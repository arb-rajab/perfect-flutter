import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/coupon.dart';
import 'package:drift/drift.dart';

@DriftAccessor(tables: [Coupons])
class CouponService {
  DatabaseService databaseService;
  CouponService({required this.databaseService});

  Future<List<coupons>> getPaidCoupons() =>
      (databaseService.select(databaseService.coupons)
            ..where((t) => t.free.equals(0))
            ..orderBy([(t) => OrderingTerm.desc(t.creation)]))
          .get();
}
