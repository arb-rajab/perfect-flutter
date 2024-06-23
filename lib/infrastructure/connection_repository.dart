import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionRepository {
  Future<bool> isConnected() =>
      Connectivity().checkConnectivity().then((value) {
        if (value.contains(ConnectivityResult.mobile) ||
            value.contains(ConnectivityResult.wifi)) {
          return true;
        }
        return false;
      });
}
