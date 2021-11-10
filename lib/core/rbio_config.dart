import 'dart:async';

import 'package:flutter/material.dart';

class RbioConfig extends InheritedWidget {
  final Widget child;

  final Orientation defaultOrientation = Orientation.portrait;
  StreamController<Orientation> orientationController =
      StreamController<Orientation>.broadcast();
  void changeOrientation(Orientation value) {
    orientationController.sink.add(value);
  }

  RbioConfig({
    Key key,
    @required this.child,
  }) : super(key: key, child: child);

  static RbioConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RbioConfig>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
