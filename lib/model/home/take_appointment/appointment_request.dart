import 'save_appointment_request.dart';

class AppointmentRequest {
  SaveAppointmentsRequest? saveAppointmentsRequest;
  String? voucherCode;
  AppointmentRequest({
    this.saveAppointmentsRequest,
    this.voucherCode,
  });

  factory AppointmentRequest.fromJson(Map<String, dynamic> json) =>
      AppointmentRequest(
        saveAppointmentsRequest: SaveAppointmentsRequest.fromJson(
          json['appointment'] as Map<String, dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'appointment': saveAppointmentsRequest,
        'voucherCode': voucherCode,
      };

  @override
  String toString() =>
      'AppointmentRequest(saveAppointmentsRequest: $saveAppointmentsRequest)';
}
