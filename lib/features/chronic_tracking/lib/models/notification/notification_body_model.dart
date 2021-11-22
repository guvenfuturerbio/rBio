

import 'package:json_annotation/json_annotation.dart';
part 'notification_body_model.g.dart';

/*@JsonSerializable(genericArgumentFactories: true)
class NotificationBodyModel<T> {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'datum')
  T datum;

  NotificationBodyModel({
    this.id,
    this.datum
  });

  factory NotificationBodyModel.fromJson(Map<String, dynamic> json) => _$NotificationBodyModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationBodyModelToJson(this);
}*/


@JsonSerializable()
class PatientRangeChangeBody {
  @JsonKey(name: "from")
  int fromId;
  @JsonKey(name: "entegration_id")
  int entegrationId;
  @JsonKey(name: "normal_min")
  double normalMin;
  @JsonKey(name: "normal_max")
  double normalMax;
  @JsonKey(name: "alert_min")
  double alertMin;
  @JsonKey(name: "alert_max")
  double alertMax;

  PatientRangeChangeBody({
    this.fromId,
    this.entegrationId,
    this.normalMin,
    this.normalMax,
    this.alertMin,
    this.alertMax
  });

  factory PatientRangeChangeBody.fromJson(Map<String, dynamic> json) => _$PatientRangeChangeBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PatientRangeChangeBodyToJson(this);
}