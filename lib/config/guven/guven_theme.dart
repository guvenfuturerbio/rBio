part of '../abstract/app_config.dart';

class GuvenTheme extends IAppTheme {
  @override
  late TextTheme textTheme;

  @override
  Brightness brightness = Brightness.light;

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
  Color appbarTextColor = R.colors.white;

  @override
  Color appbarIconColor = R.colors.white;

  @override
  BottomNavigationBarThemeData bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    backgroundColor: R.colors.white,
  );

  @override
  Color secondaryContainerColor = R.colors.coralTree;

  @override
  IconThemeData iconTheme = IconThemeData(
    color: R.colors.black,
  );

  @override
  AppSelectionTheme get selectionTheme => GuvenSelectionTheme();
}

class GuvenSelectionTheme extends GuvenTheme implements AppSelectionTheme {
  @override
  Color get unSelectedBackColor => cardBackgroundColor;

  @override
  Color get unSelectedIconColor => iconTheme.color ?? Colors.transparent;

  @override
  Color get unSelectedTextColor => inverseTextColor;

  @override
  Color get selectedBackColor => primaryColor;

  @override
  Color get selectedIconColor => R.colors.white;

  @override
  Color get selectedTextColor => R.colors.white;
}
