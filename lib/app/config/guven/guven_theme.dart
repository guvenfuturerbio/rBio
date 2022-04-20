part of '../abstract/app_config.dart';

class GuvenTheme extends IAppTheme {
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

  @override
  // TODO: implement bgGray
  Color get bgGray => throw UnimplementedError();

  @override
  // TODO: implement black
  Color get black => throw UnimplementedError();

  @override
  // TODO: implement chartGray
  Color get chartGray => throw UnimplementedError();

  @override
  // TODO: implement darkBlack
  Color get darkBlack => throw UnimplementedError();

  @override
  // TODO: implement darkRed
  Color get darkRed => throw UnimplementedError();

  @override
  // TODO: implement darkWhite
  Color get darkWhite => throw UnimplementedError();

  @override
  // TODO: implement graphPlotRange
  Color get graphPlotRange => throw UnimplementedError();

  @override
  // TODO: implement graphRangeColor
  Color get graphRangeColor => throw UnimplementedError();

  @override
  // TODO: implement gray
  Color get gray => throw UnimplementedError();

  @override
  // TODO: implement high
  Color get high => throw UnimplementedError();

  @override
  // TODO: implement low
  Color get low => throw UnimplementedError();

  @override
  // TODO: implement stateColor
  Color get stateColor => throw UnimplementedError();

  @override
  // TODO: implement target
  Color get target => throw UnimplementedError();

  @override
  // TODO: implement veryHigh
  Color get veryHigh => throw UnimplementedError();

  @override
  // TODO: implement veryLow
  Color get veryLow => throw UnimplementedError();

  @override
  // TODO: implement warning
  Color get warning => throw UnimplementedError();

  @override
  // TODO: implement white
  Color get white => throw UnimplementedError();
}
