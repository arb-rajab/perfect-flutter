import 'package:beta/abstract/device_repository_base.dart';

class DeviceRepository extends DeviceRepositoryBase {
  @override
  String getAndroidApi() => throw UnimplementedError();

  @override
  String getIosVersion() => throw UnimplementedError();

  @override
  String getModel() => throw UnimplementedError();

  @override
  Future<DeviceRepositoryBase> initialise() => throw UnimplementedError();
}
