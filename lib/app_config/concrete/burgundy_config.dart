part of '../app_config.dart';

class BurgundyConfig implements AppConfig {
  @override
  ITheme get theme => BurgundyTheme();

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
