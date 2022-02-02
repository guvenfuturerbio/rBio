class CheckPaymentRequest {
  int? appointmentId;

  CheckPaymentRequest({
    this.appointmentId,
  });

  CheckPaymentRequest.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointmentId'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentId'] = appointmentId;
    return data;
  }
}
