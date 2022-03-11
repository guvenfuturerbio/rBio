import 'package:flutter/material.dart';
import 'package:scale_api/scale_api.dart';
import 'package:scale_calculations/scale_calculations.dart';

class ScaleEntity {
  DateTime dateTime;

  double? weight;
  double? bmi;
  double? water;
  double? bodyFat;
  double? visceralFat;
  double? boneMass;
  double? muscle;
  int? age;
  int? height;
  int? gender;
  int? impedance;
  bool? weightStabilized;
  bool? measurementComplete;
  bool? weightRemoved;

  bool isManuel;
  ScaleUnit unit;
  String note;
  List<String> images;

  ScaleEntity({
    required this.dateTime,
    this.weight,
    this.bmi,
    this.water,
    this.bodyFat,
    this.visceralFat,
    this.boneMass,
    this.muscle,
    this.age,
    this.height,
    this.gender,
    this.impedance,
    this.weightStabilized,
    this.measurementComplete,
    this.weightRemoved,
    bool? isManuel,
    ScaleUnit? unit,
    String? note,
    List<String>? images,
  })  : isManuel = isManuel ?? false,
        unit = unit ?? ScaleUnit.kg,
        note = note ?? '',
        images = images ?? [];
}

extension ScaleEntityExtension on ScaleEntity {
  Color getColor(SelectedScaleType type) => ScaleColors.instance.getColor(
        type: type,
        bmi: bmi,
        weight: weight,
        bodyFat: bodyFat,
        boneMass: boneMass,
        water: water,
        visceralFat: visceralFat,
        muscle: muscle,
        gender: gender,
        weightTarget: ScaleRanges.instance.weightTarget(age!, height!),
        bodyFatTarget: ScaleRanges.instance.bodyFatTarget(age!),
      );

  double? getMeasurement(SelectedScaleType type) {
    switch (type) {
      case SelectedScaleType.bmi:
        return bmi;

      case SelectedScaleType.weight:
        return weight;

      case SelectedScaleType.bodyFat:
        return bodyFat;

      case SelectedScaleType.boneMass:
        return boneMass;

      case SelectedScaleType.water:
        return water;

      case SelectedScaleType.visceralFat:
        return visceralFat;

      case SelectedScaleType.muscle:
        return muscle;

      default:
        throw Exception('No related value as $type');
    }
  }

  void calculateVariables() {
    bmi = ScaleCalculate.instance.getBMI(
      weight: weight!,
      height: height!,
    );

    if (!isManuel) {
      visceralFat = ScaleCalculate.instance.getVisceralFat(
        weight: weight!,
        height: height!,
        age: age!,
        gender: gender!,
        impedance: impedance!,
      );
      if (impedance != null) {
        water = ScaleCalculate.instance.getWater(
          weight: weight!,
          height: height!,
          age: age!,
          gender: gender!,
          impedance: impedance!,
        );
        muscle = ScaleCalculate.instance.getMuscle(
          gender!,
          weight!,
          height!,
          age!,
          impedance!,
        );
        bodyFat = ScaleCalculate.instance.getBodyFat(
          weight!,
          height!,
          age!,
          gender!,
          impedance!,
        );
        boneMass = ScaleCalculate.instance.getBoneMass(
          gender!,
          weight!,
          height!,
          age!,
          impedance!,
        );
      }
    }
  }
}
