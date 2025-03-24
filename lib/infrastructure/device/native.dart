import 'dart:async';
import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:beta/abstract/device_repository_base.dart';
import 'package:beta/main_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:safe_device/safe_device.dart';

class DeviceRepository extends DeviceRepositoryBase {
  late AndroidDeviceInfo _androidDeviceInfo;
  late IosDeviceInfo _iosDeviceInfo;
  @override
  Future<DeviceRepository> initialise() async {
    // if (MainController.testing) WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isAndroid) {
      _androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      _iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    } else {
      if (!MainController.testing) throw UnimplementedError();
    }
    if (Platform.isAndroid) {
      // ime1 = await UniqueIdentifier.serial ?? '';
      ime1 = await const AndroidId().getId() ?? '';
    } else if (Platform.isIOS) {
      ime1 = _iosDeviceInfo.identifierForVendor!;
    }
    if (Platform.isAndroid || Platform.isIOS) {
      rooted = await SafeDevice.isJailBroken;
      isRealDevice = await SafeDevice.isRealDevice;
    }
    return Future(() => this);
  }

  @override
  String getModel() {
    if (Platform.isAndroid) {
      return _androidDeviceInfo.model;
    } else if (Platform.isIOS) {
      return _iosDeviceInfo.utsname.machine;
    }
    if (MainController.testing) return 'test model';
    throw UnimplementedError();
  }

  @override
  String getAndroidApi() {
    if (Platform.isAndroid) {
      return _androidDeviceInfo.version.sdkInt.toString();
    }
    if (MainController.testing) return '25';
    return '';
  }

  @override
  String getIosVersion() {
    if (Platform.isIOS) {
      return _iosDeviceInfo.systemVersion;
    }
    if (MainController.testing) return '25';
    return '';
  }
}
