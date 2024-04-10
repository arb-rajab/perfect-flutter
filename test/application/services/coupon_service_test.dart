import 'package:beta/application/services/coupon_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:test/test.dart';

void main() {
  late DatabaseService databaseService;
  MainController.testing = true;

  setUp(() => databaseService = DatabaseService());
  tearDown(() => databaseService.close());

  test('getPaidCoupons only do not return free coupons', () async {
    databaseService.into(databaseService.coupons).insert(CouponsCompanion(
        free: const Value(1),
        id: const Value(1),
        type: const Value(1),
        serial: const Value('serial'),
        layer: const Value(1),
        numberOfObjects: const Value(1),
        creation: Value(DateTime.now()),
        rootTermId: const Value(1)));
    var allItems = await databaseService.coupons.all().get();
    expect(allItems.length, 1);

    CouponService couponService =
        CouponService(databaseService: databaseService);
    List coupons = await couponService.getPaidCoupons();
    expect(coupons.length, 0);
  });

  test('getPaidCoupons only do returns paid coupons', () async {
    databaseService.into(databaseService.coupons).insert(CouponsCompanion(
        free: const Value(0),
        id: const Value(1),
        type: const Value(1),
        serial: const Value('serial'),
        layer: const Value(1),
        numberOfObjects: const Value(1),
        creation: Value(DateTime.now()),
        rootTermId: const Value(1)));
    var allItems = await databaseService.coupons.all().get();
    expect(allItems.length, 1);

    CouponService couponService =
        CouponService(databaseService: databaseService);
    List coupons = await couponService.getPaidCoupons();
    expect(coupons.length, 1);
  });
}
