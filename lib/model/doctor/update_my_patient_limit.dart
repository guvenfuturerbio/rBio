class UpdateMyPatientLimit {
  int rangeMin;
  int rangeMax;
  int hyper;
  int hypo;

  UpdateMyPatientLimit({
    this.rangeMin,
    this.rangeMax,
    this.hyper,
    this.hypo,
  });

  factory UpdateMyPatientLimit.fromJson(Map<String, dynamic> json) =>
      UpdateMyPatientLimit(
        rangeMin: json['range_min'] as int,
        rangeMax: json['range_max'] as int,
        hyper: json['hyper'] as int,
        hypo: json['hypo'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'range_min': rangeMin,
        'range_max': rangeMax,
        'hyper': hyper,
        'hypo': hypo,
      };
}
