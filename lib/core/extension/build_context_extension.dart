import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../core.dart';
import '../theme/theme_cubit.dart';

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
  Color get xInverseCardColor => xScaffoldBackgroundColor;
  // #endregion

  // #region IconThemeData
  IconThemeData get xIconTheme => xAppTheme.iconTheme;
  Color? get xIconColor => xIconTheme.color;
  // #endregion

  // #region BottomNavigationBarThemeData
  BottomNavigationBarThemeData get xBottomNavigationBarTheme =>
      xAppTheme.bottomNavigationBarTheme;
  // #endregion

  // #region DialogTheme
  AppDialogTheme get xDialogTheme => read<ThemeCubit>().state.dialogTheme;
  // #endregion

  // #region MyCustomTheme
  MyCustomTheme get xMyCustomTheme => MyCustomTheme.of(this);
  IAppTheme get xCurrentTheme => read<ThemeCubit>().state;
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

extension BuildContextScrollPhysicsExtensions on BuildContext {
  ScrollPhysics get xNeverScroll => const NeverScrollableScrollPhysics();
  ScrollPhysics get xBouncingScroll => const BouncingScrollPhysics();
  ScrollPhysics get xClampingScroll => const ClampingScrollPhysics();
  ScrollPhysics get xFixedExtentScroll => const FixedExtentScrollPhysics();
  ScrollPhysics get xAlwaysScroll => const AlwaysScrollableScrollPhysics();
  ScrollPhysics get xBouncingAlwaysScroll => const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      );
}
