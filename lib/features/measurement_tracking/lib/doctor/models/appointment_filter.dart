import 'package:json_annotation/json_annotation.dart';

part 'appointment_filter.g.dart';

@JsonSerializable()
class AppointmentFilter {
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'start')
  String start;
  @JsonKey(name: 'end')
  String end;

  AppointmentFilter({
    this.type,
    this.start,
    this.end
  });

  factory AppointmentFilter.fromJson(Map<String, dynamic> json) => _$AppointmentFilterFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentFilterToJson(this);
}


