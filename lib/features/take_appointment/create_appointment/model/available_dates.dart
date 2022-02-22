class AvailableDate {
  bool? available;
  String? day;

  AvailableDate({
    this.available,
    this.day,
  });

  Map<String, dynamic> toJson() => {
        'available': available,
        'day': day,
      };

  factory AvailableDate.fromJson(Map<String, dynamic> json) => AvailableDate(
        available: json['available'] as bool?,
        day: json['day'] as String?,
      );
}
