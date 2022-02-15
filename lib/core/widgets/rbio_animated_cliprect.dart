import 'package:flutter/material.dart';

class RbioAnimatedClipRect extends StatefulWidget {
  final Widget child;
  final bool open;
  final bool horizontalAnimation;
  final bool verticalAnimation;
  final Alignment alignment;
  final Duration? duration;
  final Duration? reverseDuration;
  final Curve curve;
  final Curve? reverseCurve;
  final AnimationBehavior animationBehavior;

  const RbioAnimatedClipRect({
    Key? key,
    required this.child,
    required this.open,
    this.horizontalAnimation = true,
    this.verticalAnimation = true,
    this.alignment = Alignment.center,
    this.duration,
    this.reverseDuration,
    this.curve = Curves.linear,
    this.reverseCurve,
    this.animationBehavior = AnimationBehavior.normal,
  }) : super(key: key);

  @override
  _RbioAnimatedClipRectState createState() => _RbioAnimatedClipRectState();
}

class _RbioAnimatedClipRectState extends State<RbioAnimatedClipRect>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: widget.duration ?? const Duration(milliseconds: 500),
      reverseDuration: widget.reverseDuration ??
          (widget.duration ?? const Duration(milliseconds: 500)),
      vsync: this,
      value: widget.open ? 1.0 : 0.0,
      animationBehavior: widget.animationBehavior,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve ?? widget.curve,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.open
        ? _animationController.forward()
        : _animationController.reverse();

    return ClipRect(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Align(
            alignment: widget.alignment,
            heightFactor: widget.verticalAnimation ? _animation.value : 1.0,
            widthFactor: widget.horizontalAnimation ? _animation.value : 1.0,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
