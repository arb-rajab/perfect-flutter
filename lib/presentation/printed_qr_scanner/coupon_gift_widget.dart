import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/dialogues/success_dialogue.dart';
import 'package:beta/presentation/dialogues/yes_no_dialogue.dart';
import 'package:beta/presentation/printed_qr_scanner/congratulations_widget.dart';
import 'package:beta/presentation/printed_qr_scanner/warning_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//TODO Apply test to check coupon exists and copying works
//TODO add back press confirm dialogue
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
          _CouponWithCopy(coupon),
          WarningWidget(text: StringConstant.dontCloseUntilCouponCopied.tr())
        ],
      ),
    );
  }
}

class _YouWonTheCouponBelow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(margin),
      child: Center(
        child: Text(
          StringConstant.youWonTheCouponBelow.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class _CouponWithCopy extends StatelessWidget {
  final String coupon;

  const _CouponWithCopy(this.coupon);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Icons.copy,
              size: 35,
            ),
          ),
          Text(
            coupon,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
