import 'package:flutter/material.dart';

class RbioScrollbar extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  final bool? isAlwaysShown;
  final bool? showTrackOnHover;
  final double? hoverThickness;
  final double? thickness;
  final Radius? radius;
  final bool Function(ScrollNotification)? notificationPredicate;
  final bool? interactive;
  final ScrollbarOrientation? scrollbarOrientation;

  const RbioScrollbar({
    Key? key,
    required this.child,
    this.controller,
    this.isAlwaysShown,
    this.showTrackOnHover,
    this.hoverThickness,
    this.thickness,
    this.radius,
    this.notificationPredicate,
    this.interactive,
    this.scrollbarOrientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: Scrollbar(
        controller: controller,
        hoverThickness: hoverThickness,
        interactive: interactive,
        isAlwaysShown: isAlwaysShown,
        notificationPredicate: notificationPredicate,
        scrollbarOrientation: scrollbarOrientation,
        radius: radius,
        showTrackOnHover: showTrackOnHover,
        thickness: thickness,
        child: child,
      ),
    );
  }
}
