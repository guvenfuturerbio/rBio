part of 'app_config.dart';

abstract class IAppFunctionality {
  bool get chronicTracking;
  bool get symptomChecker;
  bool get takeOnlineAppointment;
  bool get takeHospitalAppointment;
  bool get mediminder;
  bool get relatives;
  bool get createOnlineAppointmentWithCountrySelection;
  bool get magazines;
  bool get recaptcha;
}
