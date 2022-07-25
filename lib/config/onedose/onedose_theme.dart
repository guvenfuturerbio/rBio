part of '../abstract/app_config.dart';

class OneDoseTheme extends IAppTheme {
  @override
  late TextTheme textTheme;

  @override
  Brightness brightness = Brightness.light;

  OneDoseTheme() {
    textTheme = TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: convertFontSize(60),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: convertFontSize(55),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontSize: convertFontSize(50),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      headline4: TextStyle(
        color: Colors.black,
        fontSize: convertFontSize(45),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      headline5: TextStyle(
        color: Colors.black,
        fontSize: convertFontSize(40),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: convertFontSize(35),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: convertFontSize(30),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      caption: TextStyle(
        color: Colors.black,
        fontSize: convertFontSize(25),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
    );
  }

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
  Color primaryColor = R.colors.greenHaze;

  @override
  Color scaffoldBackgroundColor = R.colors.gallery;

  @override
  Color secondaryColor = R.colors.skeptic;

  @override
  Color textColor = R.colors.white;

  @override
  Color inverseTextColor = R.colors.black;

  @override
  Color onPrimaryTextColor = R.colors.black;

  @override
  Color cardBackgroundColor = R.colors.white;

  @override
  Color appbarColor = R.colors.greenHaze;

  @override
  Color appbarTextColor = R.colors.white;

  @override
  Color appbarIconColor = R.colors.white;

  @override
  Color bottomMenuColor = R.colors.white;

  @override
  Color secondaryContainerColor = R.colors.skeptic;

  @override
  Color iconColor = R.colors.black;
}

class OneDoseDarkTheme extends IAppTheme {
  @override
  late TextTheme textTheme;

  @override
  Brightness brightness = Brightness.dark;

  OneDoseDarkTheme() {
    textTheme = TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: convertFontSize(60),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: convertFontSize(55),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: convertFontSize(50),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontSize: convertFontSize(45),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontSize: convertFontSize(40),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: convertFontSize(35),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontSize: convertFontSize(30),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
      caption: TextStyle(
        color: Colors.white,
        fontSize: convertFontSize(25),
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
    );
  }

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
  Color primaryColor = R.colors.greenHaze;

  @override
  Color scaffoldBackgroundColor = R.colors.codGray;

  @override
  Color secondaryColor = R.colors.skeptic;

  @override
  Color textColor = R.colors.black;

  @override
  Color inverseTextColor = R.colors.white;

  @override
  Color onPrimaryTextColor = R.colors.white;

  @override
  Color cardBackgroundColor = R.colors.mineShaft;

  @override
  Color appbarColor = R.colors.emperor;

  @override
  Color appbarTextColor = R.colors.white;

  @override
  Color appbarIconColor = R.colors.white;

  @override
  Color bottomMenuColor = R.colors.emperor;

  @override
  Color secondaryContainerColor = R.colors.emperor;

  @override
  Color iconColor = R.colors.white;
}
