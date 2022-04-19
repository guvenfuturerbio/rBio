part of '../abstract/app_config.dart';

class GuvenFunctionality extends IAppFunctionality {
  @override
  bool get chronicTracking => true;

  @override
  bool get symptomChecker => true;

  @override
  bool get takeOnlineAppointment => false;

  @override
  bool get takeHospitalAppointment => false;

  @override
  bool get mediminder => true;
}
