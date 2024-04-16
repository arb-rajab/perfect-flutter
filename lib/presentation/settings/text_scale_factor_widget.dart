import 'package:beta/application/services/theme_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/dialogues/changes_applied_upon_restart_dialogue.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class TextScaleFactorWidget extends StatefulWidget {
  const TextScaleFactorWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TextScaleFactorWidgetState();
}

class _TextScaleFactorWidgetState extends State<TextScaleFactorWidget> {
  final ThemeService _themeService = Get.find();
  late double _selectedValue;

  @override
  void initState() {
    _selectedValue = _themeService.getScaleFactor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(Icons.text_fields),
        title: Text(StringConstant.textScaleFactor.tr()),
        subtitle: Slider(
          min: _themeService.minimumScaleFactor,
          max: _themeService.maximumScaleFactor,
          value: _selectedValue,
          onChanged: (value) {
            _themeService.setScaleFactor(value);
            setState(() {
              _selectedValue = value;
            });
          },
          onChangeEnd: (value) {
            showChangesAppliedUponRestartDialogue(context);
          },
        ),
      ),
    );
  }
}
