import 'package:beta/main_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionRepository {
  Future<bool> isConnected() {
    if (MainController.testing) return Future.value(true);
    return Connectivity().checkConnectivity().then((value) {
      if (value.contains(ConnectivityResult.mobile) ||
          value.contains(ConnectivityResult.wifi)) {
        return true;
      }
      return false;
    });
  }

  Future<bool> isOnWifi() {
    if (MainController.testing) return Future.value(true);
    return Connectivity().checkConnectivity().then((value) =>
        value.contains(ConnectivityResult.wifi) ||
        value.contains(ConnectivityResult.ethernet));
  }
}
