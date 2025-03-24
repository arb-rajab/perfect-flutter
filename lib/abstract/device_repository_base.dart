import 'dart:convert';

import 'package:beta/configs/app.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/main_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

abstract class DeviceRepositoryBase {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String ime1 = '';
  bool rooted = false;
  bool isRealDevice = true;

  Future<DeviceRepositoryBase> initialise();
  String getModel();
  String getAndroidApi();
  String getIosVersion();

  int isRooted() => rooted == true ? 1 : 0;
  int isEmulator() => isRealDevice == true ? 0 : 1;

  String getFullInfo(BuildContext context) {
    PackageRepository packageRepository = Get.find();
    return jsonEncode({
      'ime1': ime1,
      'ime2': '',
      'buildModel': getModel(),
      'androidAPI': getAndroidApi(),
      'iosVersion': getIosVersion(),
      'rooted': isRooted(),
      'isEmulator': isEmulator(),
      'appId': appId,
      'appLanguage':
          MainController.testing ? 'en' : context.locale.languageCode,
      'appVersionCode': packageRepository.getVersionCode(),
      'appVersionName': packageRepository.getVersionName()
    });
  }
}
