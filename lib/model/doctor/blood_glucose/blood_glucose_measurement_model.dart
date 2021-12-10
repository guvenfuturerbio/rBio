class BloodGlucoseMeasurementModel {
  String value;
  String valueType;
  String valueNote;

  BloodGlucoseMeasurementModel({
    this.value,
    this.valueType,
    this.valueNote,
  });

  BloodGlucoseMeasurementModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    valueType = json['value_type'];
    valueNote = json['value_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['value_type'] = this.valueType;
    data['value_note'] = this.valueNote;
    return data;
  }
}
