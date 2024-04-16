import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/dialogues/yes_no_dialogue.dart';
import 'package:beta/presentation/printed_qr_scanner/congratulations_widget.dart';
import 'package:beta/presentation/printed_qr_scanner/coupon_with_copy_widget.dart';
import 'package:beta/presentation/printed_qr_scanner/warning_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

//TODO Apply test to check copying works and back press shows dialogue
class CouponGiftWidget extends StatelessWidget {
  final String coupon;
  const CouponGiftWidget({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          showYesNoDialogueDialog(context,
              onYesClicked: Navigator.of(context).pop,
              onNoClicked: () {},
              title: StringConstant.confirmExist.tr(),
              description: StringConstant.haveYouCopiedCoupon.tr());
        }
      },
      child: Column(
        children: [
          const CongratulationsWidget(),
          _YouWonTheCouponBelow(),
          CouponWithCopy(coupon),
          WarningWidget(text: StringConstant.dontCloseUntilCouponCopied.tr())
        ],
      ),
    );
  }
}

class _YouWonTheCouponBelow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: Container(
        margin: const EdgeInsets.all(margin),
        child: Center(
          child: Text(
            StringConstant.youWonTheCouponBelow.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
