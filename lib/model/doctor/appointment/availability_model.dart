import 'part_model.dart';

class AvailabilityModel {
  String? startTime;
  String? endTime;
  String? dateTime;
  PartModel? part;

  AvailabilityModel({
    this.startTime,
    this.endTime,
    this.dateTime,
    this.part,
  });

  AvailabilityModel.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'] as String?;
    endTime = json['end_time'] as String?;
    dateTime = json['date_time'] as String?;
    part = json['part'] != null
        ? PartModel.fromJson(json['part'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['date_time'] = dateTime;
    if (part != null) {
      data['part'] = part?.toJson();
    }
    return data;
  }
}
