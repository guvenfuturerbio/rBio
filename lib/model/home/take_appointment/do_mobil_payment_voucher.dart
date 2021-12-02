import 'save_appointment_request.dart';
import 'e_randevu_cc_response.dart';

class DoMobilePaymentWithVoucherRequest {
  int appointmentId;
  SaveAppointmentsRequest appointmentRequest;
  ERandevuCCResponse cc;
  String voucherCode;
  DoMobilePaymentWithVoucherRequest(
      {this.appointmentId, this.appointmentRequest, this.cc, this.voucherCode});

  factory DoMobilePaymentWithVoucherRequest.fromJson(
          Map<String, dynamic> json) =>
      DoMobilePaymentWithVoucherRequest(
          appointmentId: json['appointmentId'] as int,
          appointmentRequest: SaveAppointmentsRequest.fromJson(
              json['appointment'] as Map<String, dynamic>),
          cc: ERandevuCCResponse.fromJson(json['cc'] as Map<String, dynamic>),
          voucherCode: json['voucherCode'] as String);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'appointmentId': appointmentId,
        'appointment': appointmentRequest,
        'cc': cc,
        'voucherCode': voucherCode
      };
}
