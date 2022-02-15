import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core.dart';

extension BuildContextThemeExtensions on BuildContext {
  TextScaleType get xTextScaleType => read<ThemeNotifier>().textScale;

  MediaQueryData get xMediaQuery => MediaQuery.of(this);
  Color get xAccentColor => Theme.of(this).colorScheme.secondary;

  // #region Size Extension
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get textScale => MediaQuery.of(this).textScaleFactor;
  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;
  // #endregion

  // #region Text Theme
  TextTheme get xTextTheme => Theme.of(this).textTheme;
  TextStyle get xHeadline1 =>
      Theme.of(this).textTheme.headline1 ?? const TextStyle();
  TextStyle get xHeadline2 =>
      Theme.of(this).textTheme.headline2 ?? const TextStyle();
  TextStyle get xHeadline3 =>
      Theme.of(this).textTheme.headline3 ?? const TextStyle();
  TextStyle get xHeadline4 =>
      Theme.of(this).textTheme.headline4 ?? const TextStyle();

  TextStyle get xHeadline5 =>
      Theme.of(this).textTheme.headline5 ?? const TextStyle();
  TextStyle get xHeadline6 =>
      Theme.of(this).textTheme.headline6 ?? const TextStyle();
  TextStyle get xSubtitle1 =>
      Theme.of(this).textTheme.subtitle1 ?? const TextStyle();
  TextStyle get xSubtitle2 =>
      Theme.of(this).textTheme.subtitle2 ?? const TextStyle();
  TextStyle get xBodyText1 =>
      Theme.of(this).textTheme.bodyText1 ?? const TextStyle();
  TextStyle get xBodyText2 =>
      Theme.of(this).textTheme.bodyText2 ?? const TextStyle();
  TextStyle get xCaption =>
      Theme.of(this).textTheme.caption ?? const TextStyle();
  TextStyle get xButton => Theme.of(this).textTheme.button ?? const TextStyle();
  TextStyle get xOverline =>
      Theme.of(this).textTheme.overline ?? const TextStyle();
  // #endregion

  // #region Color Scheme
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Color get primary => Theme.of(this).colorScheme.primary;
  Color get primaryVariant => Theme.of(this).colorScheme.primaryVariant;
  Color get secondary => Theme.of(this).colorScheme.secondary;
  Color get secondaryVariant => Theme.of(this).colorScheme.secondaryVariant;
  Color get surface => Theme.of(this).colorScheme.surface;
  Color get background => Theme.of(this).colorScheme.background;
  Color get error => Theme.of(this).colorScheme.error;
  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;
  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;
  Color get onSurface => Theme.of(this).colorScheme.onSurface;
  Color get onBackground => Theme.of(this).colorScheme.onBackground;
  Color get onError => Theme.of(this).colorScheme.onError;
  Brightness get brightness => Theme.of(this).colorScheme.brightness;
  // #endregion

  ThemeData get xAppTheme => Theme.of(this);
  TargetPlatform get platform => Theme.of(this).platform;
  IconThemeData get iconTheme => Theme.of(this).iconTheme;
  MaterialColor get xRandomColor => Colors.primaries[Random().nextInt(17)];

  bool get xIsKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
  Brightness get xAppBrightness => MediaQuery.of(this).platformBrightness;
}
