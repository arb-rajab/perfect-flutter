import 'package:url_launcher/url_launcher.dart';

class UrlLauncherRepository {
  Future openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
