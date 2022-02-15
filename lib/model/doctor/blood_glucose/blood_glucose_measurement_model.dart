class BloodGlucoseMeasurementModel {
  String? value;
  String? valueType;
  String? valueNote;

  BloodGlucoseMeasurementModel({
    this.value,
    this.valueType,
    this.valueNote,
  });

  BloodGlucoseMeasurementModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] as String?;
    valueType = json['value_type'] as String?;
    valueNote = json['value_note'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['value_type'] = valueType;
    data['value_note'] = valueNote;
    return data;
  }
}
