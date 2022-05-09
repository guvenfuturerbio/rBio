part of '../abstract/app_config.dart';

class OneDoseConstants extends IAppConstants {
  @override
  String kvkkUrl(BuildContext context) =>
      LocaleProvider.of(context).one_dose_kvkk_url_text;
}
