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

  const RbioElevatedButton({
    Key key,
    this.title,
    this.onTap,
    this.fontWeight,
    this.infinityWidth = false,
    this.backColor,
    this.textColor,
    this.showElevation = true,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12.0,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: context.xHeadline3.copyWith(
              color: textColor ?? getIt<ITheme>().textColor,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
// #endregion
