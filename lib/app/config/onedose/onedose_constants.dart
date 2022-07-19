part of '../abstract/app_config.dart';

class OneDoseConstants extends IAppConstants {
  @override
  String envPath = 'env/onedose/.prod.env';

  @override
  String kvkkUrl(BuildContext context) =>
      LocaleProvider.of(context).one_dose_kvkk_url_text;

  @override
  String jailbreakWarning(BuildContext context) =>
      LocaleProvider.of(context).onedosehealth_jailbreak_warning;
}
