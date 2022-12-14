import 'package:flutter/material.dart';

import '../core.dart';

abstract class ITheme {
  ThemeType get type;
  String get fontFamily;
  Color get mainColor;
  Color get secondaryColor;
  Color get scaffoldBackgroundColor;
  Color get textColor;
  Color get textColorSecondary;
  Color get textColorPassive;
  TextTheme get textTheme;
  Color get cardBackgroundColor;
  Color get grey;
  Color get blackForItem;
  Color get iconColor;
  Color get iconSecondaryColor;
  Color get grayColor;
}

class GreenTheme extends ITheme {
  @override
  ThemeType get type => ThemeType.green;

  @override
  String get fontFamily => 'SourceSans';

  @override
  Color get mainColor => GuvenColors.green;

  @override
  Color get secondaryColor => GuvenColors.green2;

  @override
  Color get scaffoldBackgroundColor => const Color.fromARGB(255, 238, 238, 238);

  @override
  Color get textColor => Colors.white;

  @override
  Color get textColorSecondary => Colors.black;

  @override
  Color get textColorPassive => const Color.fromARGB(255, 187, 186, 186);

  @override
  Color get grey => Colors.grey;

  @override
  Color get cardBackgroundColor => GuvenColors.white;

  @override
  Color get blackForItem => Colors.black;

  @override
  Color get iconColor => Colors.black;

  @override
  Color get iconSecondaryColor => Colors.white;

  @override
  TextTheme get textTheme => TextTheme(
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

  double convertFontSize(double value) => value / 2.85;

  @override
  Color get grayColor => const Color.fromARGB(255, 237, 237, 237);
}

class BurgundyTheme extends ITheme {
  @override
  ThemeType get type => ThemeType.burgundy;

  @override
  String get fontFamily => 'SourceSans';

  @override
  Color get mainColor => GuvenColors.burgundy;

  @override
  Color get secondaryColor => GuvenColors.burgundy2;

  @override
  Color get scaffoldBackgroundColor => const Color.fromARGB(255, 238, 238, 238);

  @override
  Color get textColor => Colors.white;

  @override
  Color get textColorSecondary => Colors.black;

  @override
  Color get textColorPassive => const Color.fromARGB(255, 187, 186, 186);

  @override
  Color get grey => Colors.grey;

  @override
  Color get cardBackgroundColor => GuvenColors.white;

  @override
  Color get blackForItem => Colors.black;

  @override
  Color get iconColor => Colors.black;

  @override
  Color get iconSecondaryColor => Colors.white;

  @override
  TextTheme get textTheme => TextTheme(
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

  double convertFontSize(double value) => value / 2.85;

  @override
  Color get grayColor => const Color.fromARGB(255, 237, 237, 237);
}
