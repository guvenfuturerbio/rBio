
import 'package:json_annotation/json_annotation.dart';
part 'get_hba1c_measurement_list.g.dart';

@JsonSerializable()
class GetHba1cMeasurementListModel {
  @JsonKey(name: 'start')
  double start;
  @JsonKey(name: 'end')
  String end;
  @JsonKey(name: 'skip')
  int skip;
  @JsonKey(name: 'take')
  int take;

  GetHba1cMeasurementListModel(
      {this.start, this.end, this.skip, this.take});

  factory GetHba1cMeasurementListModel.fromJson(Map<String, dynamic> json) => _$GetHba1cMeasurementListModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetHba1cMeasurementListModelToJson(this);
}