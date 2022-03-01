import 'package:flutter/material.dart';

class ScaleColors {
  ScaleColors._();

  static ScaleColors? _instance;

  static ScaleColors get instance {
    _instance ??= ScaleColors._();
    return _instance!;
  }

  final grey = const Color(0xFF696969);
  final veryHigh = const Color(0xFFf4bb44);
  final high = const Color(0xFFf7ec57);
  final target = const Color(0xFF66c791);
  final low = const Color(0xFFe98884);
  final veryLow = const Color(0xFFe2605b);
}
