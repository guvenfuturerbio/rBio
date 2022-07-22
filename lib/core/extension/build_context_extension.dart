import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core.dart';

extension BuildContextThemeExtensions on BuildContext {
  TextScaleType get xTextScaleType => read<ThemeNotifier>().textScale;

  bool get xIsPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  MediaQueryData get xMediaQuery => MediaQuery.of(this);
  Color get xAccentColor => xAppTheme.colorScheme.secondary;

  MyCustomTheme get xAppColors => MyCustomTheme.of(this);
  AppBarTheme get xAppBarTheme => xAppTheme.appBarTheme;
  BottomNavigationBarThemeData get xBottomNavigationBarTheme => xAppTheme.bottomNavigationBarTheme;
  Color get xPrimaryColor => xAppTheme.primaryColor;
  Color get xTextColor => colorScheme.primary;
  Color get xSecondaryColor => colorScheme.secondary;
  Color get xTextInverseColor => colorScheme.inversePrimary;
  Color get xTextOnPrimaryColor => colorScheme.onPrimary;
  Color get xSecondaryContainerColor => colorScheme.secondaryContainer;
  Color? get xIconColor => iconTheme.color;
  Color get xCardColor => xAppTheme.cardTheme.color ?? Colors.transparent;

  // #region Size Extension
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get textScale => MediaQuery.of(this).textScaleFactor;
  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;
  // #endregion

  // #region Text Theme
  TextTheme get xTextTheme => xAppTheme.textTheme;
  TextStyle get xHeadline1 =>
      xAppTheme.textTheme.headline1 ?? const TextStyle();
  TextStyle get xHeadline2 =>
      xAppTheme.textTheme.headline2 ?? const TextStyle();
  TextStyle get xHeadline3 =>
      xAppTheme.textTheme.headline3 ?? const TextStyle();
  TextStyle get xHeadline4 =>
      xAppTheme.textTheme.headline4 ?? const TextStyle();

  TextStyle get xHeadline5 =>
      xAppTheme.textTheme.headline5 ?? const TextStyle();
  TextStyle get xHeadline6 =>
      xAppTheme.textTheme.headline6 ?? const TextStyle();
  TextStyle get xSubtitle1 =>
      xAppTheme.textTheme.subtitle1 ?? const TextStyle();
  TextStyle get xSubtitle2 =>
      xAppTheme.textTheme.subtitle2 ?? const TextStyle();
  TextStyle get xBodyText1 =>
      xAppTheme.textTheme.bodyText1 ?? const TextStyle();
  TextStyle get xBodyText2 =>
      xAppTheme.textTheme.bodyText2 ?? const TextStyle();
  TextStyle get xCaption => xAppTheme.textTheme.caption ?? const TextStyle();
  TextStyle get xButton => xAppTheme.textTheme.button ?? const TextStyle();
  TextStyle get xOverline => xAppTheme.textTheme.overline ?? const TextStyle();
  TextStyle get xBodyText1Error =>
      xAppTheme.textTheme.bodyText1?.copyWith(
        color: xAppColors.punch,
      ) ??
      const TextStyle();
  // #endregion

  // #region Color Scheme
  Color get scaffoldBackgroundColor => xAppTheme.scaffoldBackgroundColor;
  ColorScheme get colorScheme => xAppTheme.colorScheme;
  Color get primary => xAppTheme.colorScheme.primary;
  Color get primaryVariant => xAppTheme.colorScheme.primaryContainer;
  Color get secondary => xAppTheme.colorScheme.secondary;
  Color get secondaryVariant => xAppTheme.colorScheme.secondaryContainer;
  Color get surface => xAppTheme.colorScheme.surface;
  Color get background => xAppTheme.colorScheme.background;
  Color get error => xAppTheme.colorScheme.error;
  Color get onPrimary => xAppTheme.colorScheme.onPrimary;
  Color get onSecondary => xAppTheme.colorScheme.onSecondary;
  Color get onSurface => xAppTheme.colorScheme.onSurface;
  Color get onBackground => xAppTheme.colorScheme.onBackground;
  Color get onError => xAppTheme.colorScheme.onError;
  Brightness get brightness => xAppTheme.colorScheme.brightness;
  // #endregion

  ThemeData get xAppTheme => Theme.of(this);
  TargetPlatform get platform => xAppTheme.platform;
  IconThemeData get iconTheme => xAppTheme.iconTheme;
  MaterialColor get xRandomColor => Colors.primaries[Random().nextInt(17)];

  bool get xIsKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
  Brightness get xAppBrightness => MediaQuery.of(this).platformBrightness;
}
