part of 'app_config.dart';

abstract class IAppTheme {
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

  // Common
  Color get gray;
  Color get black;
  Color get white;
  Color get darkBlack;
  Color get darkWhite;
  Color get high;
  Color get veryHigh;
  Color get target;
  Color get low;
  Color get veryLow;
  Color get graphPlotRange;
  Color get stateColor;
  Color get bgGray;
  Color get chartGray;
  Color get darkRed;
  Color get graphRangeColor;
  Color get warning;
}
