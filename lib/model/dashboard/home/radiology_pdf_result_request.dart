class RadiologyPdfRequest {
  int processId;

  RadiologyPdfRequest({
    this.processId,
  });

  factory RadiologyPdfRequest.fromJson(Map<String, dynamic> json) =>
      RadiologyPdfRequest(
        processId: json['processId'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'processId': processId,
      };
}
