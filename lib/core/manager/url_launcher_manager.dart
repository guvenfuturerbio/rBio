import 'package:url_launcher/url_launcher.dart' as url_launcher;

abstract class UrlLauncherManager {
  Future<void> launch(String url);
  Future<bool> canLaunch(String url);
}

class UrlLauncherManagerImpl extends UrlLauncherManager {
  @override
  Future<void> launch(String url) async {
    if (await url_launcher.canLaunchUrl(Uri.parse(url))) {
      await url_launcher.launchUrl(Uri.parse(url));
    } else {
      throw RbioCanLaunchException(url);
    }
  }

  @override
  Future<bool> canLaunch(String url) =>
      url_launcher.canLaunchUrl(Uri.parse(url));
}

class RbioCanLaunchException implements Exception {
  final String url;
  RbioCanLaunchException(this.url);

  @override
  String toString() => '[RbioCanLaunchException($url)]';
}
