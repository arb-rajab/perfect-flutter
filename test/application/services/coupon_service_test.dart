import 'package:beta/application/services/coupon_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';

void main() {
  late CouponService service;
  setUp(() async {
    await initTests();
    service = Get.find();
  });

  // Helper function to create test coupons
  Coupon createTestCoupon({
    int id = 1,
    String serial = 'TEST123',
    int type = 1,
    int free = 0,
    String creation = '2023-01-01',
    String? activationDate,
    int expirationDays = 30,
  }) {
    return Coupon(
      id: id,
      serial: serial,
      type: type,
      free: free,
      creation: creation,
      activationDate: activationDate,
      expirationDays: expirationDays,
    );
  }

  group('getPaidCoupons', () {
    test('returns only non-free coupons ordered by creation date descending',
        () async {
      // Insert test data using batch
      await databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(databaseService.coupons, [
          createTestCoupon(id: 1, free: 0, creation: '2023-01-01'), // Paid
          createTestCoupon(id: 2, free: 1, creation: '2023-01-02'), // Free
          createTestCoupon(id: 3, free: 0, creation: '2023-01-03'), // Paid
          createTestCoupon(id: 4, free: 1, creation: '2023-01-04'), // Free
          createTestCoupon(id: 5, free: 0, creation: '2023-01-05'), // Paid
        ]);
      });

      final paidCoupons = await service.getPaidCoupons();

      expect(paidCoupons.length, 3);
      expect(paidCoupons.map((c) => c.id),
          [5, 3, 1]); // Should be in descending order
      expect(paidCoupons.every((c) => c.free == 0), isTrue);
    });

    test('returns empty list when no paid coupons exist', () async {
      // Insert only free coupons using batch
      await databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(databaseService.coupons, [
          createTestCoupon(id: 1, free: 1),
          createTestCoupon(id: 2, free: 1),
        ]);
      });

      final paidCoupons = await service.getPaidCoupons();
      expect(paidCoupons, isEmpty);
    });
  });

  group('addCoupon', () {
    test('inserts new coupon with all fields', () async {
      final coupon = createTestCoupon(
        id: 1,
        serial: 'UNIQUE123',
        type: 2,
        free: 0,
        creation: '2023-06-01',
        activationDate: '2023-06-02',
        expirationDays: 60,
      );

      await service.addCoupon(coupon);

      final storedCoupons =
          await databaseService.select(databaseService.coupons).get();
      expect(storedCoupons.length, 1);
      expect(storedCoupons.first, coupon);
    });

    test('updates existing coupon on conflict', () async {
      // Insert initial coupon using batch
      await databaseService.batch((batch) {
        batch.insertAllOnConflictUpdate(databaseService.coupons, [
          createTestCoupon(
            id: 1,
            serial: 'OLD123',
            type: 1,
            free: 1,
            expirationDays: 30,
          ),
        ]);
      });

      // Update the coupon
      final updatedCoupon = createTestCoupon(
        id: 1,
        serial: 'NEW123',
        type: 2,
        free: 0,
        expirationDays: 60,
      );
      await service.addCoupon(updatedCoupon);

      final storedCoupons =
          await databaseService.select(databaseService.coupons).get();
      expect(storedCoupons.length, 1);
      expect(storedCoupons.first.serial, 'NEW123');
      expect(storedCoupons.first.type, 2);
      expect(storedCoupons.first.free, 0);
      expect(storedCoupons.first.expirationDays, 60);
    });

    test('handles null activationDate correctly', () async {
      final coupon = createTestCoupon(
        id: 1,
        activationDate: null,
      );

      await service.addCoupon(coupon);

      final storedCoupons =
          await databaseService.select(databaseService.coupons).get();
      expect(storedCoupons.length, 1);
      expect(storedCoupons.first.activationDate, null);
    });

    test('can insert multiple coupons', () async {
      final coupon1 = createTestCoupon(id: 1);
      final coupon2 = createTestCoupon(id: 2);

      await service.addCoupon(coupon1);
      await service.addCoupon(coupon2);

      final storedCoupons =
          await databaseService.select(databaseService.coupons).get();
      expect(storedCoupons.length, 2);
      expect(storedCoupons.map((c) => c.id), containsAll([1, 2]));
    });
  });
}
