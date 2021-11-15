class Part {
  String startDateTime;
  String endDateTime;
  int interval;

  Part({this.startDateTime, this.endDateTime, this.interval});

  Part.fromJson(Map<String, dynamic> json) {
    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
    interval = json['interval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date_time'] = this.startDateTime;
    data['end_date_time'] = this.endDateTime;
    data['interval'] = this.interval;
    return data;
  }
}