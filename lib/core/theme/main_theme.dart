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
}

class GreenTheme extends ITheme {
  @override
  ThemeType get type => ThemeType.Green;

  @override
  String get fontFamily => 'Poppins';

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
  Color get textColorPassive => Color.fromARGB(255, 187, 186, 186);

  @override
  TextTheme get textTheme => TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(60),
          fontWeight: FontWeight.normal,
        ),
        headline2: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(55),
          fontWeight: FontWeight.normal,
        ),
        headline3: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(50),
          fontWeight: FontWeight.normal,
        ),
        headline4: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(45),
          fontWeight: FontWeight.normal,
        ),
        headline5: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(40),
          fontWeight: FontWeight.normal,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(35),
          fontWeight: FontWeight.normal,
        ),
        bodyText2: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(30),
          fontWeight: FontWeight.normal,
        ),
        caption: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(25),
          fontWeight: FontWeight.normal,
        ),
      );

  double convertFontSize(double value) => value / 2.8;

  @override
  Color get cardBackgroundColor => GuvenColors.white;
}
