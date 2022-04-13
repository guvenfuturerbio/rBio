import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class ScaleExpansionModel {
  final String title;
  final String value;
  final String description;
  final SelectedScaleType type;
  final DynamicColorfulRangeModel model;

  ScaleExpansionModel({
    required this.title,
    required this.value,
    required this.description,
    required this.type,
    required this.model,
  });
}

class DynamicColorfulRangeModel {
  final List<double> breakpoints;
  final List<String> titles;
  final List<Color> colors;
  final double minValue;
  final double maxValue;
  final double currentValue;

  DynamicColorfulRangeModel({
    required this.breakpoints,
    required this.titles,
    required this.colors,
    required this.minValue,
    required this.maxValue,
    required this.currentValue,
  });
}
