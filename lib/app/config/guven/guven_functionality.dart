part of '../abstract/app_config.dart';

class GuvenFunctionality extends IAppFunctionality {
  @override
  bool get chronicTracking => true;

  @override
  bool get symptomChecker => true;

  @override
  bool get takeOnlineAppointment => true;

  @override
  bool get takeHospitalAppointment => true;

  @override
  bool get mediminder => true;

  @override
  bool get relatives => true;

  @override
  bool get createOnlineAppointmentWithCountrySelection => false;

  @override
  bool get magazines => true;

  @override
  bool get recaptcha => false;

  @override
  bool get bluetooth => true;
}
