import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/coupons/coupons_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class CouponWidget extends StatelessWidget {
  final int index;
  const CouponWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    CouponsListController couponsListController = Get.find();
    Coupon coupon = couponsListController.items[index];
    int difference = coupon.activationDate != null
        ? coupon.activationDate!
            .add(Duration(days: coupon.expirationDays))
            .difference(DateTime.now())
            .inDays
        : 0;
    return OpacityAnimation(
      child: ListTile(
        title: Text(coupon.serial),
        leading: const Icon(Icons.credit_card),
        subtitle: coupon.activationDate != null
            ? (difference < 0
                ? Text(StringConstant.couponExpired.tr(),
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error))
                : Text(StringConstant.expiresInNDays
                    .tr()
                    .replaceFirst('(N)', difference.toString())))
            : null,
      ),
    );
  }
}
