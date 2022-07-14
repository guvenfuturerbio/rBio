part of '../abstract/app_config.dart';

class OneDoseTheme extends IAppTheme {
  @override
  String fontFamily = R.constants.fontSourceSans;

  @override
  String appLogo = R.constants.oneDoseHealthAppLogo;

  @override
  String successAppointmentImage =
      R.constants.oneDoseHealthSuccessAppointmentImage;

  @override
  double appBarLogoHeight = 50;

  @override
  Color mainColor = R.colors.greenHaze;

  @override
  Color secondaryColor = R.colors.skeptic;

  @override
  Color textContrastColor = R.colors.black;
}
