import 'package:beta/main_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageRepository {
  late PackageInfo _packageInfo;
  bool _isInitialised = false;

  Future<PackageRepository> initialise() async {
    if (MainController.testing) {
      // ignore: invalid_use_of_visible_for_testing_member
      PackageInfo.setMockInitialValues(
          appName: 'Random App',
          packageName: 'com.examplle.random',
          version: '1.2.3',
          buildNumber: '12',
          buildSignature: 'random build signature');
    }
    _packageInfo = await PackageInfo.fromPlatform();
    _isInitialised = true;
    return Future(() => this);
  }

  bool get isInitialised => _isInitialised;

  String getPackageName() => _packageInfo.packageName;

  String getVersionName() => _packageInfo.version;

  String getVersionCode() => _packageInfo.buildNumber;

  String getApplicationName() => _packageInfo.appName;
}
