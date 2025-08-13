import 'package:beta/abstract/device_repository_base.dart';
import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/instance_manager.dart';
import 'package:uuid/uuid.dart';

class DeviceRepository extends DeviceRepositoryBase {
  late WebBrowserInfo _webBrowserInfo;
  @override
  String getAndroidApi() => '0';

  @override
  String getIosVersion() => '0';

  @override
  String getModel() => _webBrowserInfo.browserName.name;

  @override
  Future<DeviceRepositoryBase> initialise() async {
    _webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;
    KeyValue keyValue = Get.find();
    if (keyValue.getString(KeyValueConstant.webImei) == null) {
      ime1 = const Uuid().v4();
      await keyValue.setString(KeyValueConstant.webImei, ime1);
    } else {
      ime1 = keyValue.getString(KeyValueConstant.webImei)!;
    }
    return Future.value(this);
  }
}
