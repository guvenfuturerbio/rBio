class GetMyPatientFilter {
  String? start;
  String? end;
  int? skip;
  int? take;

  GetMyPatientFilter({
    this.start,
    this.end,
    this.skip,
    this.take,
  });

  factory GetMyPatientFilter.fromJson(Map<String, dynamic> json) =>
      GetMyPatientFilter(
        start: json['start'] as String?,
        end: json['end'] as String?,
        skip: json['skip'] as int?,
        take: json['take'] as int?,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (start != null) {
      map['start'] = start;
    }
    if (end != null) {
      map['end'] = end;
    }
    if (skip != null) {
      map['skip'] = skip;
    }
    if (take != null) {
      map['take'] = take;
    }
    return map;
  }
}
