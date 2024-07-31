import 'package:beta/configs/style.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/widgets/copy_widget.dart';
import 'package:flutter/material.dart';

class CouponWithCopy extends StatelessWidget {
  final String coupon;

  const CouponWithCopy(this.coupon, {super.key});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: Container(
        margin: const EdgeInsets.all(margin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CopyWidget(content: coupon),
            Text(
              coupon,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
