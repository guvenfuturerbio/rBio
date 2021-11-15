

import 'package:json_annotation/json_annotation.dart';
part 'strip_detail_model.g.dart';

@JsonSerializable()
class StripDetailModel {
  @JsonKey(name: "device_UUID")
  String deviceUUID;
  @JsonKey(name: "current_count")
  int currentCount;
  @JsonKey(name: "alarm_count")
  int alarmCount;
  @JsonKey(name: "entegration_id")
  int entegrationId;
  @JsonKey(name: "is_active")
  bool isNotificationActive;

  StripDetailModel({
    this.deviceUUID = "",
    this.currentCount = 0,
    this.alarmCount = 0,
    this.entegrationId = 0,
    this.isNotificationActive = true
  });

  factory StripDetailModel.fromJson(Map<String, dynamic> json) => _$StripDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$StripDetailModelToJson(this);

  @override
  String toString() {
    return "Current count: $currentCount, Alarm count: $alarmCount, isActive: $isNotificationActive, UUID: $deviceUUID, Entegration ID: $entegrationId";
  }
}