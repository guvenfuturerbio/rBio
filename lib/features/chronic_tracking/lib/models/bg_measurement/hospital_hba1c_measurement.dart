
import 'package:json_annotation/json_annotation.dart';
part 'hospital_hba1c_measurement.g.dart';

@JsonSerializable()
class HospitalHba1cMeasurementModel {
  @JsonKey(name: 'value')
  double value;
  @JsonKey(name: 'date')
  String date;
  @JsonKey(name: 'note')
  String note;

  HospitalHba1cMeasurementModel(
      {this.value, this.date, this.note});

  factory HospitalHba1cMeasurementModel.fromJson(Map<String, dynamic> json) => _$HospitalHba1cMeasurementModelFromJson(json);

  Map<String, dynamic> toJson() => _$HospitalHba1cMeasurementModelToJson(this);
}