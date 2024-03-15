import 'dart:async';
import 'dart:io';
import 'package:beta/common/exceptions.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deviceRepositoryProvider = FutureProvider<DeviceRepository>(
    (ref) async => await DeviceRepository().initialise());

class DeviceRepository {
  late DeviceInfoPlugin _deviceInfoPlugin;
  late AndroidDeviceInfo _androidDeviceInfo;
  late IosDeviceInfo _iosDeviceInfo;
  bool _isInitialised = false;

  Future<DeviceRepository> initialise() async {
    _deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      _androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      _iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
    } else {
      throw UnsupportedPlatformException();
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
}
