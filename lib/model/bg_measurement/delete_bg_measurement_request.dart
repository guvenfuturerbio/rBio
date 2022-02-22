import 'package:json_annotation/json_annotation.dart';
part 'delete_bg_measurement_request.g.dart';

@JsonSerializable()
class DeleteBloodGlucoseMeasurementRequest {
  @JsonKey(name: 'entegration_id')
  int? entegrationId;
  @JsonKey(name: 'measurement_id')
  int? measurementId;

  DeleteBloodGlucoseMeasurementRequest({
    this.entegrationId,
    this.measurementId,
  });

  factory DeleteBloodGlucoseMeasurementRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DeleteBloodGlucoseMeasurementRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DeleteBloodGlucoseMeasurementRequestToJson(this);
}
