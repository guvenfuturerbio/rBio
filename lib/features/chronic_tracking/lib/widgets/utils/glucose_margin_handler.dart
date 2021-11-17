import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlucoseMarginHandler with ChangeNotifier {
  static final GlucoseMarginHandler _instance = GlucoseMarginHandler._internal();

  factory GlucoseMarginHandler() {
    return _instance;
  }

  static const DEFAULT_VERY_LOW = 35;
  static const DEFAULT_LOW = 90;
  static const DEFAULT_TARGET = 130;
  static const DEFAULT_HIGH = 150;
  static const DEFAULT_VERY_HIGH = 300;

  GlucoseMarginHandler._internal() {
  }


}