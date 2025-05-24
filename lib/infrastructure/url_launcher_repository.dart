import 'package:beta/main_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherRepository {
  String? openedUrl;
  Future openUrl(String url) async {
    if (MainController.testing) {
      openedUrl = url;
    } else if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
