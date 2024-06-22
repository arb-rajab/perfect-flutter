import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/dialogues/yes_no_dialogue.dart';
import 'package:beta/presentation/printed_qr_scanner/congratulations_widget.dart';
import 'package:beta/presentation/printed_qr_scanner/warning_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//TODO test if gift text is visible and back press shows dialogue
class OtherGiftWidget extends StatelessWidget {
  final String gift;

  const OtherGiftWidget({super.key, required this.gift});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          showYesNoDialogueDialog(context,
              onYesClicked: context.pop,
              onNoClicked: () {},
              title: StringConstant.confirmExist.tr(),
              description: StringConstant.haveYouRecievedGift.tr());
        }
      },
      child: Column(
        children: [
          const CongratulationsWidget(),
          _YouWonTheGiftBelow(),
          _Gift(gift),
          WarningWidget(text: StringConstant.dontCloseUntilGiftRecieved.tr())
        ],
      ),
    );
  }
}

class _YouWonTheGiftBelow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: Container(
        margin: const EdgeInsets.all(margin),
        child: Center(
          child: Text(
            StringConstant.youWonTheGiftBelow.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}

class _Gift extends StatelessWidget {
  final String gift;

  const _Gift(this.gift);
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: Container(
        margin: const EdgeInsets.all(margin),
        child: Center(
          child: Text(
            gift,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
