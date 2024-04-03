import 'package:beta/application/services/theme_service.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/dialogues/changes_applied_upon_restart_dialogue.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class SelectThemeWidget extends StatefulWidget {
  const SelectThemeWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SelectThemeWidgetState();
}

class _SelectThemeWidgetState extends State<SelectThemeWidget> {
  final ThemeService _themeService = Get.find();
  late String _selectedTheme;

  @override
  void initState() {
    _selectedTheme = _themeService.getThemeString();
    super.initState();
  }

  void _selectTheme(ThemeMode themeMode) {
    _themeService.setThemeMode(themeMode);
    Navigator.of(context).pop();
    setState(() {
      _selectedTheme = _themeService.getThemeString();
    });
    showChangesAppliedUponRestartDialogue(context);
  }

  void _showMultiChoiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(StringConstant.chooseAnOption.tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text(StringConstant.systemDefaults.tr()),
                  onTap: () => _selectTheme(ThemeMode.system),
                ),
                const Padding(padding: EdgeInsets.all(margin)),
                GestureDetector(
                  child: Text(StringConstant.light.tr()),
                  onTap: () => _selectTheme(ThemeMode.light),
                ),
                const Padding(padding: EdgeInsets.all(margin)),
                GestureDetector(
                  child: Text(StringConstant.night.tr()),
                  onTap: () => _selectTheme(ThemeMode.dark),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.sunny),
      title: Text(StringConstant.themeMode.tr()),
      subtitle: Text(_selectedTheme),
      onTap: _showMultiChoiceDialog,
    );
  }
}
