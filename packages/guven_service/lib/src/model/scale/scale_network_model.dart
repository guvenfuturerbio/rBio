import 'package:guven_service/guven_service.dart';
import 'package:json_annotation/json_annotation.dart';

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
    return 'ScaleNetworkModel(entegrationId: $entegrationId, occurrenceTime: $occurrenceTime, weight: $weight, bmi: $bmi, measurementId: $measurementId, water: $water, bodyFat: $bodyFat, visceralFat: $visceralFat, boneMass: $boneMass, muscle: $muscle, bmh: $bmh, scaleUnit: $scaleUnit, deviceId: $deviceId, isManuel: $isManuel, note: $note)';
  }
}
