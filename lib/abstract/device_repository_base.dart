import 'dart:convert';

import 'package:beta/configs/app.dart';
import 'package:beta/configs/locals.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/main_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
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

  String getFullInfo() {
    PackageRepository packageRepository = Get.find();
    String languageCode = Get.isRegistered<String>(tag: 'language code')
        ? Get.find(tag: 'language code')
        : supportedLocals[0].languageCode;
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
          MainController.testing ? 'en' : languageCode,
      'appVersionCode': packageRepository.getVersionCode(),
      'appVersionName': packageRepository.getVersionName()
    });
  }
}
