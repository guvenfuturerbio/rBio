import 'package:flutter/material.dart';

import '../core.dart';

abstract class ITheme {
  ThemeType get type;
  String get fontFamily;
  Color get mainColor;
  Color get scaffoldBackgroundColor;
}

class GreenTheme extends ITheme {
  @override
  ThemeType get type => ThemeType.Green;

  @override
  String get fontFamily => 'Poppins';

  @override
  Color get mainColor => const Color.fromARGB(255, 70, 155, 81);

  @override
  Color get scaffoldBackgroundColor => const Color.fromARGB(255, 238, 238, 238);
}
