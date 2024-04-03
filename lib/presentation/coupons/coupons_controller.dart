import 'package:beta/application/services/coupon_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/presentation/coupons/coupon_widget.dart';
import 'package:beta/presentation/widgets/list_controller.dart';
import 'package:get/instance_manager.dart';

class CouponsListController extends ListController<coupons> {
  CouponsListController(state)
      : super(
            state: state,
            remote: false,
            itemBuilder: (context, index) => CouponWidget(index: index),
            plural: null,
            indexUrl: null,
            fetch: () {
              CouponService couponService = Get.find();
              return couponService.getPaidCoupons();
            });
}
