import 'save_appointment_request.dart';
import 'e_randevu_cc_response.dart';

class DoMobilePaymentRequest {
  int? appointmentId;
  SaveAppointmentsRequest? appointmentRequest;
  ERandevuCCResponse? cc;

  DoMobilePaymentRequest({
    this.appointmentId,
    this.appointmentRequest,
    this.cc,
  });

  factory DoMobilePaymentRequest.fromJson(Map<String, dynamic> json) =>
      DoMobilePaymentRequest(
        appointmentId: json['appointmentId'] as int?,
        appointmentRequest: SaveAppointmentsRequest.fromJson(
          json['appointment'] as Map<String, dynamic>,
        ),
        cc: ERandevuCCResponse.fromJson(json['cc'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'appointmentId': appointmentId,
        'appointment': appointmentRequest,
        'cc': cc,
      };
}
