import 'package:flutter/material.dart';

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void waitForScreen(VoidCallback onComplete) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onComplete.call();
    });
  }
}
