import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

class RbioSVGFAB extends StatelessWidget {
  final String imagePath;
  final void Function()? onPressed;
  final double? elevation;
  final Color? iconColor;

  const RbioSVGFAB({
    Key? key,
    required this.imagePath,
    this.onPressed,
    this.elevation,
    required this.iconColor,
  }) : super(key: key);

  factory RbioSVGFAB.primaryColor(
    BuildContext context, {
    required String imagePath,
    void Function()? onPressed,
    double? elevation,
  }) {
    return RbioSVGFAB(
      imagePath: imagePath,
      onPressed: onPressed,
      elevation: elevation,
      iconColor: context.xAppColors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _RbioFloatingActionButton(
      backgroundColor: context.xPrimaryColor,
      child: SvgPicture.asset(
        imagePath,
        color: iconColor,
        width: R.sizes.iconSize,
      ),
      onPressed: onPressed,
      elevation: elevation,
    );
  }
}

class RbioIconsFAB extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final double? elevation;

  const RbioIconsFAB({
    Key? key,
    required this.icon,
    this.onPressed,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _RbioFloatingActionButton(
      child: Icon(
        icon,
        size: R.sizes.iconSize,
        color: context.xAppColors.white,
      ),
      onPressed: onPressed,
      elevation: elevation,
    );
  }
}

class _RbioFloatingActionButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final void Function()? onPressed;
  final double? elevation;

  const _RbioFloatingActionButton({
    Key? key,
    this.backgroundColor,
    required this.child,
    required this.onPressed,
    required this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      child: child,
      elevation: elevation,
    );
  }
}
