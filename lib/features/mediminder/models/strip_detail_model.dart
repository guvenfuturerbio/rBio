class StripDetailModel {
  String deviceUUID;
  int currentCount;
  int alarmCount;
  int entegrationId;
  bool isNotificationActive;

  StripDetailModel({
    this.deviceUUID = "",
    this.currentCount = 0,
    this.alarmCount = 0,
    this.entegrationId = 0,
    this.isNotificationActive = true,
  });

  factory StripDetailModel.fromJson(Map<String, dynamic> json) =>
      StripDetailModel(
        deviceUUID: json['device_UUID'] as String,
        currentCount: json['current_count'] as int,
        alarmCount: json['alarm_count'] as int,
        entegrationId: json['entegration_id'] as int,
        isNotificationActive: json['is_active'] as bool,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'device_UUID': deviceUUID,
        'current_count': currentCount,
        'alarm_count': alarmCount,
        'entegration_id': entegrationId,
        'is_active': isNotificationActive,
      };
}
