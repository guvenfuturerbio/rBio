import 'package:guven_service/guven_service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:scale_api/scale_api.dart';
import 'package:scale_hive_impl/scale_hive_impl.dart';

part 'scale_network_model.g.dart';

@JsonSerializable()
class ScaleNetworkModel extends IBaseModel<ScaleNetworkModel> {
  @JsonKey(name: "entegration_id")
  int? entegrationId;

  @JsonKey(name: "occurrence_time")
  String? occurrenceTime;

  @JsonKey(name: "weight")
  double? weight;

  @JsonKey(name: "bmi")
  double? bmi;

  @JsonKey(name: "measurement_id")
  int? measurementId;

  @JsonKey(name: "water")
  double? water;

  @JsonKey(name: "body_fat")
  double? bodyFat;

  @JsonKey(name: "visceral_fat")
  double? visceralFat;

  @JsonKey(name: "bone_mass")
  double? boneMass;

  @JsonKey(name: "muscle")
  double? muscle;

  @JsonKey(name: "bmh")
  double? bmh;

  @JsonKey(name: "scale_unit")
  int? scaleUnit;

  @JsonKey(name: "device_id")
  String? deviceId;

  @JsonKey(name: "is_manuel")
  bool? isManuel;

  @JsonKey(name: "bmi_measurements_image_list")
  List<String>? bmiMeasurementsImageList;

  @JsonKey(name: "note")
  String? note;

  ScaleNetworkModel({
    this.entegrationId,
    this.occurrenceTime,
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
    this.bmiMeasurementsImageList,
    this.note,
  });

  factory ScaleNetworkModel.fromJson(Map<String, dynamic> json) =>
      _$ScaleNetworkModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScaleNetworkModelToJson(this);

  @override
  ScaleNetworkModel fromJson(Map<String, dynamic> json) =>
      ScaleNetworkModel.fromJson(json);

  @override
  String toString() {
    return 'ScaleNetworkModel(entegrationId: $entegrationId, occurrenceTime: $occurrenceTime, weight: $weight, bmi: $bmi, measurementId: $measurementId, water: $water, bodyFat: $bodyFat, visceralFat: $visceralFat, boneMass: $boneMass, muscle: $muscle, bmh: $bmh, scaleUnit: $scaleUnit, deviceId: $deviceId, isManuel: $isManuel, bmiMeasurementsImageList: $bmiMeasurementsImageList, note: $note)';
  }
}

extension ScaleNetworkModelExt on ScaleNetworkModel {
  ScaleModel xToScaleModel() {
    return ScaleModel(
      weight: weight,
      isManuel: isManuel,
      note: note,
      water: water,
      bmi: bmi,
      bmh: bmh,
      bodyFat: bodyFat,
      boneMass: boneMass,
      muscle: muscle,
      measurementId: measurementId,
      visceralFat: visceralFat,
      dateTime: DateTime.parse(occurrenceTime ?? ''),
    );
  }

  ScaleHiveModel xToScaleHiveModel() {
    return ScaleHiveModel(
      occurrenceTime: DateTime.parse(occurrenceTime ?? '').millisecondsSinceEpoch.toString(),
      bmh: bmh,
      bmi: bmi,
      bmiMeasurementsImageList: bmiMeasurementsImageList,
      bodyFat: bodyFat,
      boneMass: boneMass,
      deviceId: deviceId,
      entegrationId: entegrationId,
      isManuel: isManuel,
      measurementId: measurementId,
      muscle: muscle,
      note: note,
      scaleUnit: scaleUnit,
      visceralFat: visceralFat,
      water: water,
      weight: weight,
    );
  }
}

extension ListScaleNetworkModelExt on List<ScaleNetworkModel> {
  List<ScaleHiveModel> get xToHiveList {
    List<ScaleHiveModel> result = [];
    for (var item in this) {
      result.add(item.xToScaleHiveModel());
    }
    return result;
  }
}
