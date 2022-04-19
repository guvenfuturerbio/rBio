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
}
