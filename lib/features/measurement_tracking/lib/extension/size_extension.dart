import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get HEIGHT => MediaQuery.of(this).size.height;
  double get WIDTH => MediaQuery.of(this).size.width;
  double get TEXTSCALE => MediaQuery.of(this).textScaleFactor;
  double get ASPECTRATIO => MediaQuery.of(this).size.aspectRatio;
}
