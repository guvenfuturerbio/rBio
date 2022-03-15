import 'dart:ui';

import 'package:scale_calculations/scale_calculations.dart';

import '../../scale_api.dart';

class ScaleMeasurementLogic {
  final ScaleModel scaleModel;
  ScaleMeasurementLogic({required this.scaleModel});

  double? get weight => scaleModel.weight;

  set weight(double? rhs) => scaleModel.weight = rhs;

  double? get bmi => scaleModel.bmi;

  set bmi(double? rhs) => scaleModel.bmi = rhs;

  double? get water => scaleModel.water;

  set water(double? rhs) => scaleModel.water = rhs;

  double? get bodyFat => scaleModel.bodyFat;

  set bodyFat(double? rhs) => scaleModel.bodyFat = rhs;

  double? get visceralFat => scaleModel.visceralFat;

  set visceralFat(double? rhs) => scaleModel.visceralFat = rhs;

  double? get boneMass => scaleModel.boneMass;

  set boneMass(double? rhs) => scaleModel.boneMass = rhs;

  double? get muscle => scaleModel.muscle;

  set muscle(double? rhs) => scaleModel.muscle = rhs;

  int? get age => scaleModel.age;

  set age(int? rhs) => scaleModel.age = (DateTime.now().year - (rhs ?? 0));

  DateTime get dateTime => scaleModel.dateTime;

  set dateTime(DateTime rhs) => scaleModel.dateTime = rhs;

  List<String> get images => scaleModel.images ?? [];

  set images(List<String> rhs) => scaleModel.images = rhs;

  String get note => scaleModel.note ?? '';

  set note(String rhs) => scaleModel.note = rhs;

  bool get isManuel => scaleModel.isManuel ?? false;

  int? get height => scaleModel.height;

  int? get gender => scaleModel.gender;

  ScaleUnit get unit => scaleModel.unit ?? ScaleUnit.kg;
}

extension BaseScaleModelExtension on ScaleMeasurementLogic {
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
        impedance: scaleModel.impedance!,
      );
      if (scaleModel.impedance != null) {
        water = ScaleCalculate.instance.getWater(
          weight: weight!,
          height: height!,
          age: age!,
          gender: gender!,
          impedance: scaleModel.impedance!,
        );
        muscle = ScaleCalculate.instance.getMuscle(
          gender!,
          weight!,
          height!,
          age!,
          scaleModel.impedance!,
        );
        bodyFat = ScaleCalculate.instance.getBodyFat(
          weight!,
          height!,
          age!,
          gender!,
          scaleModel.impedance!,
        );
        boneMass = ScaleCalculate.instance.getBoneMass(
          gender!,
          weight!,
          height!,
          age!,
          scaleModel.impedance!,
        );
      }
    }
  }
}
