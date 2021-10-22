class CancelAppointmentRequest {
  int id;
  int cancellationReasonId;
  String cancellationNote;

  CancelAppointmentRequest({
    this.id,
    this.cancellationReasonId,
    this.cancellationNote,
  });

  factory CancelAppointmentRequest.fromJson(Map<String, dynamic> json) =>
      CancelAppointmentRequest(
        id: json['id'] as int,
        cancellationReasonId: json['cancellationReasonId'] as int,
        cancellationNote: json['cancellationNote'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'cancellationReasonId': cancellationReasonId,
        'cancellationNote': cancellationNote,
      };
}
