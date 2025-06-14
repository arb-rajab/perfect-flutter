import 'package:beta/main_controller.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  bool shared = false;
  Future share(String content) {
    if (!MainController.testing) return Share.share(content);
    shared = true;
    return Future.value();
  }
}
