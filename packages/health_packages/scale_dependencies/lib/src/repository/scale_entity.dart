import 'package:flutter/material.dart';

import '../../scale_dependencies.dart';

class ScaleEntity {
  DateTime dateTime;
  int? measurementId;
  int? entegrationId;

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

  bool isManuel;
  ScaleUnit unit;
  String note;
  bool? weightStabilized;
  bool? measurementComplete;
  bool? weightRemoved;

  String? deviceId;
  double? bmh;

  ScaleEntity({
    required this.dateTime,
    this.measurementId,
    this.entegrationId,
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
    this.deviceId,
    this.bmh,
    bool? isManuel,
    ScaleUnit? unit,
    String? note,
    this.weightStabilized,
    this.measurementComplete,
    this.weightRemoved,
  })  : isManuel = isManuel ?? false,
        unit = unit ?? ScaleUnit.kg,
        note = note ?? '';

  ScaleEntity copy() {
    return ScaleEntity(
      dateTime: dateTime,
      entegrationId: entegrationId,
      measurementId: measurementId,
      age: age,
      bmi: bmi,
      bodyFat: bodyFat,
      boneMass: boneMass,
      gender: gender,
      height: height,
      impedance: impedance,
      isManuel: isManuel,
      muscle: muscle,
      note: note,
      unit: unit,
      visceralFat: visceralFat,
      water: water,
      weight: weight,
      measurementComplete: measurementComplete,
      weightRemoved: weightRemoved,
      weightStabilized: weightStabilized,
      deviceId: deviceId,
      bmh: bmh,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScaleEntity &&
        other.dateTime == dateTime &&
        other.measurementId == measurementId &&
        other.entegrationId == entegrationId &&
        other.weight == weight &&
        other.bmi == bmi &&
        other.water == water &&
        other.bodyFat == bodyFat &&
        other.visceralFat == visceralFat &&
        other.boneMass == boneMass &&
        other.muscle == muscle &&
        other.age == age &&
        other.height == height &&
        other.gender == gender &&
        other.impedance == impedance &&
        other.isManuel == isManuel &&
        other.unit == unit &&
        other.note == note &&
        other.weightStabilized == weightStabilized &&
        other.measurementComplete == measurementComplete &&
        other.weightRemoved == weightRemoved &&
        other.deviceId == deviceId &&
        other.bmh == bmh;
  }

  @override
  int get hashCode {
    return dateTime.hashCode ^
        measurementId.hashCode ^
        entegrationId.hashCode ^
        weight.hashCode ^
        bmi.hashCode ^
        water.hashCode ^
        bodyFat.hashCode ^
        visceralFat.hashCode ^
        boneMass.hashCode ^
        muscle.hashCode ^
        age.hashCode ^
        height.hashCode ^
        gender.hashCode ^
        impedance.hashCode ^
        isManuel.hashCode ^
        unit.hashCode ^
        note.hashCode ^
        weightStabilized.hashCode ^
        measurementComplete.hashCode ^
        weightRemoved.hashCode ^
        deviceId.hashCode ^
        bmh.hashCode;
  }
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

  String get getUnit {
    switch (unit) {
      case ScaleUnit.kg:
        return 'kg';

      case ScaleUnit.lbs:
        return 'lbs';

      default:
        throw Exception('Unit has not defined');
    }
  }
}
