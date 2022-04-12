import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class ScaleExpansionModel {
  final String title;
  final String value;
  final String description;
  final DynamicColorfulRangeModel model;

  ScaleExpansionModel({
    required this.title,
    required this.value,
    required this.description,
    required this.model,
  });

  static List<ScaleExpansionModel> list1 = [
    //
    ScaleExpansionModel(
      title: LocaleProvider.current.protein,
      value: '% 15,0',
      description:
          'Olması gereken değere gelinmesi için Bengisu hocadan alınacak kısa bir neler yapılabilir açıklaması yazılacak.',
      model: DynamicColorfulRangeModel(
        minValue: 8.0,
        maxValue: 32.0,
        currentValue: 15.0,
        breakpoints: const [
          16.0,
          20.0,
        ],
        titles: [
          LocaleProvider.current.insufficient,
          LocaleProvider.current.normal,
          LocaleProvider.current.great,
        ],
        colors: [
          R.color.darkRed,
          R.color.target,
          getIt<ITheme>().mainColor,
        ],
      ),
    ),

    //
    ScaleExpansionModel(
      title: LocaleProvider.current.basal_metabolism,
      value: '1266 kcal',
      description:
          'Olması gereken değere gelinmesi için Bengisu hocadan alınacak kısa bir neler yapılabilir açıklaması yazılacak.',
      model: DynamicColorfulRangeModel(
        minValue: 0,
        maxValue: 2600,
        currentValue: 1305,
        breakpoints: const [
          1306,
        ],
        titles: [
          LocaleProvider.current.didnt_reach_goals,
          LocaleProvider.current.reach_goal,
        ],
        colors: [
          R.color.darkRed,
          getIt<ITheme>().mainColor,
        ],
      ),
    ),
  ];

  static List<ScaleExpansionModel> list2 = [
    //
    ScaleExpansionModel(
      title: LocaleProvider.current.scale_data_body_fat,
      value: '%32',
      description: '',
      model: DynamicColorfulRangeModel(
        minValue: 10.0,
        maxValue: 50.0,
        currentValue: 32.0,
        breakpoints: const [
          21.0,
          28.0,
          35.0,
          40.0,
        ],
        titles: [
          LocaleProvider.current.very_low,
          LocaleProvider.current.low,
          LocaleProvider.current.normal,
          LocaleProvider.current.high,
          LocaleProvider.current.very_high,
        ],
        colors: [
          R.color.darkRed,
          R.color.very_low,
          R.color.target,
          R.color.high,
          R.color.very_high,
        ],
      ),
    ),

    //
    ScaleExpansionModel(
      title: LocaleProvider.current.scale_data_bmi,
      value: '23,1',
      description: '',
      model: DynamicColorfulRangeModel(
        minValue: 10.0,
        maxValue: 40.0,
        currentValue: 23.1,
        breakpoints: const [
          18.5,
          25.0,
          28.0,
          32.0,
        ],
        titles: [
          LocaleProvider.current.low,
          LocaleProvider.current.normal,
          LocaleProvider.current.increased,
          LocaleProvider.current.high,
          LocaleProvider.current.very_high,
        ],
        colors: [
          R.color.darkRed,
          R.color.target,
          getIt<ITheme>().mainColor,
          R.color.high,
          R.color.very_high,
        ],
      ),
    ),

    //
    ScaleExpansionModel(
      title: LocaleProvider.current.scale_data_muscle,
      value: '38,5 kg',
      description: '',
      model: DynamicColorfulRangeModel(
        minValue: 20.0,
        maxValue: 60.0,
        currentValue: 38.5,
        breakpoints: const [
          36.5,
          42.6,
        ],
        titles: [
          LocaleProvider.current.insufficient,
          LocaleProvider.current.normal,
          LocaleProvider.current.great,
        ],
        colors: [
          R.color.darkRed,
          R.color.target,
          getIt<ITheme>().mainColor,
        ],
      ),
    ),

    //
    ScaleExpansionModel(
      title: LocaleProvider.current.scale_data_water,
      value: '%47,6',
      description: '',
      model: DynamicColorfulRangeModel(
        minValue: 20.0,
        maxValue: 80.0,
        currentValue: 47.6,
        breakpoints: const [
          45.0,
          60.1,
        ],
        titles: [
          LocaleProvider.current.insufficient,
          LocaleProvider.current.normal,
          LocaleProvider.current.great,
        ],
        colors: [
          R.color.darkRed,
          R.color.target,
          getIt<ITheme>().mainColor,
        ],
      ),
    ),

    //
    ScaleExpansionModel(
      title: LocaleProvider.current.scale_data_visceral_fat,
      value: '5',
      description: '',
      model: DynamicColorfulRangeModel(
        minValue: 0.0,
        maxValue: 20.0,
        currentValue: 5,
        breakpoints: const [
          10,
          15,
        ],
        titles: [
          LocaleProvider.current.normal,
          LocaleProvider.current.increased,
          LocaleProvider.current.high,
        ],
        colors: [
          R.color.target,
          R.color.high,
          R.color.very_high,
        ],
      ),
    ),

    //
    ScaleExpansionModel(
      title: LocaleProvider.current.scale_data_bone_mass,
      value: '2,5 kg',
      description: '',
      model: DynamicColorfulRangeModel(
        minValue: 0.0,
        maxValue: 5.0,
        currentValue: 2.5,
        breakpoints: const [
          1.8,
          3.9,
        ],
        titles: [
          LocaleProvider.current.insufficient,
          LocaleProvider.current.normal,
          LocaleProvider.current.great,
        ],
        colors: [
          R.color.darkRed,
          R.color.target,
          getIt<ITheme>().mainColor,
        ],
      ),
    ),
  ];
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
