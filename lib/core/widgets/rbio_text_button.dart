import 'package:flutter/material.dart';

import '../core.dart';

class RbioTextButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;

  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;
  final OutlinedBorder? shape;

  const RbioTextButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.padding,
    this.tapTargetSize,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.transparent,
        primary: getIt<ITheme>().textColorSecondary,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 22.0),
        tapTargetSize: tapTargetSize,
        shape: shape,
      ),
    );
  }
}
