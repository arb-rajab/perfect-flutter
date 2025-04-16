import 'package:beta/abstract/device_repository_base.dart';
import 'package:device_info_plus/device_info_plus.dart';
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
    ime1 = const Uuid().v4();
    return Future.value(this);
  }
}
