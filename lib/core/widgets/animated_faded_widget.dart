import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedFadedWidget extends StatefulWidget {
  final Widget child;

  const AnimatedFadedWidget({Key? key, required this.child}) : super(key: key);

  @override
  _AnimatedFadedWidgetState createState() => _AnimatedFadedWidgetState();
}

class _AnimatedFadedWidgetState extends State<AnimatedFadedWidget> {
  bool isShow = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (mounted) {
          setState(() {
            isShow = !isShow;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isShow ? 1.0 : 0.0,
      duration: Duration(seconds: 1),
      child: widget.child,
    );
  }
}
