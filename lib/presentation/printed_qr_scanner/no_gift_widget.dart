import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NoGiftWidget extends StatelessWidget {
  const NoGiftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_Unfortunately(), _NoGift()],
    );
  }
}

class _Unfortunately extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: Container(
        margin: const EdgeInsets.all(margin),
        child: Center(
          child: Text(
            StringConstant.unfortunately.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}

class _NoGift extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: Container(
        margin: const EdgeInsets.all(margin),
        child: Center(
          child: Text(
            StringConstant.noGift.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
