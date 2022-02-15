class AppointmentFilter {
  String? type;
  String? start;
  String? end;

  AppointmentFilter({
    this.type,
    this.start,
    this.end,
  });

  factory AppointmentFilter.fromJson(Map<String, dynamic> json) =>
      AppointmentFilter(
        type: json['type'] as String?,
        start: json['start'] as String?,
        end: json['end'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'start': start,
        'end': end,
      };
}
