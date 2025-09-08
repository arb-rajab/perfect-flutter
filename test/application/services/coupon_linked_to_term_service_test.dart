import 'package:beta/application/services/coupon_linked_to_term_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';

void main() {
  late CouponLinkedToTermService service;
  setUp(() async {
    await initTests();
    service = Get.find();
  });

  // Helper function to create a test CouponsLinkedToTerm
  CouponsLinkedToTerm createTestCouponLinkedToTerm({
    int couponId = 1,
    int termId = 1,
  }) {
    return CouponsLinkedToTerm(
      couponId: couponId,
      termId: termId,
    );
  }

  test('addCouponLinkedToTerm inserts new record', () async {
    final couponLink = createTestCouponLinkedToTerm(couponId: 1, termId: 1);

    await service.addCouponLinkedToTerm(couponLink);

    final storedLinks = await databaseService
        .select(databaseService.couponsLinkedToTerms)
        .get();
    expect(storedLinks.length, 1);
    expect(storedLinks.first.couponId, 1);
    expect(storedLinks.first.termId, 1);
  });

  test('addCouponLinkedToTerm can handle multiple unique records', () async {
    final link1 = createTestCouponLinkedToTerm(couponId: 1, termId: 1);
    final link2 = createTestCouponLinkedToTerm(couponId: 2, termId: 1);

    await service.addCouponLinkedToTerm(link1);
    await service.addCouponLinkedToTerm(link2);

    final storedLinks = await databaseService
        .select(databaseService.couponsLinkedToTerms)
        .get();
    expect(storedLinks.length, 2);
    expect(storedLinks.map((l) => l.couponId), containsAll([1, 2]));
    expect(storedLinks.map((l) => l.termId), everyElement(equals(1)));
  });

  test('addCouponLinkedToTerm handles equality correctly', () async {
    final link1 = createTestCouponLinkedToTerm(couponId: 1, termId: 1);
    final link2 =
        createTestCouponLinkedToTerm(couponId: 1, termId: 1); // Same as link1

    await service.addCouponLinkedToTerm(link1);
    await service.addCouponLinkedToTerm(link2); // Should update existing

    final storedLinks = await databaseService
        .select(databaseService.couponsLinkedToTerms)
        .get();
    expect(storedLinks.length, 1); // Only one record since they're equal
  });

  test('addCouponLinkedToTerm preserves all fields', () async {
    final couponLink = createTestCouponLinkedToTerm(
      couponId: 100,
      termId: 200,
    );

    await service.addCouponLinkedToTerm(couponLink);

    final storedLinks = await databaseService
        .select(databaseService.couponsLinkedToTerms)
        .get();
    expect(storedLinks.length, 1);
    expect(storedLinks.first.couponId, 100);
    expect(storedLinks.first.termId, 200);
  });
}
