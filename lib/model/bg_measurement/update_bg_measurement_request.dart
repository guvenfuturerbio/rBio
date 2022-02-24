import 'package:json_annotation/json_annotation.dart';

part 'update_bg_measurement_request.g.dart';

@JsonSerializable()
class UpdateBloodGlucoseMeasurementRequest {
  @JsonKey(name: 'entegration_id')
  int? entegrationId;

  @JsonKey(name: 'measurement_id')
  int? measurementId;

  @JsonKey(name: 'measurement_tag')
  int? tag;

  @JsonKey(name: 'measurement_value')
  int? value;

  @JsonKey(name: 'measurement_type')
  String? type;

  @JsonKey(name: 'measurement_note')
  String? note;

  @JsonKey(name: 'occurrence')
  String? date;

  UpdateBloodGlucoseMeasurementRequest({
    this.entegrationId,
    this.measurementId,
    this.tag,
    this.value,
    this.type,
    this.note,
    this.date,
  });

  factory UpdateBloodGlucoseMeasurementRequest.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateBloodGlucoseMeasurementRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UpdateBloodGlucoseMeasurementRequestToJson(this);
}
