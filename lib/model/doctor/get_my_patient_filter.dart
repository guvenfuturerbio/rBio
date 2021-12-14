class GetMyPatientFilter {
  String start;
  String end;
  int skip;
  int take;

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
        skip: json['skip'] as int,
        take: json['take'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'start': start,
        'end': end,
        'skip': skip,
        'take': take,
      };
}
