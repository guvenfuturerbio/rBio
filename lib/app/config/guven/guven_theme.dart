part of '../abstract/app_config.dart';

class GuvenTheme extends IAppTheme {
  @override
  late TextTheme textTheme;

  GuvenTheme() {
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
  String fontFamily = R.constants.fontPoppins;

  @override
  String appLogo = R.constants.guvenAppLogo;

  @override
  String successAppointmentImage = R.constants.guvenSuccessAppointmentImage;

  @override
  double appBarLogoHeight = 40;

  @override
  Color primaryColor = R.colors.burntUmber;

  @override
  Color scaffoldBackgroundColor = R.colors.gallery;

  @override
  Color secondaryColor = R.colors.coralTree;

  @override
  Color textColor = R.colors.white;

  @override
  Color inverseTextColor = R.colors.black;

  @override
  Color onPrimaryTextColor = R.colors.white;

  @override
  Color cardBackgroundColor = R.colors.white;

  @override
  Color appbarColor = R.colors.burntUmber;

  @override
  Color checkboxBorderColor = R.colors.burntUmber;

  @override
  Color bottomMenuColor = R.colors.white;

  @override
  Color secondaryBackColor = R.colors.coralTree;

  @override
  Color mainOverColor = R.colors.white;
}
