import 'dart:convert';

import 'package:scale_api/scale_api.dart';
import 'package:scale_health_impl/scale_health_impl.dart';
import 'package:scale_hive_impl/scale_hive_impl.dart';

String addScaleMasurementBodyToJson(AddScaleMasurementBody data) =>
    json.encode(data.toJson());

class AddScaleMasurementBody {
  int? entegrationId;
  DateTime? occurrenceTime;
  double? weight;
  double? bmi;
  double? water;
  double? bodyFat;
  double? visceralFat;
  double? boneMass;
  double? muscle;
  double? bmh;
  int? scaleUnit;
  String? note;
  bool? isManuel;
  String? deviceUUID;

  AddScaleMasurementBody({
    this.entegrationId,
    this.occurrenceTime,
    this.weight,
    this.bmi,
    this.water,
    this.bodyFat,
    this.visceralFat,
    this.boneMass,
    this.muscle,
    this.bmh,
    this.scaleUnit,
    this.note,
    this.isManuel,
    this.deviceUUID,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "entegration_id": entegrationId,
        "occurrence_time": occurrenceTime?.toIso8601String(),
        "weight": weight,
        "bmi": bmi,
        "water": water,
        "body_fat": bodyFat,
        "visceral_fat": visceralFat,
        "bone_mass": boneMass,
        "muscle": muscle,
        "bmh": bmh,
        "scale_unit": scaleUnit,
        "device_uuid": deviceUUID,
        "is_manual": isManuel,
        "note": note,
      };
}

extension AddScaleMasurementBodyExtension on AddScaleMasurementBody {
  ScaleHiveModel xToScaleHiveModel(int measurementId) {
    var localDate = occurrenceTime!.toIso8601String();
    localDate = (localDate.substring(0, localDate.length - 2)) + "+00:00";
    final lastDate = DateTime.parse(localDate).toUtc().millisecondsSinceEpoch.toString();

    return ScaleHiveModel(
      occurrenceTime: lastDate,
      measurementId: measurementId,
      bmh: bmh,
      bmi: bmi,
      bodyFat: bodyFat,
      boneMass: boneMass,
      deviceId: deviceUUID,
      entegrationId: entegrationId,
      isManuel: isManuel,
      muscle: muscle,
      note: note,
      scaleUnit: scaleUnit,
      visceralFat: visceralFat,
      water: water,
      weight: weight,
    );
  }

  ScaleHealthModel get xToScaleHealthModel => ScaleHealthModel(
        occurrenceTime: occurrenceTime?.millisecondsSinceEpoch.toString() ?? '',
        bmi: bmi,
        bodyFat: bodyFat,
        deviceId: deviceUUID,
        isManuel: isManuel,
        scaleUnit: scaleUnit.xToScaleUnit,
        weight: weight,
      );
}
