import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:beta/common/exceptions.dart';
import 'package:beta/configs/app.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:safe_device/safe_device.dart';

class DeviceRepository {
  late DeviceInfoPlugin _deviceInfoPlugin;
  late AndroidDeviceInfo _androidDeviceInfo;
  late IosDeviceInfo _iosDeviceInfo;
  bool _isInitialised = false;
  String ime1 = '';

  bool rooted = false;
  bool isRealDevice = true;

  Future<DeviceRepository> initialise() async {
    _deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      _androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      _iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
    } else {
      throw UnsupportedPlatformException();
    }
    if (Platform.isAndroid) {
      ime1 = await UniqueIdentifier.serial ?? '';
    } else if (Platform.isIOS) {
      ime1 = _iosDeviceInfo.identifierForVendor!;
    }
    if (Platform.isAndroid || Platform.isIOS) {
      rooted = await SafeDevice.isJailBroken;
      isRealDevice = await SafeDevice.isRealDevice;
    }
    _isInitialised = true;
    return Future(() => this);
  }

  bool get isInitialised => _isInitialised;

  String getModel() {
    if (Platform.isAndroid) {
      return _androidDeviceInfo.model;
    } else if (Platform.isIOS) {
      return _iosDeviceInfo.utsname.machine;
    }
    throw UnsupportedPlatformException();
  }

  String getAndroidApi() {
    if (Platform.isAndroid) {
      return _androidDeviceInfo.version.sdkInt.toString();
    }
    return '';
  }

  String getIosVersion() {
    if (Platform.isIOS) {
      return _iosDeviceInfo.systemVersion;
    }
    return '';
  }

  int isRooted() {
    if (rooted) return 1;
    return 0;
  }

  int isEmulator() {
    if (isRealDevice) return 0;
    return 1;
  }

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
      'appLanguage': context.locale.languageCode,
      'appVersionCode': packageRepository.getVersionCode(),
      'appVersionName': packageRepository.getVersionName()
    });
  }
}
