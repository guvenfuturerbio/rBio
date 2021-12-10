import 'part_model.dart';

class AvailabilityModel {
  String startTime;
  String endTime;
  String dateTime;
  PartModel part;

  AvailabilityModel({
    this.startTime,
    this.endTime,
    this.dateTime,
    this.part,
  });

  AvailabilityModel.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    dateTime = json['date_time'];
    part = json['part'] != null ? new PartModel.fromJson(json['part']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['date_time'] = this.dateTime;
    if (this.part != null) {
      data['part'] = this.part.toJson();
    }
    return data;
  }
}
