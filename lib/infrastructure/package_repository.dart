import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final packageRepositoryProvider =
    FutureProvider((ref) => PackageRepository()._initialise());

class PackageRepository {
  late PackageInfo _packageInfo;
  bool _isInitialised = false;

  PackageRepository() {
    _initialise();
  }

  Future<PackageRepository> _initialise() async {
    _packageInfo = await PackageInfo.fromPlatform();
    _isInitialised = true;
    return Future(() => this);
  }

  bool get isInitialised => _isInitialised;

  String getPackageName() => _packageInfo.packageName;

  String getVersionName() => _packageInfo.version;

  String getApplicationName() => _packageInfo.appName;
}
