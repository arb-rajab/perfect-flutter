import 'package:beta/configs/style.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/dialogues/success_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CouponWithCopy extends StatelessWidget {
  final String coupon;
  static const IconData copyIcon = Icons.copy;

  const CouponWithCopy(this.coupon, {super.key});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: Container(
        margin: const EdgeInsets.all(margin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: coupon));
                showSuccessDialogue(context);
              },
              child: const Icon(
                copyIcon,
                size: 35,
              ),
            ),
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
