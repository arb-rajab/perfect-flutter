import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final packageRepositoryProvider = Provider((ref) => PackageRepository());

class PackageRepository {
  late PackageInfo _packageInfo;
  bool _isInitialised = false;

  PackageRepository() {
    _initialise();
  }

  Future<PackageInfo> _initialise() async {
    _isInitialised = true;
    _packageInfo = await PackageInfo.fromPlatform();
    return _packageInfo;
  }

  bool get isInitialised => _isInitialised;

  String getPackageName() => _packageInfo.packageName;

  String getVersionName() => _packageInfo.version;

  String getApplicationName() => _packageInfo.appName;
}
