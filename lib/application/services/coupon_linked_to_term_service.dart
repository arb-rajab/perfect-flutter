import 'package:beta/application/services/database_service.dart';

class CouponLinkedToTermService {
  final DatabaseService databaseService;

  CouponLinkedToTermService({required this.databaseService});

  Future addCouponLinkedToTerm(CouponsLinkedToTerm couponsLinkedToTerm) =>
      databaseService
          .into(databaseService.couponsLinkedToTerms)
          .insertOnConflictUpdate(couponsLinkedToTerm);
}
