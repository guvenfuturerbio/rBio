class LaboratoryPdfResultRequest {
  int? visitId;
  List<int>? processes;

  LaboratoryPdfResultRequest({
    this.processes,
    this.visitId,
  });

  factory LaboratoryPdfResultRequest.fromJson(Map<String, dynamic> json) =>
      LaboratoryPdfResultRequest(
        processes:
            (json['processes'] as List<dynamic>).map((e) => e as int).toList(),
        visitId: json['visitId'] as int?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'visitId': visitId,
        'processes': processes,
      };
}
