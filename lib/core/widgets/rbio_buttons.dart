import 'package:flutter/material.dart';

import '../core.dart';

// #region RbioElevatedButton
class RbioElevatedButton extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final VoidCallback onTap;
  final bool infinityWidth;
  final Color backColor;
  final Color textColor;
  final bool showElevation;
  final EdgeInsetsGeometry padding;

  const RbioElevatedButton({
    Key key,
    this.title,
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
          primary: backColor ?? getIt<ITheme>().mainColor,
          onSurface: backColor ?? getIt<ITheme>().mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          elevation: showElevation ? null : 0,
        ),
        child: Padding(
          padding: padding ?? defaultPadding(),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: context.xHeadline3.copyWith(
              color: textColor ?? getIt<ITheme>().textColor,
              fontWeight: fontWeight,
              fontSize: R.sizes.textScaleHandler<double>(
                context,
                small: context.xHeadline3.fontSize,
                medium: context.xHeadline4.fontSize,
                large: context.xHeadline5.fontSize,
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
