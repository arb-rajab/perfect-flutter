import 'dart:math';

import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CongratulationsWidget extends StatefulWidget {
  const CongratulationsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _CongratulationsWidgetState();
}

class _CongratulationsWidgetState extends State<CongratulationsWidget> {
  late ConfettiController _centerController;

  @override
  void initState() {
    super.initState();
    _centerController =
        ConfettiController(duration: const Duration(seconds: 10));
    _centerController.play();
  }

  @override
  void dispose() {
    // dispose the controller
    _centerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(margin),
        child: Column(children: [
          ConfettiWidget(
            confettiController: _centerController,
            blastDirection: pi / 2,
            maxBlastForce: 5,
            minBlastForce: 1,
            emissionFrequency: 0.03,
            numberOfParticles: 10,
            shouldLoop: true,
            gravity: 0,
          ),
          OpacityAnimation(
            child: Text(
              StringConstant.congratulations.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ]));
  }
}
