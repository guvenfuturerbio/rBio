// ignore_for_file: non_constant_identifier_names

class ScaleTreatmentRequest {
  final int? count;
  final String? start_Date;
  final String? end_Date;

  ScaleTreatmentRequest({
    this.count,
    this.start_Date,
    this.end_Date,
  });

  ScaleTreatmentRequest copyWith({
    int? count,
    String? start_Date,
    String? end_Date,
  }) {
    return ScaleTreatmentRequest(
      count: count ?? this.count,
      start_Date: start_Date ?? this.start_Date,
      end_Date: end_Date ?? this.end_Date,
    );
  }

  Map<String, dynamic> toJson() => {
        'count': count,
        'start_Date': start_Date,
        'end_Date': end_Date,
      };
}
