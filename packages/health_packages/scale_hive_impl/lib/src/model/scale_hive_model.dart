import 'package:hive/hive.dart';
import 'package:scale_api/scale_api.dart';
import 'package:scale_repository/scale_repository.dart';

part 'scale_hive_model.g.dart';

@HiveType(typeId: 6)
class ScaleHiveModel extends HiveObject {
  @HiveField(0)
  int? entegrationId;

  @HiveField(1)
  String occurrenceTime;

  @HiveField(2)
  double? weight;

  @HiveField(3)
  double? bmi;

  @HiveField(4)
  int? measurementId;

  @HiveField(5)
  double? water;

  @HiveField(6)
  double? bodyFat;

  @HiveField(7)
  double? visceralFat;

  @HiveField(8)
  double? boneMass;

  @HiveField(9)
  double? muscle;

  @HiveField(10)
  double? bmh;

  @HiveField(11)
  int? scaleUnit;

  @HiveField(12)
  String? deviceId;

  @HiveField(13)
  bool? isManuel;

  @HiveField(14)
  String? note;

  ScaleHiveModel({
    this.entegrationId,
    required this.occurrenceTime,
    this.weight,
    this.bmi,
    this.measurementId,
    this.water,
    this.bodyFat,
    this.visceralFat,
    this.boneMass,
    this.muscle,
    this.bmh,
    this.scaleUnit,
    this.deviceId,
    this.isManuel,
    this.note,
  });

  ScaleHiveModel copyWith({
    int? entegrationId,
    String? occurrenceTime,
    double? weight,
    double? bmi,
    int? measurementId,
    double? water,
    double? bodyFat,
    double? visceralFat,
    double? boneMass,
    double? muscle,
    double? bmh,
    int? scaleUnit,
    String? deviceId,
    bool? isManuel,
    String? note,
  }) {
    return ScaleHiveModel(
      entegrationId: entegrationId ?? this.entegrationId,
      occurrenceTime: occurrenceTime ?? this.occurrenceTime,
      weight: weight ?? this.weight,
      bmi: bmi ?? this.bmi,
      measurementId: measurementId ?? this.measurementId,
      water: water ?? this.water,
      bodyFat: bodyFat ?? this.bodyFat,
      visceralFat: visceralFat ?? this.visceralFat,
      boneMass: boneMass ?? this.boneMass,
      muscle: muscle ?? this.muscle,
      bmh: bmh ?? this.bmh,
      scaleUnit: scaleUnit ?? this.scaleUnit,
      deviceId: deviceId ?? this.deviceId,
      isManuel: isManuel ?? this.isManuel,
      note: note ?? this.note,
    );
  }

  @override
  String toString() {
    return 'ScaleHiveModel(entegrationId: $entegrationId, occurrenceTime: $occurrenceTime, weight: $weight, bmi: $bmi, measurementId: $measurementId, water: $water, bodyFat: $bodyFat, visceralFat: $visceralFat, boneMass: $boneMass, muscle: $muscle, bmh: $bmh, scaleUnit: $scaleUnit, deviceId: $deviceId, isManuel: $isManuel, note: $note)';
  }
}

extension ScaleHiveModelExtension on ScaleHiveModel {
  ScaleEntity xToChronicEntity(
    int age,
    int gender,
    int height, {
    int? impedance,
    bool? weightRemoved,
    bool? weightStabilized,
    bool? measurementComplete,
  }) {
    return ScaleEntity(
      dateTime: DateTime.fromMillisecondsSinceEpoch(
          int.tryParse(occurrenceTime) ?? 0,
          isUtc: true),
      entegrationId: entegrationId,
      measurementId: measurementId,
      age: age,
      bmi: bmi,
      bodyFat: bodyFat,
      boneMass: boneMass,
      gender: gender,
      height: height,
      isManuel: isManuel,
      muscle: muscle,
      note: note,
      unit: scaleUnit?.xToScaleUnit,
      visceralFat: visceralFat,
      water: water,
      weight: weight,
      impedance: impedance,
      weightRemoved: weightRemoved,
      weightStabilized: weightStabilized,
      measurementComplete: measurementComplete,
    );
  }
}
