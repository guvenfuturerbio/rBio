part of '../abstract/app_config.dart';

class GuvenConstants extends IAppConstants {
  @override
  String envPath = 'env/guven/.prod.env';

  @override
  String kvkkUrl(BuildContext context) =>
      LocaleProvider.of(context).one_dose_kvkk_url_text;

  @override
  String jailbreakWarning(BuildContext context) =>
      LocaleProvider.of(context).onedosehealth_jailbreak_warning;
}
