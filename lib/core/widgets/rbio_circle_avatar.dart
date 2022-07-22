import 'package:flutter/material.dart';

class RbioCircleAvatar extends StatelessWidget {
  final Widget? child;
  final double? radius;
  final Color? backgroundColor;
  final ImageProvider<Object>? backgroundImage;
  final ImageProvider<Object>? foregroundImage;

  const RbioCircleAvatar({
    Key? key,
    this.child,
    this.radius,
    this.backgroundColor,
    this.backgroundImage,
    this.foregroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: child,
      radius: radius,
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      foregroundImage: foregroundImage,
    );
  }
}
