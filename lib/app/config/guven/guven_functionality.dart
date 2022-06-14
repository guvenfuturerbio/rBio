part of '../abstract/app_config.dart';

class GuvenFunctionality extends IAppFunctionality {
  @override
  bool get chronicTracking => false;

  @override
  bool get symptomChecker => false;

  @override
  bool get takeOnlineAppointment => true;

  @override
  bool get takeHospitalAppointment => true;

  @override
  bool get mediminder => false;

  @override
  bool get relatives => true;

  @override
  bool get createOnlineAppointmentWithCountrySelection => true;

  @override
  bool get magazines => true;

  @override
  bool get recaptcha => true;

  @override
  bool get bluetooth => true;
}
