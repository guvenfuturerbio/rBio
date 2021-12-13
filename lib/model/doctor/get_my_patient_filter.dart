class GetMyPatientFilter {
  String start;
  String end;
  String skip;
  String take;

  GetMyPatientFilter({
    this.start,
    this.end,
    this.skip,
    this.take,
  });

  factory GetMyPatientFilter.fromJson(Map<String, dynamic> json) =>
      GetMyPatientFilter(
        start: json['start'] as String,
        end: json['end'] as String,
        skip: json['skip'] as String,
        take: json['take'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'start': start,
        'end': end,
        'skip': skip,
        'take': take,
      };
}
