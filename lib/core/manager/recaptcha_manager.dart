import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

class _RecaptchaConstants {
  static const String guvenSiteKey = "6LcE2uUeAAAAAG9hT5S-uhoZ49oUZhai_I2gCnrg";
}

abstract class RecaptchaManager {
  final String siteKey;
  RecaptchaManager(this.siteKey);

  Future<void> init() async {
    await GRecaptchaV3.ready(
      siteKey,
      showBadge: false,
    );
  }

  Future<String> login() async {
    final token = await GRecaptchaV3.execute('login') ?? '';
    return token;
  }

  Future<void> showBadge() async {
    GRecaptchaV3.showBadge();
  }

  Future<void> hideBadge() async {
    GRecaptchaV3.hideBadge();
  }
}

class GuvenRecaptchaManagerImpl extends RecaptchaManager {
  GuvenRecaptchaManagerImpl() : super(_RecaptchaConstants.guvenSiteKey);
}
