import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

class RbioRedButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool infinityWidth;

  const RbioRedButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.infinityWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioElevatedButton(
      title: title,
      onTap: onTap,
      fontWeight: FontWeight.bold,
      textColor: getIt<IAppConfig>().theme.textColor,
      backColor: getIt<IAppConfig>().theme.darkRed,
      infinityWidth: infinityWidth,
    );
  }
}

class RbioWhiteButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool infinityWidth;

  const RbioWhiteButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.infinityWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioElevatedButton(
      title: title,
      onTap: onTap,
      fontWeight: FontWeight.bold,
      textColor: getIt<IAppConfig>().theme.textColorSecondary,
      backColor: Colors.white,
      infinityWidth: infinityWidth,
    );
  }
}

// #region RbioElevatedButton
class RbioElevatedButton extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final void Function()? onTap;
  final bool infinityWidth;
  final Color? backColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const RbioElevatedButton({
    Key? key,
    required this.title,
    this.onTap,
    this.fontWeight,
    this.infinityWidth = false,
    this.backColor,
    this.textColor,
    this.padding,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: infinityWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: backColor ?? getIt<IAppConfig>().theme.mainColor,
          onSurface: backColor ?? getIt<IAppConfig>().theme.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(50.0),
          ),
          elevation: null,
        ),
        child: Padding(
          padding: padding ?? defaultPadding(),
          child: FittedBox(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: context.xHeadline3.copyWith(
                color: textColor ?? getIt<IAppConfig>().theme.textColor,
                fontWeight: fontWeight,
                fontSize: R.sizes.textScaleHandler<double>(
                  context,
                  small: context.xHeadline3.fontSize ?? 24,
                  medium: context.xHeadline4.fontSize ?? 24,
                  large: context.xHeadline5.fontSize ?? 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static EdgeInsets defaultPadding() => const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 12.0,
      );

  static EdgeInsets minPadding() => const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 5.0,
      );
}
// #endregion

class RbioElevatedAutoButton extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final void Function()? onTap;
  final bool infinityWidth;
  final Color? backColor;
  final Color? textColor;
  final bool showElevation;
  final EdgeInsetsGeometry? padding;

  const RbioElevatedAutoButton({
    Key? key,
    required this.title,
    this.onTap,
    this.fontWeight,
    this.infinityWidth = false,
    this.backColor,
    this.textColor,
    this.showElevation = true,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: infinityWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: backColor ?? getIt<IAppConfig>().theme.mainColor,
          onSurface: backColor ?? getIt<IAppConfig>().theme.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          elevation: showElevation ? null : 0,
        ),
        child: Padding(
          padding: padding ?? defaultPadding(),
          child: AutoSizeText(
            title,
            textAlign: TextAlign.center,
            maxFontSize: 8,
            minFontSize: 8,
            style: context.xHeadline3.copyWith(
              color: textColor ?? getIt<IAppConfig>().theme.textColor,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }

  static EdgeInsets defaultPadding() => const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 12.0,
      );

  static EdgeInsets minPadding() => const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 5.0,
      );
}
// #endregion

class RbioIconButton extends StatelessWidget {
  final void Function() onPressed;
  final bool infinityWidth;
  final SvgPicture icon;
  final Color? color;
  final double? iconSize;

  final Color? backColor;
  final Color? textColor;
  final bool showElevation;

  const RbioIconButton({
    Key? key,
    required this.onPressed,
    this.infinityWidth = false,
    required this.icon,
    this.color,
    this.iconSize,
    this.backColor,
    this.textColor,
    this.showElevation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backColor ?? getIt<IAppConfig>().theme.mainColor, shape: BoxShape.circle),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: backColor ?? getIt<IAppConfig>().theme.mainColor,
        iconSize: iconSize,
      ),
    );
  }

  static EdgeInsets defaultPadding() => const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 12.0,
      );

  static EdgeInsets minPadding() => const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 5.0,
      );
}
