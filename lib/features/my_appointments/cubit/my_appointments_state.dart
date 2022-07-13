
part of 'my_appointments_cubit.dart';

enum MyAppointmentsBodyStatus {
  initial,
  loadingProgress,
  success,
  error,
}

enum MyAppointmentsOverlayStatus {
  initial,
  showErrorDialog,
  showProgressOverlay,
  joinMeeting,
  questionDialog,
  doPayment,
  showRateDialog
}

class MyAppointmentsState {
  DateTime? startDate;
  DateTime? endDate;
  MyAppointmentsBodyStatus bodyStatus;
  MyAppointmentsOverlayStatus overlayStatus;
  List<PatientAppointmentsResponse>? patientAppointments;
  String? webConsultantId;
  int? availabilityId;
  String? fromDate;
  PatientAppointmentsResponse? data;
  MyAppointmentsState({
    DateTime? startDate,
    DateTime? endDate,
    this.bodyStatus = MyAppointmentsBodyStatus.initial,
    this.overlayStatus = MyAppointmentsOverlayStatus.initial,
    this.patientAppointments,
    this.webConsultantId,
    this.availabilityId,
    this.fromDate,
    this.data,
  }) {
    this.startDate =
        startDate ?? DateTime.now().subtract(const Duration(days: 30));
    this.endDate = endDate ?? DateTime.now().add(const Duration(days: 30));
  }

  MyAppointmentsState copyWith(
      {DateTime? startDate,
      DateTime? endDate,
      MyAppointmentsBodyStatus? bodyStatus,
      MyAppointmentsOverlayStatus? overlayStatus,
      List<PatientAppointmentsResponse>? patientAppointments,
      String? webConsultantId,
      int? availabilityId,
      String? fromDate,
      PatientAppointmentsResponse? data}) {
    return MyAppointmentsState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      overlayStatus: overlayStatus ?? this.overlayStatus,
      bodyStatus: bodyStatus ?? this.bodyStatus,
      patientAppointments: patientAppointments ?? this.patientAppointments,
      webConsultantId: webConsultantId ?? this.webConsultantId,
      availabilityId: availabilityId ?? this.availabilityId,
      fromDate: fromDate ?? this.fromDate,
      data: data ?? this.data,
    );
  }
}
