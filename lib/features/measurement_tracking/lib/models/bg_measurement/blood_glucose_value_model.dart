import 'package:json_annotation/json_annotation.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/bg_measurement/blood_glucose_value_detail_model.dart';
part 'blood_glucose_value_model.g.dart';

@JsonSerializable()
class BloodGlucoseValue {
  @JsonKey(name: 'entegration_id')
  int id;
  @JsonKey(name: 'value')
  String value;
  @JsonKey(name: 'value_type')
  String valueType;
  @JsonKey(name: 'value_note')
  String valueNote;
  @JsonKey(name: 'detail')
  BloodGlucoseValueDetail detail;
  @JsonKey(name: 'is_manual')
  bool isManual;
  @JsonKey(name: 'device_uuid')
  String deviceUUID;

  BloodGlucoseValue(
      {this.value,
      this.valueType = "mg",
      this.valueNote = "",
      this.detail,
      this.id,
      this.isManual,
      this.deviceUUID});

  factory BloodGlucoseValue.fromJson(Map<String, dynamic> json) =>
      _$BloodGlucoseValueFromJson(json);

  Map<String, dynamic> toJson() => _$BloodGlucoseValueToJson(this);
}
