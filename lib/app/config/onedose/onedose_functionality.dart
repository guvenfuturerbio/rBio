part of '../abstract/app_config.dart';

class OneDoseFunctionality extends IAppFunctionality {
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
  bool get relatives => false;

  @override
  bool get createOnlineAppointmentWithCountrySelection => false;

  @override
  bool get magazines => false;

   @override
  bool get recaptcha => false;
}
