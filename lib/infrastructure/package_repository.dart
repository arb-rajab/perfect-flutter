import 'package:package_info_plus/package_info_plus.dart';

class PackageRepository {
  late PackageInfo _packageInfo;
  bool _isInitialised = false;

  Future<PackageRepository> initialise() async {
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
