class CheckPaymentRequest {
  int appointmentId;

  CheckPaymentRequest({
    this.appointmentId,
  });

  CheckPaymentRequest.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointmentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentId'] = this.appointmentId;
    return data;
  }
}
