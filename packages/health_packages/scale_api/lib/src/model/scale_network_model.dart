import 'package:json_annotation/json_annotation.dart';
import 'package:scale_api/scale_api.dart';

part 'scale_network_model.g.dart';

@JsonSerializable()
class ScaleNetworkModel {
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

  Map<String, dynamic> toJson() => _$ScaleNetworkModelToJson(this);

  ScaleNetworkModel fromJson(Map<String, dynamic> json) =>
      ScaleNetworkModel.fromJson(json);
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
}
