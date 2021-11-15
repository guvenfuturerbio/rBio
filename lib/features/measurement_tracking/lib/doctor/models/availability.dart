import 'part.dart';

class Availability {
  String startTime;
  String endTime;
  String dateTime;
  Part part;

  Availability({this.startTime, this.endTime, this.dateTime, this.part});

  Availability.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    dateTime = json['date_time'];
    part = json['part'] != null ? new Part.fromJson(json['part']) : null;
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