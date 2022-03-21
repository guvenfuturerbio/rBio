import 'package:scale_api/scale_api.dart';
import 'package:scale_calculations/scale_calculations.dart';
import 'package:scale_repository/scale_repository.dart';

class MiScaleModel {
  int? impedance;

  /// ID of the device this data was parsed from.
  Map<String, dynamic>? device;

  /// Value is `true` if the weight has stabilized.
  bool? weightStabilized;

  /// Value is `true` if the device is done measuring.
  /// This value is usually given after other measurements (such as body fat) have been completed as well.
  bool? measurementComplete;

  /// Value is `true` if there is no weight detected.
  bool? weightRemoved;

  double? weight;

  ScaleUnit? unit;

  DateTime? dateTime;

  MiScaleModel({
    required this.dateTime,
    this.device,
    this.weight,
    this.weightStabilized,
    this.measurementComplete,
    this.weightRemoved,
    this.unit,
    this.impedance,
  });
}

extension MiScaleModelExtension on MiScaleModel {
  ScaleEntity xGetEntity(int age, int height, int gender) {
    return ScaleEntity(
      dateTime: dateTime!,
      age: age,
      gender: gender,
      height: height,
      impedance: impedance,
      isManuel: false,
      measurementComplete: measurementComplete,
      unit: unit,
      weight: weight,
      weightRemoved: weightRemoved,
      weightStabilized: weightStabilized,
      deviceId: device?['deviceId'] ?? 'manual',
    );
  }

  ScaleEntity xGetEntityWithCalculate(int age, int height, int gender) {
    return ScaleEntity(
      dateTime: dateTime!,
      age: age,
      bmi: ScaleCalculate.instance.getBMI(
        weight: weight!,
        height: height,
      ),
      bodyFat: ScaleCalculate.instance.getBodyFat(
        weight!,
        height,
        age,
        gender,
        impedance!,
      ),
      boneMass: ScaleCalculate.instance.getBoneMass(
        gender,
        weight!,
        height,
        age,
        impedance!,
      ),
      gender: gender,
      height: height,
      impedance: impedance,
      isManuel: false,
      measurementComplete: measurementComplete,
      muscle: ScaleCalculate.instance.getMuscle(
        gender,
        weight!,
        height,
        age,
        impedance!,
      ),
      unit: unit,
      visceralFat: ScaleCalculate.instance.getVisceralFat(
        weight: weight!,
        height: height,
        age: age,
        gender: gender,
        impedance: impedance!,
      ),
      water: ScaleCalculate.instance.getWater(
        weight: weight!,
        height: height,
        age: age,
        gender: gender,
        impedance: impedance!,
      ),
      weight: weight,
      weightRemoved: weightRemoved,
      weightStabilized: weightStabilized,
      deviceId: device?['deviceId'] ?? "",
      bmh: ScaleCalculate.instance.getBMH(
        gender: gender,
        weight: weight!,
        height: height,
        age: age,
      ),
    );
  }
}
