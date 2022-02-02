class UpdateMyPatientLimit {
  int? rangeMin;
  int? rangeMax;
  int? hyper;
  int? hypo;
  String? treatment;

  UpdateMyPatientLimit({
    this.rangeMin,
    this.rangeMax,
    this.hyper,
    this.hypo,
    this.treatment,
  });

  factory UpdateMyPatientLimit.fromJson(Map<String, dynamic> json) =>
      UpdateMyPatientLimit(
        rangeMin: json['range_min'] as int?,
        rangeMax: json['range_max'] as int?,
        hyper: json['hyper'] as int?,
        hypo: json['hypo'] as int?,
        treatment: json['treatment'] as String?,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'range_min': rangeMin,
      'range_max': rangeMax,
      'hyper': hyper,
      'hypo': hypo,
    };
    if (treatment != null) {
      map['treatment'] = treatment;
    }
    return map;
  }
}
