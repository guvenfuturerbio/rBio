import 'package:flutter/material.dart';

import '../core.dart';

// #region RbioElevatedButton
class RbioElevatedButton extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final VoidCallback onTap;

  const RbioElevatedButton({
    Key key,
    this.title,
    this.onTap,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: getIt<ITheme>().mainColor,
        onSurface: getIt<ITheme>().mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
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
            color: getIt<ITheme>().textColor,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
// #endregion
