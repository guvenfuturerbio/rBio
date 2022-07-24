import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../core.dart';

extension BuildContextThemeExtensions on BuildContext {
  TextScaleType get xTextScaleType => read<ThemeNotifier>().textScale;

  // #region MediaQueryData
  MediaQueryData get xMediaQuery => MediaQuery.of(this);
  double get height => xMediaQuery.size.height;
  double get width => xMediaQuery.size.width;
  double get textScale => xMediaQuery.textScaleFactor;
  double get aspectRatio => xMediaQuery.size.aspectRatio;
  bool get xIsKeyBoardOpen => xMediaQuery.viewInsets.bottom > 0;
  Brightness get xAppBrightness => xMediaQuery.platformBrightness;
  bool get xIsPortrait => xMediaQuery.orientation == Orientation.portrait;
  // #endregion

  // #region ThemeData
  ThemeData get xAppTheme => Theme.of(this);
  Color get xPrimaryColor => xAppTheme.primaryColor;
  // #endregion

  // #region AppBarTheme
  AppBarTheme get xAppBarTheme => xAppTheme.appBarTheme;
  // #endregion

  // #region CardTheme
  CardTheme get xCardTheme => xAppTheme.cardTheme;
  Color get xCardColor => xCardTheme.color ?? Colors.transparent;
  // #endregion

  // #region IconThemeData
  IconThemeData get xIconTheme => xAppTheme.iconTheme;
  Color? get xIconColor => xIconTheme.color;
  // #endregion

  // #region BottomNavigationBarThemeData
  BottomNavigationBarThemeData get xBottomNavigationBarTheme =>
      xAppTheme.bottomNavigationBarTheme;
  // #endregion

  // #region MyCustomTheme
  MyCustomTheme get xMyCustomTheme => MyCustomTheme.of(this);
  // #endregion

  // #region TextTheme
  TextTheme get xTextTheme => xAppTheme.textTheme;
  TextStyle get xHeadline1 => xTextTheme.headline1 ?? const TextStyle();
  TextStyle get xHeadline2 => xTextTheme.headline2 ?? const TextStyle();
  TextStyle get xHeadline3 => xTextTheme.headline3 ?? const TextStyle();
  TextStyle get xHeadline4 => xTextTheme.headline4 ?? const TextStyle();
  TextStyle get xHeadline5 => xTextTheme.headline5 ?? const TextStyle();
  TextStyle get xSubtitle1 => xTextTheme.subtitle1 ?? const TextStyle();
  TextStyle get xBodyText1 => xTextTheme.bodyText1 ?? const TextStyle();
  TextStyle get xBodyText2 => xTextTheme.bodyText2 ?? const TextStyle();
  TextStyle get xCaption => xAppTheme.textTheme.caption ?? const TextStyle();
  TextStyle get xButton => xAppTheme.textTheme.button ?? const TextStyle();
  TextStyle get xBodyText1Error =>
      xAppTheme.textTheme.bodyText1?.copyWith(color: xMyCustomTheme.punch) ??
      const TextStyle();
  // #endregion

  // #region ColorScheme
  Color get xScaffoldBackgroundColor => xAppTheme.scaffoldBackgroundColor;
  ColorScheme get colorScheme => xAppTheme.colorScheme;
  Color get xTextColor => colorScheme.primary;
  Color get xSecondaryColor => colorScheme.secondary;
  Color get xTextInverseColor => colorScheme.inversePrimary;
  Color get xTextOnPrimaryColor => colorScheme.onPrimary;
  Color get xSecondaryContainerColor => colorScheme.secondaryContainer;
  // #endregion

  MaterialColor get xRandomColor => Colors.primaries[Random().nextInt(17)];
}
