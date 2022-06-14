import 'dart:async';

import 'package:flutter/material.dart';

abstract class IAtomOverlay {
  Widget? w;
  OverlayEntry? overlayEntry;
}

class AtomOverlay extends StatefulWidget {
  final Widget? backgroundChild;
  final IAtomOverlay baseOverlay;

  const AtomOverlay({
    Key? key,
    this.backgroundChild,
    required this.baseOverlay,
  }) : super(key: key);

  @override
  _AtomOverlayState createState() => _AtomOverlayState();
}

class _AtomOverlayState extends State<AtomOverlay> {
  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => widget.baseOverlay.w ?? Container(),
    );

    widget.baseOverlay.overlayEntry = _overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (BuildContext context) => widget.backgroundChild ?? const SizedBox(),
          ),
          _overlayEntry,
        ],
      ),
    );
  }
}

class AtomOverlayChild extends StatefulWidget {
  final bool animation;
  final Widget child;

  const AtomOverlayChild({
    Key? key,
    required this.child,
    this.animation = true,
  }) : super(key: key);

  @override
  AtomOverlayChildState createState() => AtomOverlayChildState();
}

class AtomOverlayChildState extends State<AtomOverlayChild> {
  double _opacity = 0.0;
  late Duration _animationDuration;

  @override
  void initState() {
    super.initState();

    if (!mounted) return;

    _animationDuration = widget.animation
        ? const Duration(milliseconds: 300)
        : const Duration(milliseconds: 0);

    if (widget.animation) {
      Future.delayed(const Duration(milliseconds: 30), () {
        if (mounted) {
          setState(() {
            _opacity = 1.0;
          });
        }
      });
    } else {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void dismiss(Completer completer) {
    _animationDuration = const Duration(milliseconds: 300);

    if (mounted) {
      setState(() {
        _opacity = 0.0;
      });
    }

    Future.delayed(_animationDuration, () {
      completer.complete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: _animationDuration,
      child: widget.child,
    );
  }
}
