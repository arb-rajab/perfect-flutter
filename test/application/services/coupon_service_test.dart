import 'package:beta/application/services/coupon_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

Future<void> main() async {
  MainController.testing = true;
  await MainController.initServices();
  DatabaseService databaseService = Get.find();
  CouponService couponService = Get.find();
  tearDown(() async {
    await databaseService.coupons.deleteAll();
  });

  group('get paid coupons', () {
    test('getPaidCoupons only do not return free coupons', () async {
      databaseService.into(databaseService.coupons).insert(CouponsCompanion(
            free: const Value(1),
            id: const Value(1),
            type: const Value(1),
            serial: const Value('serial'),
            creation: Value(DateTime.now()),
          ));
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
            creation: Value(DateTime.now()),
          ));
      var allItems = await databaseService.coupons.all().get();
      expect(allItems.length, 1);

      CouponService couponService =
          CouponService(databaseService: databaseService);
      List coupons = await couponService.getPaidCoupons();
      expect(coupons.length, 1);
    });
  });

  group('add coupon', () {
    test('add coupon adds a coupon', () async {
      Coupon coupon = Coupon(
          id: 1,
          serial: 'aaa',
          type: 1,
          free: 0,
          creation: DateTime.now(),
          expirationDays: 12);
      List<Coupon> coupons =
          await (databaseService.select(databaseService.coupons)
                ..where((tbl) => tbl.id.equals(coupon.id)))
              .get();
      expect(coupons.length, 0);

      await couponService.addCoupon(coupon);

      coupons = await (databaseService.select(databaseService.coupons)
            ..where((tbl) => tbl.id.equals(coupon.id)))
          .get();
      expect(coupons.length, 1);
    });

    test('add coupon replace duplicate coupon', () async {
      Coupon coupon = Coupon(
          id: 1,
          serial: 'aaa',
          type: 1,
          free: 0,
          creation: DateTime.now(),
          expirationDays: 12);

      await couponService.addCoupon(coupon);

      coupon = coupon.copyWith(free: 1);

      await couponService.addCoupon(coupon);

      List<Coupon> coupons =
          await (databaseService.select(databaseService.coupons)
                ..where((tbl) => tbl.id.equals(coupon.id)))
              .get();
      expect(coupons.length, 1);
      expect(coupons[0].free, 1);
    });
  });
}
