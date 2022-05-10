part of '../abstract/app_config.dart';

class GuvenConstants extends IAppConstants {
  @override
  String kvkkUrl(BuildContext context) =>
      LocaleProvider.of(context).guven_kvkk_url_text;
}
