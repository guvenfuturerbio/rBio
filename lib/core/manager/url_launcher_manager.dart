import 'package:url_launcher/url_launcher.dart' as url_launcher;

abstract class UrlLauncherManager {
  Future<void> canLaunch(String urlString);
}

class UrlLauncherManagerImpl extends UrlLauncherManager {
  @override
  Future<void> canLaunch(String urlString) async {
    if (await url_launcher.canLaunch(urlString)) {
      await url_launcher.launch(urlString);
    } else {
      throw 'Could not launch $urlString';
    }
  }
}
