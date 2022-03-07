import 'package:scale_api/scale_api.dart';

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

  double? bmi;
  double? water;
  double? bodyFat;
  double? visceralFat;
  double? boneMass;
  double? muscle;
  double? bmh;

  MiScaleModel({
    required this.dateTime,
    this.device,
    this.weight,
    this.weightStabilized,
    this.measurementComplete,
    this.weightRemoved,
    this.unit,
    this.impedance,
    this.bmi,
    this.water,
    this.bodyFat,
    this.visceralFat,
    this.boneMass,
    this.muscle,
    this.bmh,
  });
}
